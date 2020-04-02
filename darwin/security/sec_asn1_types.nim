##
##  The contents of this file are subject to the Mozilla Public
##  License Version 1.1 (the "License"); you may not use this file
##  except in compliance with the License. You may obtain a copy of
##  the License at http://www.mozilla.org/MPL/
##
##  Software distributed under the License is distributed on an "AS
##  IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
##  implied. See the License for the specific language governing
##  rights and limitations under the License.
##
##  The Original Code is the Netscape security libraries.
##
##  The Initial Developer of the Original Code is Netscape
##  Communications Corporation.  Portions created by Netscape are
##  Copyright (C) 1994-2000 Netscape Communications Corporation.  All
##  Rights Reserved.
##
##  Contributor(s):
##
##  Alternatively, the contents of this file may be used under the
##  terms of the GNU General Public License Version 2 or later (the
##  "GPL"), in which case the provisions of the GPL are applicable
##  instead of those above.  If you wish to allow use of your
##  version of this file only under the terms of the GPL and not to
##  allow others to use your version of this file under the MPL,
##  indicate your decision by deleting the provisions above and
##  replace them with the notice and other provisions required by
##  the GPL.  If you do not delete the provisions above, a recipient
##  may use your version of this file under either the MPL or the
##  GPL.
##
##
##  Types for encoding/decoding of ASN.1 using BER/DER (Basic/Distinguished
##  Encoding Rules).
##

type
  SecAsn1Item* {.bycopy.} = object
    Length*: csize
    Data*: ptr uint8_t

  SecAsn1Oid* = SecAsn1Item
  SecAsn1AlgId* {.bycopy.} = object
    algorithm*: SecAsn1Oid
    parameters*: SecAsn1Item

  SecAsn1PubKeyInfo* {.bycopy.} = object
    algorithm*: SecAsn1AlgId
    subjectPublicKey*: SecAsn1Item


##
##  An array of these structures defines a BER/DER encoding for an object.
##
##  The array usually starts with a dummy entry whose kind is SEC_ASN1_SEQUENCE;
##  such an array is terminated with an entry where kind == 0.  (An array
##  which consists of a single component does not require a second dummy
##  entry -- the array is only searched as long as previous component(s)
##  instruct it.)
##

type
  SecAsn1Template* {.bycopy.} = object
    kind*: uint32_t ##
                  ##  Kind of item being decoded/encoded, including tags and modifiers.
                  ##
    ##
    ##  This value is the offset from the base of the structure (i.e., the
    ##  (void *) passed as 'src' to SecAsn1EncodeItem, or the 'dst' argument
    ##  passed to SecAsn1CoderRef()) to the field that holds the value being
    ##  decoded/encoded.
    ##
    offset*: uint32_t ##
                    ##  When kind suggests it (e.g., SEC_ASN1_POINTER, SEC_ASN1_GROUP,
                    ##  SEC_ASN1_INLINE, or a component that is *not* a SEC_ASN1_UNIVERSAL),
                    ##  this points to a sub-template for nested encoding/decoding.
                    ##  OR, iff SEC_ASN1_DYNAMIC is set, then this is a pointer to a pointer
                    ##  to a function which will return the appropriate template when called
                    ##  at runtime.  NOTE! that explicit level of indirection, which is
                    ##  necessary because ANSI does not allow you to store a function
                    ##  pointer directly as a "void *" so we must store it separately and
                    ##  dereference it to get at the function pointer itself.
                    ##
    sub*: pointer ##
                ##  In the first element of a template array, the value is the size
                ##  of the structure to allocate when this template is being referenced
                ##  by another template via SEC_ASN1_POINTER or SEC_ASN1_GROUP.
                ##  In all other cases, the value is ignored.
                ##
    size*: uint32_t


##
##  BER/DER values for ASN.1 identifier octets.
##

const
  SEC_ASN1_TAG_MASK* = 0x000000FF

##
##  BER/DER universal type tag numbers.
##

const
  SEC_ASN1_TAGNUM_MASK* = 0x0000001F
  SEC_ASN1_BOOLEAN* = 0x00000001
  SEC_ASN1_INTEGER* = 0x00000002
  SEC_ASN1_BIT_STRING* = 0x00000003
  SEC_ASN1_OCTET_STRING* = 0x00000004
  SEC_ASN1_NULL* = 0x00000005
  SEC_ASN1_OBJECT_ID* = 0x00000006
  SEC_ASN1_OBJECT_DESCRIPTOR* = 0x00000007

##  External type and instance-of type   0x08

