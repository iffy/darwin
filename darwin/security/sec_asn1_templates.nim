##
##  Copyright (c) 2003-2006,2008,2010-2012 Apple Inc. All Rights Reserved.
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
##  SecAsn1Templates.h - Common ASN1 primitive templates for use with SecAsn1Coder.
##

## **********************************************************************
##
##  Generic Templates
##  One for each of the simple types, plus a special one for ANY, plus:
## 	- a pointer to each one of those
## 	- a set of each one of those
## 	- a sequence of each one of those
##

var kSecAsn1AnyTemplate*: ptr SecAsn1Template

var kSecAsn1BitStringTemplate*: ptr SecAsn1Template

var kSecAsn1BMPStringTemplate*: ptr SecAsn1Template

var kSecAsn1BooleanTemplate*: ptr SecAsn1Template

var kSecAsn1EnumeratedTemplate*: ptr SecAsn1Template

var kSecAsn1GeneralizedTimeTemplate*: ptr SecAsn1Template

var kSecAsn1IA5StringTemplate*: ptr SecAsn1Template

var kSecAsn1IntegerTemplate*: ptr SecAsn1Template

var kSecAsn1UnsignedIntegerTemplate*: ptr SecAsn1Template

var kSecAsn1NullTemplate*: ptr SecAsn1Template

var kSecAsn1ObjectIDTemplate*: ptr SecAsn1Template

var kSecAsn1OctetStringTemplate*: ptr SecAsn1Template

var kSecAsn1PrintableStringTemplate*: ptr SecAsn1Template

var kSecAsn1T61StringTemplate*: ptr SecAsn1Template

var kSecAsn1UniversalStringTemplate*: ptr SecAsn1Template

var kSecAsn1UTCTimeTemplate*: ptr SecAsn1Template

var kSecAsn1UTF8StringTemplate*: ptr SecAsn1Template

var kSecAsn1VisibleStringTemplate*: ptr SecAsn1Template

var kSecAsn1TeletexStringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToAnyTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToBitStringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToBMPStringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToBooleanTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToEnumeratedTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToGeneralizedTimeTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToIA5StringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToIntegerTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToNullTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToObjectIDTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToOctetStringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToPrintableStringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToT61StringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToUniversalStringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToUTCTimeTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToUTF8StringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToVisibleStringTemplate*: ptr SecAsn1Template

var kSecAsn1PointerToTeletexStringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfAnyTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfBitStringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfBMPStringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfBooleanTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfEnumeratedTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfGeneralizedTimeTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfIA5StringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfIntegerTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfNullTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfObjectIDTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfOctetStringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfPrintableStringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfT61StringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfUniversalStringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfUTCTimeTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfUTF8StringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfVisibleStringTemplate*: ptr SecAsn1Template

var kSecAsn1SequenceOfTeletexStringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfAnyTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfBitStringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfBMPStringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfBooleanTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfEnumeratedTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfGeneralizedTimeTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfIA5StringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfIntegerTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfNullTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfObjectIDTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfOctetStringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfPrintableStringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfT61StringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfUniversalStringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfUTCTimeTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfUTF8StringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfVisibleStringTemplate*: ptr SecAsn1Template

var kSecAsn1SetOfTeletexStringTemplate*: ptr SecAsn1Template

##
##  Template for skipping a subitem; only used when decoding.
##

var kSecAsn1SkipTemplate*: ptr SecAsn1Template
