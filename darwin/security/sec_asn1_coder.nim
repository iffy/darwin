##
##  Copyright (c) 2003-2006,2008-2013 Apple Inc. All Rights Reserved.
##
##  @APPLE_LICENSE_HEADER_START@
##
##  This file contains Original Code and/or Modifications of Original Code
##  as defined in and that are subject to the Apple Public Source License
##  Version 2.0 (the 'License'). You may not use this file except in
##  compliance with the License. Please obtain a copy of the License at
##  http://www.opensource.apple.com/apsl/ and read it before using this
##  file.
##
##  The Original Code and all software distributed under the License are
##  distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
##  EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
##  INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
##  FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
##  Please see the License for the specific language governing rights and
##  limitations under the License.
##
##  @APPLE_LICENSE_HEADER_END@
##
##  SecAsn1Coder.h: ANS1 encode/decode object.
##
##  A SecAsn1Coder is capable of encoding and decoding both DER and BER data
##  streams, based on caller-supplied templates which in turn are based
##  upon ASN.1 specifications. A SecAsn1Coder allocates memory during encode
##  and decode using a memory pool which is owned and managed by the SecAsn1Coder
##  object, and which is freed when the SecAsn1Coder object os released.
##

##
##  Opaque reference to a SecAsn1Coder object.
##

type
  SecAsn1CoderRef* = ptr SecAsn1Coder

##
##  Create/destroy SecAsn1Coder object.
##

proc SecAsn1CoderCreate*(coder: ptr SecAsn1CoderRef): OSStatus
proc SecAsn1CoderRelease*(coder: SecAsn1CoderRef): OSStatus
##
##  DER decode an untyped item per the specified template array.
##  The result is allocated in this SecAsn1Coder's memory pool and
##  is freed when this object is released.
##
##  The templates argument points to a an array of SecAsn1Templates
##  defining the object to be decoded; the end of the array is
##  indicated by a SecAsn1Template with file kind equalling 0.
##
##  The dest pointer is a template-specific struct allocated by the caller
##  and must be zeroed by the caller.
##
##  Returns errSecUnknownFormat on decode-specific error.
##

proc SecAsn1Decode*(coder: SecAsn1CoderRef; src: pointer; len: csize;
                   templates: ptr SecAsn1Template; dest: pointer): OSStatus
  ##  DER-encoded source
##
##  Convenience routine, decode from a SecAsn1Item.
##

proc SecAsn1DecodeData*(coder: SecAsn1CoderRef; src: ptr SecAsn1Item;
                       templ: ptr SecAsn1Template; dest: pointer): OSStatus
##
##  DER encode. The encoded data (in dest.Data) is allocated in this
##  SecAsn1Coder's memory pool and is freed when this object is released.
##
##  The src pointer is a template-specific struct.
##
##  The templates argument points to a an array of SecAsn1Templates
##  defining the object to be decoded; the end of the array is
##  indicated by a SecAsn1Template with file kind equalling 0.
##

proc SecAsn1EncodeItem*(coder: SecAsn1CoderRef; src: pointer;
                       templates: ptr SecAsn1Template; dest: ptr SecAsn1Item): OSStatus
##
##  Some alloc-related methods which come in handy when using
##  this object. All memory is allocated using this object's
##  memory pool. Caller never has to free it. Used for
##  temp allocs of memory which only needs a scope which is the
##  same as this object.
##
##  All except SecAsn1Malloc return a errSecAllocate in the highly
##  unlikely event of a malloc failure.
##
##  SecAsn1Malloc() returns a pointer to allocated memory, like
##  malloc().
##

proc SecAsn1Malloc*(coder: SecAsn1CoderRef; len: csize): pointer
##  Allocate item.Data, set item.Length

proc SecAsn1AllocItem*(coder: SecAsn1CoderRef; item: ptr SecAsn1Item; len: csize): OSStatus
##  Allocate and copy, various forms

proc SecAsn1AllocCopy*(coder: SecAsn1CoderRef; src: pointer; len: csize;
                      dest: ptr SecAsn1Item): OSStatus
  ##  memory copied from here
  ##  length to allocate & copy
##  dest->Data allocated and copied to;
##    dest->Length := len

proc SecAsn1AllocCopyItem*(coder: SecAsn1CoderRef; src: ptr SecAsn1Item;
                          dest: ptr SecAsn1Item): OSStatus
  ##  src->Length bytes allocated and copied from
  ##    src->Data
##  dest->Data allocated and copied to;
##    dest->Length := src->Length
##  Compare two decoded OIDs.  Returns true iff they are equivalent.

proc SecAsn1OidCompare*(oid1: ptr SecAsn1Oid; oid2: ptr SecAsn1Oid): bool