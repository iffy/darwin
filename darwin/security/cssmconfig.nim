##
##  Copyright (c) 2000-2001,2003-2004,2007,2011-2012 Apple Inc. All Rights Reserved.
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
##  cssmconfig.h -- Platform specific defines and typedefs for cdsa.
##

##  #if defined(TARGET_API_MAC_OS8) || defined(TARGET_API_MAC_CARBON) || defined(TARGET_API_MAC_OSX)

when defined(TARGET_OS_MAC):
else:
when not defined(_SINT64):
  type
    sint64* = int64_t
  const
    _SINT64* = true
when not defined(_UINT64):
  type
    uint64* = uint64_t
  const
    _UINT64* = true
when not defined(_SINT32):
  type
    sint32* = int32_t
  const
    _SINT32* = true
when not defined(_SINT16):
  type
    sint16* = int16_t
  const
    _SINT16* = true
when not defined(_SINT8):
  type
    sint8* = int8_t
  const
    _SINT8* = true
when not defined(_UINT32):
  type
    uint32* = uint32_t
  const
    _UINT32* = true
when not defined(_UINT16):
  type
    uint16* = uint16_t
  const
    _UINT16* = true
when not defined(_UINT8):
  type
    uint8* = uint8_t
  const
    _UINT8* = true
type
  CSSM_INTPTR* = intptr_t
  CSSM_SIZE* = csize

const
  CSSMACI* = true
  CSSMAPI* = true
  CSSMCLI* = true
  CSSMCSPI* = true
  CSSMDLI* = true
  CSSMKRI* = true
  CSSMSPI* = true
  CSSMTPI* = true