const
  SEC_ASN1_REAL* = 0x00000009
  SEC_ASN1_ENUMERATED* = 0x0000000A
  SEC_ASN1_EMBEDDED_PDV* = 0x0000000B
  SEC_ASN1_UTF8_STRING* = 0x0000000C

##  not used                         0x0d
##  not used                         0x0e
##  not used                         0x0f

const
  SEC_ASN1_SEQUENCE* = 0x00000010
  SEC_ASN1_SET* = 0x00000011
  SEC_ASN1_NUMERIC_STRING* = 0x00000012
  SEC_ASN1_PRINTABLE_STRING* = 0x00000013
  SEC_ASN1_T61_STRING* = 0x00000014
  SEC_ASN1_VIDEOTEX_STRING* = 0x00000015
  SEC_ASN1_IA5_STRING* = 0x00000016
  SEC_ASN1_UTC_TIME* = 0x00000017
  SEC_ASN1_GENERALIZED_TIME* = 0x00000018
  SEC_ASN1_GRAPHIC_STRING* = 0x00000019
  SEC_ASN1_VISIBLE_STRING* = 0x0000001A
  SEC_ASN1_GENERAL_STRING* = 0x0000001B
  SEC_ASN1_UNIVERSAL_STRING* = 0x0000001C

##  not used							0x1d

const
  SEC_ASN1_BMP_STRING* = 0x0000001E
  SEC_ASN1_HIGH_TAG_NUMBER* = 0x0000001F
  SEC_ASN1_TELETEX_STRING* = SEC_ASN1_T61_STRING

##
##  Modifiers to type tags.  These are also specified by a/the
##  standard, and must not be changed.
##

const
  SEC_ASN1_METHOD_MASK* = 0x00000020
  SEC_ASN1_PRIMITIVE* = 0x00000000
  SEC_ASN1_CONSTRUCTED* = 0x00000020
  SEC_ASN1_CLASS_MASK* = 0x000000C0
  SEC_ASN1_UNIVERSAL* = 0x00000000
  SEC_ASN1_APPLICATION* = 0x00000040
  SEC_ASN1_CONTEXT_SPECIFIC* = 0x00000080
  SEC_ASN1_PRIVATE* = 0x000000C0

##
##  Our additions, used for templates.
##  These are not defined by any standard; the values are used internally only.
##  Just be careful to keep them out of the low 8 bits.
##

const
  SEC_ASN1_OPTIONAL* = 0x00000100
  SEC_ASN1_EXPLICIT* = 0x00000200
  SEC_ASN1_ANY* = 0x00000400
  SEC_ASN1_INLINE* = 0x00000800
  SEC_ASN1_POINTER* = 0x00001000
  SEC_ASN1_GROUP* = 0x00002000
  SEC_ASN1_DYNAMIC* = 0x00004000
  SEC_ASN1_SKIP* = 0x00008000
  SEC_ASN1_INNER* = 0x00010000
  SEC_ASN1_SAVE* = 0x00020000
  SEC_ASN1_SKIP_REST* = 0x00080000
  SEC_ASN1_CHOICE* = 0x00100000

##
##  Indicate that a type SEC_ASN1_INTEGER is actually signed.
##  The default is unsigned, which causes a leading zero to be
##  encoded if the MS bit of the source data is 1.
##

const
  SEC_ASN1_SIGNED_INT* = 0x00800000

##  Shorthand/Aliases

const
  SEC_ASN1_SEQUENCE_OF* = (SEC_ASN1_GROUP or SEC_ASN1_SEQUENCE)
  SEC_ASN1_SET_OF* = (SEC_ASN1_GROUP or SEC_ASN1_SET)
  SEC_ASN1_ANY_CONTENTS* = (SEC_ASN1_ANY or SEC_ASN1_INNER)

##
##  Function used for SEC_ASN1_DYNAMIC.
##  "arg"  is a pointer to the top-level structure being encoded or
##         decoded.
##
##  "enc"  when true, means that we are encoding (false means decoding)
##
##  "buf"  For decode only; points to the start of the decoded data for
##         the current template. Callee can use the tag at this location
##         to infer the returned template. Not used on encode.
##
##  "len"  For decode only; the length of buf.
##
##  "Dest" points to the template-specific item being decoded to
##         or encoded from. (This is as opposed to arg, which
##         points to the start of the struct associated with the
##         current array of templates).
##

type
  SecAsn1TemplateChooser* = proc (arg: pointer; enc: Boolean; buf: cstring; len: csize;
                               dest: pointer): ptr SecAsn1Template
  SecAsn1TemplateChooserPtr* = ptr SecAsn1TemplateChooser
