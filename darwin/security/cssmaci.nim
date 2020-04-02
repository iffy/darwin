##
##  Copyright (c) 1999-2001,2004,2011,2014 Apple Inc. All Rights Reserved.
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
##  cssmaci.h -- Sevice Provider Interface for Access Control Module
##

type
  CSSM_SPI_AC_FUNCS* {.bycopy.} = object
    AuthCompute*: proc (ACHandle: CSSM_AC_HANDLE;
                      BaseAuthorizations: ptr CSSM_TUPLEGROUP;
                      Credentials: ptr CSSM_TUPLEGROUP; NumberOfRequestors: uint32;
                      Requestors: ptr CSSM_LIST;
                      RequestedAuthorizationPeriod: ptr CSSM_LIST;
                      RequestedAuthorization: ptr CSSM_LIST;
                      AuthorizationResult: CSSM_TUPLEGROUP_PTR): CSSM_RETURN
    PassThrough*: proc (ACHandle: CSSM_AC_HANDLE; TPHandle: CSSM_TP_HANDLE;
                      CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                      DBList: ptr CSSM_DL_DB_LIST; PassThroughId: uint32;
                      InputParams: pointer; OutputParams: ptr pointer): CSSM_RETURN

  CSSM_SPI_AC_FUNCS_PTR* = ptr CSSM_SPI_AC_FUNCS
