import os
import osproc
import strutils
import algorithm
import re

let frameworks = [
  (name: "Security", dst: "darwin/security", skips: @[
    "SecProtocolObject.h", # Can't figure out ## syntax
    "SecureTransport.h", # The defs/undefs are tricky
    "certextensions.h", # There's one case of terrible if/def nesting
    # css not worth the trouble right now
    "cssm.h",
    "cssmaci.h",
    "cssmapi.h",
    "cssmapple.h",
    "cssmcli.h",
    "cssmconfig.h",
    "cssmcspi.h",
    "cssmdli.h",
    "cssmerr.h",
    "cssmkrapi.h",
    "cssmkrspi.h",
    "cssmspi.h",
    "cssmtpi.h",
    "cssmtype.h",
    "emmspi.h",
    "emmtype.h"
  ]),
]

const c2nim_prefix = """
#ifdef C2NIM
# def DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER
# def AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_6
# def CF_ASSUME_NONNULL_BEGIN
# def CF_ASSUME_NONNULL_END
# def SEC_ASSUME_NONNULL_BEGIN
# def SEC_ASSUME_NONNULL_END
# def CF_IMPLICIT_BRIDGING_ENABLED
# def CF_IMPLICIT_BRIDGING_DISABLED
# def CF_EXTERN_C_BEGIN
# def CF_EXTERN_C_END
# def __BEGIN_DECLS
# def __END_DECLS
# def __nullable
# def __nonnull
# def CF_CLOSED_ENUM(_type, _name) _type _name; enum
# def CF_OPTIONS(_type, _name) _type _name; enum
# def CF_RETURNS_RETAINED
# def CF_RETURNS_NOT_RETAINED
# def SEC_RETURNS_RETAINED
# def CSSM_DEPRECATED
# def CF_BRIDGED_TYPE(T) 
# def CF_BRIDGED_MUTABLE_TYPE(T)
# def CF_RELATED_TYPE(T,C,I)
# def CF_STRING_ENUM
# def OS_OBJECT_USE_OBJC 1
# def CF_EXPORT extern
# def CSSMAPI
# def CSSMACI
#endif
"""

# from https://forum.nim-lang.org/t/1701
proc camel2snake(s:string):string =
  ## CanBeFun => can_be_fun
  var last_upper = false
  for c in s:
    if c in {'A'..'Z'}:
      if result.len > 0 and not last_upper:
        result.add('_')
      result.add(($c).toLower())
      last_upper = true
    else:
      last_upper = false
      result.add(c)

const defs_to_remove = @[
  "__attribute__",
  "__API_AVAILABLE",
  "__API_DEPRECATED",
  "API_AVAILABLE",
  "API_UNAVAILABLE",
  "API_DEPRECATED_WITH_REPLACEMENT",
  "API_DEPRECATED",
  "__OSX_AVAILABLE",
  "__IOS_AVAILABLE",
  "__TVOS_AVAILABLE",
  "__WATCHOS_AVAILABLE",
  "__OSX_AVAILABLE_BUT_DEPRECATED_MSG",
  "__OSX_AVAILABLE_BUT_DEPRECATED",
  "__OSX_AVAILABLE_STARTING",
  "CF_ENUM_DEPRECATED",
  "CF_SWIFT_NAME",
  "CF_ENUM_AVAILABLE",
].sortedByIt(-it.len)


const strings_to_remove = @[
  "#define CSSM_DEPRECATED",
  "_Nullable",
  "#define  \\",
]

const replacements = @[
  ("#define __SECURETRANSPORT_API_DEPRECATED(...) \\", "#define __SECURETRANSPORT_API_DEPRECATED(...)")
]

proc parenBounds(s:string, start:int = 0):int =
  ## Given a string and a starting index that points
  ## to an opening paren, return the index of the corresponding closing paren
  var i = start
  var stack = 0
  while i < s.len:
    let ch = s[i]
    if ch == '(':
      stack.inc()
    elif ch == ')':
      stack.dec()
      if stack == 0:
        break
    i.inc()
  return i

proc doSingleFile(path:string, dst_path:string) =
  echo "--------------------------------"
  echo path
  echo "-> ", dst_path

  let
    tmpdir = "_build"
    tmpfile = tmpdir/path.extractFilename
  tmpdir.createDir()
  if not tmpfile.existsFile():
    var
      src:seq[string]
      dst:seq[string]
    src.add(c2nim_prefix)
    src.add(readFile(path).splitLines())

    for line in src:
      # line by line processing
      var line = line

      # def __CF_NAMED_ENUM(_type, _name) _type _name; enum
      # def __CF_ANON_ENUM(_type) enum
      line = line.replacef(re"CF_ENUM\((.*?),(.*?)\)", "$1 $2; enum")
      line = line.replacef(re"CF_ENUM\((.*?)\)", "enum")
      
      # Single-quote string enum values
      line = line.replacef(re"kSec(.*?)'(.*?)'(.*?)", "kSec$1\"$2\"$3")

      # ^ and % to * and &
      # https://stackoverflow.com/questions/202463/what-does-the-caret-mean-in-c-cli
      line = line.replace("^", "*")

      # hacks
      if "const *SecStaticCodeRef" in line:
        # c2nim can't guess what this line is supposed to be
        continue
      
      dst.add(line)
    var guts = dst.join("\n")

    for repl in replacements:
      guts = guts.replace(repl[0], repl[1])
    
    # remove some defines
    for def in defs_to_remove:
      while def in guts:
        let start = guts.find(def)
        let end_paren = guts.parenBounds(start)
        guts = guts.substr(0, start-1) & guts.substr(end_paren+1, guts.len+1)
    
    # remove some strings
    for snippet in strings_to_remove:
      while snippet in guts:
        guts = guts.replace(snippet, "")

    writeFile(tmpfile, guts)

  let cmd = ["c2nim",
    "-o:"&dst_path,
    "--assumendef:__BLOCKS__",
    tmpfile,
  ].join(" ")
  echo "# ", cmd
  if execCmd(cmd) != 0:
    quit(1)

proc doSingleFramework(src_dir:string, dst_dir:string, skips:seq[string]) =
  echo src_dir
  echo dst_dir
  var files:seq[string]
  for item in src_dir.walkDir:
    case item.kind
    of pcFile:
      if item.path.endsWith(".h"):
        files.add(item.path)
    else:
      discard
  files.sort()
  for path in files:
    let
      basename = path.extractFilename
      dst_path = dst_dir/basename.camel2snake.changeFileExt(".nim")
    if basename in skips:
      continue
    doSingleFile(path, dst_path)


proc doAll() =
  let src_dir = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/"
  for framework in frameworks:
    let framework_dir = src_dir / framework.name & ".framework" / "Headers"
    doSingleFramework(framework_dir, framework.dst, framework.skips)


if isMainModule:
  doAll()
