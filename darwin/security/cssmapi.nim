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
##  cssmapi.h -- Application Programmers Interfaces for CSSM
##

##  ==========================================================================
## 	W A R N I N G : CDSA has been deprecated starting with 10.7.  While the
## 	APIs will continue to work, developers should update their code to use
## 	the APIs that are suggested and NOT use the CDSA APIs
##    ==========================================================================

##  Core Functions
##  --------------------------------------------------------------------------
## 	CSSM_Init has been deprecated in 10.7 and later.  There is no alternate
## 	API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_Init*(Version: ptr CSSM_VERSION; Scope: CSSM_PRIVILEGE_SCOPE;
               CallerGuid: ptr CSSM_GUID; KeyHierarchy: CSSM_KEY_HIERARCHY;
               PvcPolicy: ptr CSSM_PVC_MODE; Reserved: pointer): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_Terminate has been deprecated in 10.7 and later.  There is no alternate
## 	API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_Terminate*(): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_ModuleLoad has been deprecated in 10.7 and later.  There is no
## 	alternate API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_ModuleLoad*(ModuleGuid: ptr CSSM_GUID; KeyHierarchy: CSSM_KEY_HIERARCHY;
                     AppNotifyCallback: CSSM_API_ModuleEventHandler;
                     AppNotifyCallbackCtx: pointer): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_ModuleUnload has been deprecated in 10.7 and later.  There is no
## 	alternate API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_ModuleUnload*(ModuleGuid: ptr CSSM_GUID;
                       AppNotifyCallback: CSSM_API_ModuleEventHandler;
                       AppNotifyCallbackCtx: pointer): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_Introduce has been deprecated in 10.7 and later.  There is no
## 	alternate API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_Introduce*(ModuleID: ptr CSSM_GUID; KeyHierarchy: CSSM_KEY_HIERARCHY): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_Unintroduce has been deprecated in 10.7 and later.  There is no
## 	alternate API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_Unintroduce*(ModuleID: ptr CSSM_GUID): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_ModuleAttach has been deprecated in 10.7 and later.  There is no
## 	alternate API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_ModuleAttach*(ModuleGuid: ptr CSSM_GUID; Version: ptr CSSM_VERSION;
                       MemoryFuncs: ptr CSSM_API_MEMORY_FUNCS;
                       SubserviceID: uint32; SubServiceType: CSSM_SERVICE_TYPE;
                       AttachFlags: CSSM_ATTACH_FLAGS;
                       KeyHierarchy: CSSM_KEY_HIERARCHY;
                       FunctionTable: ptr CSSM_FUNC_NAME_ADDR;
                       NumFunctionTable: uint32; Reserved: pointer;
                       NewModuleHandle: CSSM_MODULE_HANDLE_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_ModuleDetach has been deprecated in 10.7 and later.  There is no
## 	alternate API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_ModuleDetach*(ModuleHandle: CSSM_MODULE_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_SetPrivilege has been deprecated in 10.7 and later.  There is no alternate
## 	API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_SetPrivilege*(Privilege: CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GetPrivilege has been deprecated in 10.7 and later.  There is no
## 	alternate API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_GetPrivilege*(Privilege: ptr CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GetModuleGUIDFromHandle has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling CDSA
## 	APIs
##    --------------------------------------------------------------------------

proc CSSM_GetModuleGUIDFromHandle*(ModuleHandle: CSSM_MODULE_HANDLE;
                                  ModuleGUID: CSSM_GUID_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GetSubserviceUIDFromHandle has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling CDSA
## 	APIs
##    --------------------------------------------------------------------------

proc CSSM_GetSubserviceUIDFromHandle*(ModuleHandle: CSSM_MODULE_HANDLE;
                                     SubserviceUID: CSSM_SUBSERVICE_UID_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_ListAttachedModuleManagers has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling CDSA
## 	APIs
##    --------------------------------------------------------------------------

proc CSSM_ListAttachedModuleManagers*(NumberOfModuleManagers: ptr uint32;
                                     ModuleManagerGuids: CSSM_GUID_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GetAPIMemoryFunctions has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling CDSA
## 	APIs
##    --------------------------------------------------------------------------

proc CSSM_GetAPIMemoryFunctions*(AddInHandle: CSSM_MODULE_HANDLE;
                                AppMemoryFuncs: CSSM_API_MEMORY_FUNCS_PTR): CSSM_RETURN
##  Cryptographic Context Operations
##  --------------------------------------------------------------------------
## 	CSSM_CSP_CreateSignatureContext has been deprecated in 10.7 and later.
## 	The replacement API for this is SecSignTransformCreate in the
## 	SecSignVerifyTransform.h file.
##    --------------------------------------------------------------------------

proc CSSM_CSP_CreateSignatureContext*(CSPHandle: CSSM_CSP_HANDLE;
                                     AlgorithmID: CSSM_ALGORITHMS;
                                     AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                                     Key: ptr CSSM_KEY;
                                     NewContextHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_CreateSignatureContext has been deprecated in 10.7 and later.
## 	The replacement API for this is SecSignTransformCreate in the
## 	SecSignVerifyTransform.h file.
##    --------------------------------------------------------------------------

proc CSSM_CSP_CreateSymmetricContext*(CSPHandle: CSSM_CSP_HANDLE;
                                     AlgorithmID: CSSM_ALGORITHMS;
                                     Mode: CSSM_ENCRYPT_MODE;
                                     AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                                     Key: ptr CSSM_KEY; InitVector: ptr CSSM_DATA;
                                     Padding: CSSM_PADDING; Reserved: pointer;
                                     NewContextHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_CreateDigestContext has been deprecated in 10.7 and later.
## 	The replacement API for this is SecDigestTransformCreate in the
## 	SecDigestTransform.h file.
##    --------------------------------------------------------------------------

proc CSSM_CSP_CreateDigestContext*(CSPHandle: CSSM_CSP_HANDLE;
                                  AlgorithmID: CSSM_ALGORITHMS;
                                  NewContextHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_CreateMacContext has been deprecated in 10.7 and later.
## 	The replacement API for this is SecDigestTransformCreate in the
## 	SecDigestTransform.h file.
##    --------------------------------------------------------------------------

proc CSSM_CSP_CreateMacContext*(CSPHandle: CSSM_CSP_HANDLE;
                               AlgorithmID: CSSM_ALGORITHMS; Key: ptr CSSM_KEY;
                               NewContextHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_CreateRandomGenContext has been deprecated in 10.7 and later.
## 	There is no replacement API as this API is only needed with CDSA.  Please
## 	see the SecRandom.h file to get random numbers
##    --------------------------------------------------------------------------

proc CSSM_CSP_CreateRandomGenContext*(CSPHandle: CSSM_CSP_HANDLE;
                                     AlgorithmID: CSSM_ALGORITHMS;
                                     Seed: ptr CSSM_CRYPTO_DATA; Length: CSSM_SIZE;
                                     NewContextHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_CreateAsymmetricContext has been deprecated in 10.7 and later.
## 	There is no direct replacement of this API as it is only needed by CDSA.
## 	For asymmertical encryption/decryption use the SecEncryptTransformCreate
## 	or SecDecryptTransformCreate with a asymmertical key.
##    --------------------------------------------------------------------------

proc CSSM_CSP_CreateAsymmetricContext*(CSPHandle: CSSM_CSP_HANDLE;
                                      AlgorithmID: CSSM_ALGORITHMS;
                                      AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                                      Key: ptr CSSM_KEY; Padding: CSSM_PADDING;
                                      NewContextHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_CreateDeriveKeyContext has been deprecated in 10.7 and later.
## 	The replacement for this API would be the SecKeyDeriveFromPassword API
## 	in the SecKey.h file
##    --------------------------------------------------------------------------

proc CSSM_CSP_CreateDeriveKeyContext*(CSPHandle: CSSM_CSP_HANDLE;
                                     AlgorithmID: CSSM_ALGORITHMS;
                                     DeriveKeyType: CSSM_KEY_TYPE;
                                     DeriveKeyLengthInBits: uint32;
                                     AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                                     BaseKey: ptr CSSM_KEY; IterationCount: uint32;
                                     Salt: ptr CSSM_DATA;
                                     Seed: ptr CSSM_CRYPTO_DATA;
                                     NewContextHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_CreateKeyGenContext has been deprecated in 10.7 and later.
## 	The replacement for this API would be either the SecKeyGeneratePair API
## 	or the SecKeyGenerateSymmetric API in the SecKey.h file
##    --------------------------------------------------------------------------

proc CSSM_CSP_CreateKeyGenContext*(CSPHandle: CSSM_CSP_HANDLE;
                                  AlgorithmID: CSSM_ALGORITHMS;
                                  KeySizeInBits: uint32;
                                  Seed: ptr CSSM_CRYPTO_DATA; Salt: ptr CSSM_DATA;
                                  StartDate: ptr CSSM_DATE; EndDate: ptr CSSM_DATE;
                                  Params: ptr CSSM_DATA;
                                  NewContextHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_CreatePassThroughContext has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_CSP_CreatePassThroughContext*(CSPHandle: CSSM_CSP_HANDLE;
                                       Key: ptr CSSM_KEY;
                                       NewContextHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GetContext has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_GetContext*(CCHandle: CSSM_CC_HANDLE; Context: ptr CSSM_CONTEXT_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_FreeContext has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_FreeContext*(Context: CSSM_CONTEXT_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_SetContext has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_SetContext*(CCHandle: CSSM_CC_HANDLE; Context: ptr CSSM_CONTEXT): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DeleteContext has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DeleteContext*(CCHandle: CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GetContextAttribute has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_GetContextAttribute*(Context: ptr CSSM_CONTEXT; AttributeType: uint32;
                              ContextAttribute: ptr CSSM_CONTEXT_ATTRIBUTE_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_UpdateContextAttributes has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_UpdateContextAttributes*(CCHandle: CSSM_CC_HANDLE;
                                  NumberOfAttributes: uint32;
                                  ContextAttributes: ptr CSSM_CONTEXT_ATTRIBUTE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DeleteContextAttributes has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DeleteContextAttributes*(CCHandle: CSSM_CC_HANDLE;
                                  NumberOfAttributes: uint32;
                                  ContextAttributes: ptr CSSM_CONTEXT_ATTRIBUTE): CSSM_RETURN
##  Cryptographic Sessions and Controlled Access to Keys
##  --------------------------------------------------------------------------
## 	CSSM_CSP_Login has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_CSP_Login*(CSPHandle: CSSM_CSP_HANDLE;
                    AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                    LoginName: ptr CSSM_DATA; Reserved: pointer): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_Logout has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_CSP_Logout*(CSPHandle: CSSM_CSP_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_GetLoginAcl has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_CSP_GetLoginAcl*(CSPHandle: CSSM_CSP_HANDLE;
                          SelectionTag: ptr CSSM_STRING;
                          NumberOfAclInfos: ptr uint32;
                          AclInfos: ptr CSSM_ACL_ENTRY_INFO_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_ChangeLoginAcl has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_CSP_ChangeLoginAcl*(CSPHandle: CSSM_CSP_HANDLE;
                             AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                             AclEdit: ptr CSSM_ACL_EDIT): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GetKeyAcl has been deprecated in 10.7 and later.
## 	If the key in question is in a keychain then the ACL for the key can be
## 	acquired by using the SecItemCopyMatching API specifically
## 	kSecReturnAttributes with a value of kCFBooleanTrue.  In the attributes
## 	dictionary is kSecAttrAccess key with a value of a SecAccessRef. With
## 	a SecAccessRef the ACL for the key can be gotten using either the
## 	SecAccessCopyACLList API.
##    --------------------------------------------------------------------------

proc CSSM_GetKeyAcl*(CSPHandle: CSSM_CSP_HANDLE; Key: ptr CSSM_KEY;
                    SelectionTag: ptr CSSM_STRING; NumberOfAclInfos: ptr uint32;
                    AclInfos: ptr CSSM_ACL_ENTRY_INFO_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_ChangeKeyAcl has been deprecated in 10.7 and later.
## 	If the key in question is in a keychain then the ACL for the key can be
## 	changed by using the SecItemUpdate API.
##    --------------------------------------------------------------------------

proc CSSM_ChangeKeyAcl*(CSPHandle: CSSM_CSP_HANDLE;
                       AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                       AclEdit: ptr CSSM_ACL_EDIT; Key: ptr CSSM_KEY): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GetKeyOwner has been deprecated in 10.7 and later.
## 	If the key in question is in a keychain then the ACL for the key can be
## 	acquired by using the SecItemCopyMatching API specifically
## 	kSecReturnAttributes with a value of kCFBooleanTrue.  In the attributes
## 	dictionary is kSecAttrAccess key with a value of a SecAccessRef. With
## 	a SecAccessRef the ACL for the key can be gotten using either the
## 	SecAccessCopyOwnerAndACL API.
##    --------------------------------------------------------------------------

proc CSSM_GetKeyOwner*(CSPHandle: CSSM_CSP_HANDLE; Key: ptr CSSM_KEY;
                      Owner: CSSM_ACL_OWNER_PROTOTYPE_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_ChangeKeyOwner has been deprecated in 10.7 and later.
## 	If the key in question is in a keychain then the ACL for the key can be
## 	changed by using the SecItemUpdate API.
##    --------------------------------------------------------------------------

proc CSSM_ChangeKeyOwner*(CSPHandle: CSSM_CSP_HANDLE;
                         AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                         Key: ptr CSSM_KEY; NewOwner: ptr CSSM_ACL_OWNER_PROTOTYPE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_GetLoginOwner has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_CSP_GetLoginOwner*(CSPHandle: CSSM_CSP_HANDLE;
                            Owner: CSSM_ACL_OWNER_PROTOTYPE_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_ChangeLoginOwner has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_CSP_ChangeLoginOwner*(CSPHandle: CSSM_CSP_HANDLE;
                               AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                               NewOwner: ptr CSSM_ACL_OWNER_PROTOTYPE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_SignData has been deprecated in 10.7 and later.
## 	To sign data use the SecSignTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_SignData*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                   DataBufCount: uint32; DigestAlgorithm: CSSM_ALGORITHMS;
                   Signature: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_SignDataInit has been deprecated in 10.7 and later.
## 	To sign data use the SecSignTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_SignDataInit*(CCHandle: CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_SignDataUpdate has been deprecated in 10.7 and later.
## 	To sign data use the SecSignTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_SignDataUpdate*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                         DataBufCount: uint32): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_SignDataFinal has been deprecated in 10.7 and later.
## 	To sign data use the SecSignTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_SignDataFinal*(CCHandle: CSSM_CC_HANDLE; Signature: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_VerifyData has been deprecated in 10.7 and later.
## 	To sign data use the SecVerifyTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_VerifyData*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                     DataBufCount: uint32; DigestAlgorithm: CSSM_ALGORITHMS;
                     Signature: ptr CSSM_DATA): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_VerifyDataInit has been deprecated in 10.7 and later.
## 	To sign data use the SecVerifyTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_VerifyDataInit*(CCHandle: CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_VerifyDataUpdate has been deprecated in 10.7 and later.
## 	To sign data use the SecVerifyTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_VerifyDataUpdate*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                           DataBufCount: uint32): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_VerifyDataFinal has been deprecated in 10.7 and later.
## 	To sign data use the SecVerifyTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_VerifyDataFinal*(CCHandle: CSSM_CC_HANDLE; Signature: ptr CSSM_DATA): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DigestData has been deprecated in 10.7 and later.
## 	To sign data use the SecDigestTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DigestData*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                     DataBufCount: uint32; Digest: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DigestDataInit has been deprecated in 10.7 and later.
## 	To sign data use the SecDigestTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DigestDataInit*(CCHandle: CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DigestDataUpdate has been deprecated in 10.7 and later.
## 	To sign data use the SecDigestTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DigestDataUpdate*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                           DataBufCount: uint32): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DigestDataClone has been deprecated in 10.7 and later.
## 	Given that transforms can have be connected into chains, this
## 	functionality is no longer needed.
##    --------------------------------------------------------------------------

proc CSSM_DigestDataClone*(CCHandle: CSSM_CC_HANDLE;
                          ClonednewCCHandle: ptr CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DigestDataFinal has been deprecated in 10.7 and later.
## 	To sign data use the SecDigestTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DigestDataFinal*(CCHandle: CSSM_CC_HANDLE; Digest: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateMac has been deprecated in 10.7 and later.
## 	To sign data use the SecDigestTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_GenerateMac*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                      DataBufCount: uint32; Mac: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateMacInit has been deprecated in 10.7 and later.
## 	To sign data use the SecDigestTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_GenerateMacInit*(CCHandle: CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateMacUpdate has been deprecated in 10.7 and later.
## 	To sign data use the SecDigestTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_GenerateMacUpdate*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                            DataBufCount: uint32): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateMacFinal has been deprecated in 10.7 and later.
## 	To sign data use the SecDigestTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_GenerateMacFinal*(CCHandle: CSSM_CC_HANDLE; Mac: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_VerifyMac has been deprecated in 10.7 and later.
## 	To sign data use the SecVerifyTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_VerifyMac*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                    DataBufCount: uint32; Mac: ptr CSSM_DATA): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_VerifyMacInit has been deprecated in 10.7 and later.
## 	To sign data use the SecVerifyTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_VerifyMacInit*(CCHandle: CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_VerifyMacUpdate has been deprecated in 10.7 and later.
## 	To sign data use the SecVerifyTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_VerifyMacUpdate*(CCHandle: CSSM_CC_HANDLE; DataBufs: ptr CSSM_DATA;
                          DataBufCount: uint32): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_VerifyMacFinal has been deprecated in 10.7 and later.
## 	To sign data use the SecVerifyTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_VerifyMacFinal*(CCHandle: CSSM_CC_HANDLE; Mac: ptr CSSM_DATA): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_QuerySize has been deprecated in 10.7 and later.
## 	Given that transforms buffer data into queues, this functionality is no
## 	longer needed.
##    --------------------------------------------------------------------------

proc CSSM_QuerySize*(CCHandle: CSSM_CC_HANDLE; Encrypt: CSSM_BOOL;
                    QuerySizeCount: uint32;
                    DataBlockSizes: CSSM_QUERY_SIZE_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_EncryptData has been deprecated in 10.7 and later.
## 	To sign data use the SecEncryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_EncryptData*(CCHandle: CSSM_CC_HANDLE; ClearBufs: ptr CSSM_DATA;
                      ClearBufCount: uint32; CipherBufs: CSSM_DATA_PTR;
                      CipherBufCount: uint32; bytesEncrypted: ptr CSSM_SIZE;
                      RemData: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_EncryptDataP has been deprecated in 10.7 and later.
## 	To sign data use the SecEncryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_EncryptDataP*(CCHandle: CSSM_CC_HANDLE; ClearBufs: ptr CSSM_DATA;
                       ClearBufCount: uint32; CipherBufs: CSSM_DATA_PTR;
                       CipherBufCount: uint32; bytesEncrypted: ptr CSSM_SIZE;
                       RemData: CSSM_DATA_PTR; Privilege: CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_EncryptDataInit has been deprecated in 10.7 and later.
## 	To sign data use the SecEncryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_EncryptDataInit*(CCHandle: CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_EncryptDataInitP has been deprecated in 10.7 and later.
## 	To sign data use the SecEncryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_EncryptDataInitP*(CCHandle: CSSM_CC_HANDLE; Privilege: CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_EncryptDataUpdate has been deprecated in 10.7 and later.
## 	To sign data use the SecEncryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_EncryptDataUpdate*(CCHandle: CSSM_CC_HANDLE; ClearBufs: ptr CSSM_DATA;
                            ClearBufCount: uint32; CipherBufs: CSSM_DATA_PTR;
                            CipherBufCount: uint32; bytesEncrypted: ptr CSSM_SIZE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_EncryptDataFinal has been deprecated in 10.7 and later.
## 	To sign data use the SecEncryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_EncryptDataFinal*(CCHandle: CSSM_CC_HANDLE; RemData: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DecryptData has been deprecated in 10.7 and later.
## 	To sign data use the SecDecryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DecryptData*(CCHandle: CSSM_CC_HANDLE; CipherBufs: ptr CSSM_DATA;
                      CipherBufCount: uint32; ClearBufs: CSSM_DATA_PTR;
                      ClearBufCount: uint32; bytesDecrypted: ptr CSSM_SIZE;
                      RemData: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DecryptDataP has been deprecated in 10.7 and later.
## 	To sign data use the SecDecryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DecryptDataP*(CCHandle: CSSM_CC_HANDLE; CipherBufs: ptr CSSM_DATA;
                       CipherBufCount: uint32; ClearBufs: CSSM_DATA_PTR;
                       ClearBufCount: uint32; bytesDecrypted: ptr CSSM_SIZE;
                       RemData: CSSM_DATA_PTR; Privilege: CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DecryptDataInit has been deprecated in 10.7 and later.
## 	To sign data use the SecDecryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DecryptDataInit*(CCHandle: CSSM_CC_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DecryptDataInitP has been deprecated in 10.7 and later.
## 	To sign data use the SecDecryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DecryptDataInitP*(CCHandle: CSSM_CC_HANDLE; Privilege: CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DecryptDataUpdate has been deprecated in 10.7 and later.
## 	To sign data use the SecDecryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DecryptDataUpdate*(CCHandle: CSSM_CC_HANDLE; CipherBufs: ptr CSSM_DATA;
                            CipherBufCount: uint32; ClearBufs: CSSM_DATA_PTR;
                            ClearBufCount: uint32; bytesDecrypted: ptr CSSM_SIZE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DecryptDataFinal has been deprecated in 10.7 and later.
## 	To sign data use the SecDecryptTransformCreate API to create the transform
## 	and the SecTransform APIs to set the data and to execute the transform.
##    --------------------------------------------------------------------------

proc CSSM_DecryptDataFinal*(CCHandle: CSSM_CC_HANDLE; RemData: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_QueryKeySizeInBits has been deprecated in 10.7 and later.
## 	Given that a SecKeyRef abstracts the usage of a key this API so no longer
## 	needed.
##    --------------------------------------------------------------------------

proc CSSM_QueryKeySizeInBits*(CSPHandle: CSSM_CSP_HANDLE; CCHandle: CSSM_CC_HANDLE;
                             Key: ptr CSSM_KEY; KeySize: CSSM_KEY_SIZE_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateKey has been deprecated in 10.7 and later.
## 	To create a symmetrical key call SecKeyGenerateSymmetric.
##    --------------------------------------------------------------------------

proc CSSM_GenerateKey*(CCHandle: CSSM_CC_HANDLE; KeyUsage: uint32; KeyAttr: uint32;
                      KeyLabel: ptr CSSM_DATA;
                      CredAndAclEntry: ptr CSSM_RESOURCE_CONTROL_CONTEXT;
                      Key: CSSM_KEY_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateKeyP has been deprecated in 10.7 and later.
## 	To create a symmetrical key call SecKeyGenerateSymmetric.
##    --------------------------------------------------------------------------

proc CSSM_GenerateKeyP*(CCHandle: CSSM_CC_HANDLE; KeyUsage: uint32; KeyAttr: uint32;
                       KeyLabel: ptr CSSM_DATA;
                       CredAndAclEntry: ptr CSSM_RESOURCE_CONTROL_CONTEXT;
                       Key: CSSM_KEY_PTR; Privilege: CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateKeyPair has been deprecated in 10.7 and later.
## 	To create an asymmetrical key call SecKeyGeneratePair.
##    --------------------------------------------------------------------------

proc CSSM_GenerateKeyPair*(CCHandle: CSSM_CC_HANDLE; PublicKeyUsage: uint32;
                          PublicKeyAttr: uint32; PublicKeyLabel: ptr CSSM_DATA;
                          PublicKey: CSSM_KEY_PTR; PrivateKeyUsage: uint32;
                          PrivateKeyAttr: uint32; PrivateKeyLabel: ptr CSSM_DATA;
                          CredAndAclEntry: ptr CSSM_RESOURCE_CONTROL_CONTEXT;
                          PrivateKey: CSSM_KEY_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateKeyPairP has been deprecated in 10.7 and later.
## 	To create an asymmetrical key call SecKeyGeneratePair.
##    --------------------------------------------------------------------------

proc CSSM_GenerateKeyPairP*(CCHandle: CSSM_CC_HANDLE; PublicKeyUsage: uint32;
                           PublicKeyAttr: uint32; PublicKeyLabel: ptr CSSM_DATA;
                           PublicKey: CSSM_KEY_PTR; PrivateKeyUsage: uint32;
                           PrivateKeyAttr: uint32; PrivateKeyLabel: ptr CSSM_DATA;
                           CredAndAclEntry: ptr CSSM_RESOURCE_CONTROL_CONTEXT;
                           PrivateKey: CSSM_KEY_PTR; Privilege: CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateRandom has been deprecated in 10.7 and later.
## 	To get random data call SecRandomCopyBytes
##    --------------------------------------------------------------------------

proc CSSM_GenerateRandom*(CCHandle: CSSM_CC_HANDLE; RandomNumber: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CSP_ObtainPrivateKeyFromPublicKey has been deprecated in 10.7 and later.
## 	There is not currently a direct replacement for this API
##    --------------------------------------------------------------------------

proc CSSM_CSP_ObtainPrivateKeyFromPublicKey*(CSPHandle: CSSM_CSP_HANDLE;
    PublicKey: ptr CSSM_KEY; PrivateKey: CSSM_KEY_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_WrapKey has been deprecated in 10.7 and later.
## 	This is replaced with the SecKeyWrapSymmetric API.
##    --------------------------------------------------------------------------

proc CSSM_WrapKey*(CCHandle: CSSM_CC_HANDLE;
                  AccessCred: ptr CSSM_ACCESS_CREDENTIALS; Key: ptr CSSM_KEY;
                  DescriptiveData: ptr CSSM_DATA; WrappedKey: CSSM_WRAP_KEY_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_UnwrapKey has been deprecated in 10.7 and later.
## 	This is replaced with the SecKeyUnwrapSymmetric API.
##    --------------------------------------------------------------------------

proc CSSM_UnwrapKey*(CCHandle: CSSM_CC_HANDLE; PublicKey: ptr CSSM_KEY;
                    WrappedKey: ptr CSSM_WRAP_KEY; KeyUsage: uint32; KeyAttr: uint32;
                    KeyLabel: ptr CSSM_DATA;
                    CredAndAclEntry: ptr CSSM_RESOURCE_CONTROL_CONTEXT;
                    UnwrappedKey: CSSM_KEY_PTR; DescriptiveData: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_WrapKeyP has been deprecated in 10.7 and later.
## 	This is replaced with the SecKeyWrapSymmetric API.
##    --------------------------------------------------------------------------

proc CSSM_WrapKeyP*(CCHandle: CSSM_CC_HANDLE;
                   AccessCred: ptr CSSM_ACCESS_CREDENTIALS; Key: ptr CSSM_KEY;
                   DescriptiveData: ptr CSSM_DATA; WrappedKey: CSSM_WRAP_KEY_PTR;
                   Privilege: CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_WrapKeyP has been deprecated in 10.7 and later.
## 	This is replaced with the SecKeyUnwrapSymmetric API.
##    --------------------------------------------------------------------------

proc CSSM_UnwrapKeyP*(CCHandle: CSSM_CC_HANDLE; PublicKey: ptr CSSM_KEY;
                     WrappedKey: ptr CSSM_WRAP_KEY; KeyUsage: uint32;
                     KeyAttr: uint32; KeyLabel: ptr CSSM_DATA;
                     CredAndAclEntry: ptr CSSM_RESOURCE_CONTROL_CONTEXT;
                     UnwrappedKey: CSSM_KEY_PTR; DescriptiveData: CSSM_DATA_PTR;
                     Privilege: CSSM_PRIVILEGE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DeriveKey has been deprecated in 10.7 and later.
## 	This is replaced with the SecKeyDeriveFromPassword API.
##    --------------------------------------------------------------------------

proc CSSM_DeriveKey*(CCHandle: CSSM_CC_HANDLE; Param: CSSM_DATA_PTR;
                    KeyUsage: uint32; KeyAttr: uint32; KeyLabel: ptr CSSM_DATA;
                    CredAndAclEntry: ptr CSSM_RESOURCE_CONTROL_CONTEXT;
                    DerivedKey: CSSM_KEY_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_FreeKey has been deprecated in 10.7 and later.  There is no
## 	alternate API. If the key in question is in a keychain calling
## 	SecItemDelete will delete the key.  If it is just a free standing key
## 	calling CFRelease on the SecKeyRef will delete the key.
##    --------------------------------------------------------------------------

proc CSSM_FreeKey*(CSPHandle: CSSM_CSP_HANDLE;
                  AccessCred: ptr CSSM_ACCESS_CREDENTIALS; KeyPtr: CSSM_KEY_PTR;
                  Delete: CSSM_BOOL): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GenerateAlgorithmParams has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_GenerateAlgorithmParams*(CCHandle: CSSM_CC_HANDLE; ParamBits: uint32;
                                  Param: CSSM_DATA_PTR): CSSM_RETURN
##  Miscellaneous Functions for Cryptographic Services
##  --------------------------------------------------------------------------
## 	CSSM_CSP_GetOperationalStatistics has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_CSP_GetOperationalStatistics*(CSPHandle: CSSM_CSP_HANDLE; Statistics: ptr CSSM_CSP_OPERATIONAL_STATISTICS): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_GetTimeValue has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_GetTimeValue*(CSPHandle: CSSM_CSP_HANDLE; TimeAlgorithm: CSSM_ALGORITHMS;
                       TimeData: ptr CSSM_DATA): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_RetrieveUniqueId has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.  One could call CFUUIDCreate to create a unique ID.
##    --------------------------------------------------------------------------

proc CSSM_RetrieveUniqueId*(CSPHandle: CSSM_CSP_HANDLE; UniqueID: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_RetrieveCounter has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_RetrieveCounter*(CSPHandle: CSSM_CSP_HANDLE; Counter: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_VerifyDevice has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_VerifyDevice*(CSPHandle: CSSM_CSP_HANDLE; DeviceCert: ptr CSSM_DATA): CSSM_RETURN
##  Extensibility Functions for Cryptographic Services
##  --------------------------------------------------------------------------
## 	CSSM_CSP_PassThrough has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_CSP_PassThrough*(CCHandle: CSSM_CC_HANDLE; PassThroughId: uint32;
                          InData: pointer; OutData: ptr pointer): CSSM_RETURN
##  Trust Policy Operations
##  --------------------------------------------------------------------------
## 	CSSM_TP_SubmitCredRequest has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_SubmitCredRequest*(TPHandle: CSSM_TP_HANDLE;
                               PreferredAuthority: ptr CSSM_TP_AUTHORITY_ID;
                               RequestType: CSSM_TP_AUTHORITY_REQUEST_TYPE;
                               RequestInput: ptr CSSM_TP_REQUEST_SET;
    CallerAuthContext: ptr CSSM_TP_CALLERAUTH_CONTEXT; EstimatedTime: ptr sint32;
                               ReferenceIdentifier: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_RetrieveCredResult has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_RetrieveCredResult*(TPHandle: CSSM_TP_HANDLE;
                                ReferenceIdentifier: ptr CSSM_DATA;
    CallerAuthCredentials: ptr CSSM_TP_CALLERAUTH_CONTEXT;
                                EstimatedTime: ptr sint32;
                                ConfirmationRequired: ptr CSSM_BOOL;
                                RetrieveOutput: ptr CSSM_TP_RESULT_SET_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_ConfirmCredResult has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_ConfirmCredResult*(TPHandle: CSSM_TP_HANDLE;
                               ReferenceIdentifier: ptr CSSM_DATA;
    CallerAuthCredentials: ptr CSSM_TP_CALLERAUTH_CONTEXT;
                               Responses: ptr CSSM_TP_CONFIRM_RESPONSE;
                               PreferredAuthority: ptr CSSM_TP_AUTHORITY_ID): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_ReceiveConfirmation has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_ReceiveConfirmation*(TPHandle: CSSM_TP_HANDLE;
                                 ReferenceIdentifier: ptr CSSM_DATA;
                                 Responses: ptr CSSM_TP_CONFIRM_RESPONSE_PTR;
                                 ElapsedTime: ptr sint32): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertReclaimKey has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertReclaimKey*(TPHandle: CSSM_TP_HANDLE;
                            CertGroup: ptr CSSM_CERTGROUP; CertIndex: uint32;
                            KeyCacheHandle: CSSM_LONG_HANDLE;
                            CSPHandle: CSSM_CSP_HANDLE;
                            CredAndAclEntry: ptr CSSM_RESOURCE_CONTROL_CONTEXT): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertReclaimAbort has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertReclaimAbort*(TPHandle: CSSM_TP_HANDLE;
                              KeyCacheHandle: CSSM_LONG_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_FormRequest has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_FormRequest*(TPHandle: CSSM_TP_HANDLE;
                         PreferredAuthority: ptr CSSM_TP_AUTHORITY_ID;
                         FormType: CSSM_TP_FORM_TYPE; BlankForm: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_FormSubmit has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_FormSubmit*(TPHandle: CSSM_TP_HANDLE; FormType: CSSM_TP_FORM_TYPE;
                        Form: ptr CSSM_DATA;
                        ClearanceAuthority: ptr CSSM_TP_AUTHORITY_ID;
                        RepresentedAuthority: ptr CSSM_TP_AUTHORITY_ID;
                        Credentials: CSSM_ACCESS_CREDENTIALS_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertGroupVerify has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertGroupVerify*(TPHandle: CSSM_TP_HANDLE; CLHandle: CSSM_CL_HANDLE;
                             CSPHandle: CSSM_CSP_HANDLE;
                             CertGroupToBeVerified: ptr CSSM_CERTGROUP;
                             VerifyContext: ptr CSSM_TP_VERIFY_CONTEXT;
    VerifyContextResult: CSSM_TP_VERIFY_CONTEXT_RESULT_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertCreateTemplate has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertCreateTemplate*(TPHandle: CSSM_TP_HANDLE;
                                CLHandle: CSSM_CL_HANDLE; NumberOfFields: uint32;
                                CertFields: ptr CSSM_FIELD;
                                CertTemplate: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertGetAllTemplateFields has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertGetAllTemplateFields*(TPHandle: CSSM_TP_HANDLE;
                                      CLHandle: CSSM_CL_HANDLE;
                                      CertTemplate: ptr CSSM_DATA;
                                      NumberOfFields: ptr uint32;
                                      CertFields: ptr CSSM_FIELD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertSign has been deprecated in 10.7 and later.
## 	The replacement API is SecSignTransformCreate.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertSign*(TPHandle: CSSM_TP_HANDLE; CLHandle: CSSM_CL_HANDLE;
                      CCHandle: CSSM_CC_HANDLE;
                      CertTemplateToBeSigned: ptr CSSM_DATA;
                      SignerCertGroup: ptr CSSM_CERTGROUP;
                      SignerVerifyContext: ptr CSSM_TP_VERIFY_CONTEXT;
                      SignerVerifyResult: CSSM_TP_VERIFY_CONTEXT_RESULT_PTR;
                      SignedCert: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CrlVerify has been deprecated in 10.7 and later.
## 	The replacement API is SecVerifyTransformCreate.
##    --------------------------------------------------------------------------

proc CSSM_TP_CrlVerify*(TPHandle: CSSM_TP_HANDLE; CLHandle: CSSM_CL_HANDLE;
                       CSPHandle: CSSM_CSP_HANDLE;
                       CrlToBeVerified: ptr CSSM_ENCODED_CRL;
                       SignerCertGroup: ptr CSSM_CERTGROUP;
                       VerifyContext: ptr CSSM_TP_VERIFY_CONTEXT;
                       RevokerVerifyResult: CSSM_TP_VERIFY_CONTEXT_RESULT_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CrlCreateTemplate has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CrlCreateTemplate*(TPHandle: CSSM_TP_HANDLE; CLHandle: CSSM_CL_HANDLE;
                               NumberOfFields: uint32; CrlFields: ptr CSSM_FIELD;
                               NewCrlTemplate: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertRevoke has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertRevoke*(TPHandle: CSSM_TP_HANDLE; CLHandle: CSSM_CL_HANDLE;
                        CSPHandle: CSSM_CSP_HANDLE; OldCrlTemplate: ptr CSSM_DATA;
                        CertGroupToBeRevoked: ptr CSSM_CERTGROUP;
                        RevokerCertGroup: ptr CSSM_CERTGROUP;
                        RevokerVerifyContext: ptr CSSM_TP_VERIFY_CONTEXT;
                        RevokerVerifyResult: CSSM_TP_VERIFY_CONTEXT_RESULT_PTR;
                        Reason: CSSM_TP_CERTCHANGE_REASON;
                        NewCrlTemplate: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertRemoveFromCrlTemplate has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertRemoveFromCrlTemplate*(TPHandle: CSSM_TP_HANDLE;
                                       CLHandle: CSSM_CL_HANDLE;
                                       CSPHandle: CSSM_CSP_HANDLE;
                                       OldCrlTemplate: ptr CSSM_DATA;
    CertGroupToBeRemoved: ptr CSSM_CERTGROUP; RevokerCertGroup: ptr CSSM_CERTGROUP;
    RevokerVerifyContext: ptr CSSM_TP_VERIFY_CONTEXT; RevokerVerifyResult: CSSM_TP_VERIFY_CONTEXT_RESULT_PTR;
                                       NewCrlTemplate: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CrlSign has been deprecated in 10.7 and later.
## 	The replacement API is SecVerifyTransformCreate.
##    --------------------------------------------------------------------------

proc CSSM_TP_CrlSign*(TPHandle: CSSM_TP_HANDLE; CLHandle: CSSM_CL_HANDLE;
                     CCHandle: CSSM_CC_HANDLE;
                     CrlToBeSigned: ptr CSSM_ENCODED_CRL;
                     SignerCertGroup: ptr CSSM_CERTGROUP;
                     SignerVerifyContext: ptr CSSM_TP_VERIFY_CONTEXT;
                     SignerVerifyResult: CSSM_TP_VERIFY_CONTEXT_RESULT_PTR;
                     SignedCrl: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_ApplyCrlToDb has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_ApplyCrlToDb*(TPHandle: CSSM_TP_HANDLE; CLHandle: CSSM_CL_HANDLE;
                          CSPHandle: CSSM_CSP_HANDLE;
                          CrlToBeApplied: ptr CSSM_ENCODED_CRL;
                          SignerCertGroup: ptr CSSM_CERTGROUP;
                          ApplyCrlVerifyContext: ptr CSSM_TP_VERIFY_CONTEXT;
    ApplyCrlVerifyResult: CSSM_TP_VERIFY_CONTEXT_RESULT_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertGroupConstruct has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertGroupConstruct*(TPHandle: CSSM_TP_HANDLE;
                                CLHandle: CSSM_CL_HANDLE;
                                CSPHandle: CSSM_CSP_HANDLE;
                                DBList: ptr CSSM_DL_DB_LIST;
                                ConstructParams: pointer;
                                CertGroupFrag: ptr CSSM_CERTGROUP;
                                CertGroup: ptr CSSM_CERTGROUP_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertGroupPrune has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertGroupPrune*(TPHandle: CSSM_TP_HANDLE; CLHandle: CSSM_CL_HANDLE;
                            DBList: ptr CSSM_DL_DB_LIST;
                            OrderedCertGroup: ptr CSSM_CERTGROUP;
                            PrunedCertGroup: ptr CSSM_CERTGROUP_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_CertGroupToTupleGroup has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_CertGroupToTupleGroup*(TPHandle: CSSM_TP_HANDLE;
                                   CLHandle: CSSM_CL_HANDLE;
                                   CertGroup: ptr CSSM_CERTGROUP;
                                   TupleGroup: ptr CSSM_TUPLEGROUP_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_TupleGroupToCertGroup has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_TP_TupleGroupToCertGroup*(TPHandle: CSSM_TP_HANDLE;
                                   CLHandle: CSSM_CL_HANDLE;
                                   TupleGroup: ptr CSSM_TUPLEGROUP;
                                   CertTemplates: ptr CSSM_CERTGROUP_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_TP_PassThrough has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_TP_PassThrough*(TPHandle: CSSM_TP_HANDLE; CLHandle: CSSM_CL_HANDLE;
                         CCHandle: CSSM_CC_HANDLE; DBList: ptr CSSM_DL_DB_LIST;
                         PassThroughId: uint32; InputParams: pointer;
                         OutputParams: ptr pointer): CSSM_RETURN
##  Authorization Computation Operations
##  --------------------------------------------------------------------------
## 	CSSM_AC_AuthCompute has been deprecated in 10.7 and later.
## 	Please see the APIs in the SecAccess.h file for a replacement.
##    --------------------------------------------------------------------------

proc CSSM_AC_AuthCompute*(ACHandle: CSSM_AC_HANDLE;
                         BaseAuthorizations: ptr CSSM_TUPLEGROUP;
                         Credentials: ptr CSSM_TUPLEGROUP;
                         NumberOfRequestors: uint32; Requestors: ptr CSSM_LIST;
                         RequestedAuthorizationPeriod: ptr CSSM_LIST;
                         RequestedAuthorization: ptr CSSM_LIST;
                         AuthorizationResult: CSSM_TUPLEGROUP_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_AC_PassThrough has been deprecated in 10.7 and later.
## 	Please see the APIs in the SecAccess.h file for a replacement.
##    --------------------------------------------------------------------------

proc CSSM_AC_PassThrough*(ACHandle: CSSM_AC_HANDLE; TPHandle: CSSM_TP_HANDLE;
                         CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                         DBList: ptr CSSM_DL_DB_LIST; PassThroughId: uint32;
                         InputParams: pointer; OutputParams: ptr pointer): CSSM_RETURN
##  Certificate Library Operations
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertCreateTemplate has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertCreateTemplate*(CLHandle: CSSM_CL_HANDLE; NumberOfFields: uint32;
                                CertFields: ptr CSSM_FIELD;
                                CertTemplate: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertGetAllTemplateFields has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertGetAllTemplateFields*(CLHandle: CSSM_CL_HANDLE;
                                      CertTemplate: ptr CSSM_DATA;
                                      NumberOfFields: ptr uint32;
                                      CertFields: ptr CSSM_FIELD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertSign has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertSign*(CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                      CertTemplate: ptr CSSM_DATA; SignScope: ptr CSSM_FIELD;
                      ScopeSize: uint32; SignedCert: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertVerify has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertVerify*(CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                        CertToBeVerified: ptr CSSM_DATA; SignerCert: ptr CSSM_DATA;
                        VerifyScope: ptr CSSM_FIELD; ScopeSize: uint32): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertVerifyWithKey has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertVerifyWithKey*(CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                               CertToBeVerified: ptr CSSM_DATA): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertVerifyWithKey has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertGetFirstFieldValue*(CLHandle: CSSM_CL_HANDLE; Cert: ptr CSSM_DATA;
                                    CertField: ptr CSSM_OID;
                                    ResultsHandle: CSSM_HANDLE_PTR;
                                    NumberOfMatchedFields: ptr uint32;
                                    Value: ptr CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertGetNextFieldValue has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertGetNextFieldValue*(CLHandle: CSSM_CL_HANDLE;
                                   ResultsHandle: CSSM_HANDLE;
                                   Value: ptr CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertAbortQuery has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertAbortQuery*(CLHandle: CSSM_CL_HANDLE; ResultsHandle: CSSM_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertGetKeyInfo has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertGetKeyInfo*(CLHandle: CSSM_CL_HANDLE; Cert: ptr CSSM_DATA;
                            Key: ptr CSSM_KEY_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertGetAllFields has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertGetAllFields*(CLHandle: CSSM_CL_HANDLE; Cert: ptr CSSM_DATA;
                              NumberOfFields: ptr uint32;
                              CertFields: ptr CSSM_FIELD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_FreeFields has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_FreeFields*(CLHandle: CSSM_CL_HANDLE; NumberOfFields: uint32;
                        Fields: ptr CSSM_FIELD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_FreeFieldValue has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_FreeFieldValue*(CLHandle: CSSM_CL_HANDLE; CertOrCrlOid: ptr CSSM_OID;
                            Value: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertCache has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertCache*(CLHandle: CSSM_CL_HANDLE; Cert: ptr CSSM_DATA;
                       CertHandle: CSSM_HANDLE_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertGetFirstCachedFieldValue has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API
##    --------------------------------------------------------------------------

proc CSSM_CL_CertGetFirstCachedFieldValue*(CLHandle: CSSM_CL_HANDLE;
    CertHandle: CSSM_HANDLE; CertField: ptr CSSM_OID; ResultsHandle: CSSM_HANDLE_PTR;
    NumberOfMatchedFields: ptr uint32; Value: ptr CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertGetNextCachedFieldValue has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API
##    --------------------------------------------------------------------------

proc CSSM_CL_CertGetNextCachedFieldValue*(CLHandle: CSSM_CL_HANDLE;
    ResultsHandle: CSSM_HANDLE; Value: ptr CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertAbortCache has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertAbortCache*(CLHandle: CSSM_CL_HANDLE; CertHandle: CSSM_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertGroupToSignedBundle has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertGroupToSignedBundle*(CLHandle: CSSM_CL_HANDLE;
                                     CCHandle: CSSM_CC_HANDLE;
                                     CertGroupToBundle: ptr CSSM_CERTGROUP;
                                     BundleInfo: ptr CSSM_CERT_BUNDLE_HEADER;
                                     SignedBundle: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertGroupFromVerifiedBundle has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertGroupFromVerifiedBundle*(CLHandle: CSSM_CL_HANDLE;
    CCHandle: CSSM_CC_HANDLE; CertBundle: ptr CSSM_CERT_BUNDLE;
    SignerCert: ptr CSSM_DATA; CertGroup: ptr CSSM_CERTGROUP_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CertDescribeFormat has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CertDescribeFormat*(CLHandle: CSSM_CL_HANDLE;
                                NumberOfFields: ptr uint32;
                                OidList: ptr CSSM_OID_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlCreateTemplate has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlCreateTemplate*(CLHandle: CSSM_CL_HANDLE; NumberOfFields: uint32;
                               CrlTemplate: ptr CSSM_FIELD; NewCrl: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlSetFields has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlSetFields*(CLHandle: CSSM_CL_HANDLE; NumberOfFields: uint32;
                          CrlTemplate: ptr CSSM_FIELD; OldCrl: ptr CSSM_DATA;
                          ModifiedCrl: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlAddCert has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlAddCert*(CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                        Cert: ptr CSSM_DATA; NumberOfFields: uint32;
                        CrlEntryFields: ptr CSSM_FIELD; OldCrl: ptr CSSM_DATA;
                        NewCrl: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlRemoveCert has been deprecated in 10.7 and later.
## 	There is currently no direct replacement.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlRemoveCert*(CLHandle: CSSM_CL_HANDLE; Cert: ptr CSSM_DATA;
                           OldCrl: ptr CSSM_DATA; NewCrl: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlSign has been deprecated in 10.7 and later.
## 	The replacement API would be to use the SecSignTransformCreate transform.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlSign*(CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                     UnsignedCrl: ptr CSSM_DATA; SignScope: ptr CSSM_FIELD;
                     ScopeSize: uint32; SignedCrl: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlVerify has been deprecated in 10.7 and later.
## 	The replacement API would be to use the SecVerifyTransformCreate transform.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlVerify*(CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                       CrlToBeVerified: ptr CSSM_DATA; SignerCert: ptr CSSM_DATA;
                       VerifyScope: ptr CSSM_FIELD; ScopeSize: uint32): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlVerifyWithKey has been deprecated in 10.7 and later.
## 	The replacement API would be to use the SecVerifyTransformCreate transform.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlVerifyWithKey*(CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                              CrlToBeVerified: ptr CSSM_DATA): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_IsCertInCrl has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_IsCertInCrl*(CLHandle: CSSM_CL_HANDLE; Cert: ptr CSSM_DATA;
                         Crl: ptr CSSM_DATA; CertFound: ptr CSSM_BOOL): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlGetFirstFieldValue has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlGetFirstFieldValue*(CLHandle: CSSM_CL_HANDLE; Crl: ptr CSSM_DATA;
                                   CrlField: ptr CSSM_OID;
                                   ResultsHandle: CSSM_HANDLE_PTR;
                                   NumberOfMatchedFields: ptr uint32;
                                   Value: ptr CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlGetNextFieldValue has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlGetNextFieldValue*(CLHandle: CSSM_CL_HANDLE;
                                  ResultsHandle: CSSM_HANDLE;
                                  Value: ptr CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlAbortQuery has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlAbortQuery*(CLHandle: CSSM_CL_HANDLE; ResultsHandle: CSSM_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlGetAllFields has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlGetAllFields*(CLHandle: CSSM_CL_HANDLE; Crl: ptr CSSM_DATA;
                             NumberOfCrlFields: ptr uint32;
                             CrlFields: ptr CSSM_FIELD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlCache has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlCache*(CLHandle: CSSM_CL_HANDLE; Crl: ptr CSSM_DATA;
                      CrlHandle: CSSM_HANDLE_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_IsCertInCachedCrl has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_IsCertInCachedCrl*(CLHandle: CSSM_CL_HANDLE; Cert: ptr CSSM_DATA;
                               CrlHandle: CSSM_HANDLE; CertFound: ptr CSSM_BOOL;
                               CrlRecordIndex: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlGetFirstCachedFieldValue has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlGetFirstCachedFieldValue*(CLHandle: CSSM_CL_HANDLE;
    CrlHandle: CSSM_HANDLE; CrlRecordIndex: ptr CSSM_DATA; CrlField: ptr CSSM_OID;
    ResultsHandle: CSSM_HANDLE_PTR; NumberOfMatchedFields: ptr uint32;
    Value: ptr CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlGetNextCachedFieldValue has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlGetNextCachedFieldValue*(CLHandle: CSSM_CL_HANDLE;
                                        ResultsHandle: CSSM_HANDLE;
                                        Value: ptr CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlGetAllCachedRecordFields has been deprecated in 10.7 and later.
## 	This is replaced with the SecCertificateCopyValues API
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlGetAllCachedRecordFields*(CLHandle: CSSM_CL_HANDLE;
    CrlHandle: CSSM_HANDLE; CrlRecordIndex: ptr CSSM_DATA;
    NumberOfFields: ptr uint32; CrlFields: ptr CSSM_FIELD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlAbortCache has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlAbortCache*(CLHandle: CSSM_CL_HANDLE; CrlHandle: CSSM_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_CrlDescribeFormat has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_CrlDescribeFormat*(CLHandle: CSSM_CL_HANDLE;
                               NumberOfFields: ptr uint32;
                               OidList: ptr CSSM_OID_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_CL_PassThrough has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs.
##    --------------------------------------------------------------------------

proc CSSM_CL_PassThrough*(CLHandle: CSSM_CL_HANDLE; CCHandle: CSSM_CC_HANDLE;
                         PassThroughId: uint32; InputParams: pointer;
                         OutputParams: ptr pointer): CSSM_RETURN
##  Data Storage Library Operations
##  --------------------------------------------------------------------------
## 	CSSM_DL_DbOpen has been deprecated in 10.7 and later.
## 	The replacement API is SecKeychainOpen
##    --------------------------------------------------------------------------

proc CSSM_DL_DbOpen*(DLHandle: CSSM_DL_HANDLE; DbName: cstring;
                    DbLocation: ptr CSSM_NET_ADDRESS;
                    AccessRequest: CSSM_DB_ACCESS_TYPE;
                    AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                    OpenParameters: pointer; DbHandle: ptr CSSM_DB_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_DbClose has been deprecated in 10.7 and later.  There is no alternate
## 	API as this call is only needed when calling CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_DbClose*(DLDBHandle: CSSM_DL_DB_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_DbCreate has been deprecated in 10.7 and later.
## 	The replacement API is SecKeychainCreate
##    --------------------------------------------------------------------------

proc CSSM_DL_DbCreate*(DLHandle: CSSM_DL_HANDLE; DbName: cstring;
                      DbLocation: ptr CSSM_NET_ADDRESS; DBInfo: ptr CSSM_DBINFO;
                      AccessRequest: CSSM_DB_ACCESS_TYPE;
                      CredAndAclEntry: ptr CSSM_RESOURCE_CONTROL_CONTEXT;
                      OpenParameters: pointer; DbHandle: ptr CSSM_DB_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_DbDelete has been deprecated in 10.7 and later.
## 	The replacement API is SecKeychainDelete
##    --------------------------------------------------------------------------

proc CSSM_DL_DbDelete*(DLHandle: CSSM_DL_HANDLE; DbName: cstring;
                      DbLocation: ptr CSSM_NET_ADDRESS;
                      AccessCred: ptr CSSM_ACCESS_CREDENTIALS): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_CreateRelation has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_CreateRelation*(DLDBHandle: CSSM_DL_DB_HANDLE;
                            RelationID: CSSM_DB_RECORDTYPE; RelationName: cstring;
                            NumberOfAttributes: uint32;
                            pAttributeInfo: ptr CSSM_DB_SCHEMA_ATTRIBUTE_INFO;
                            NumberOfIndexes: uint32;
                            pIndexInfo: ptr CSSM_DB_SCHEMA_INDEX_INFO): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_DestroyRelation has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_DestroyRelation*(DLDBHandle: CSSM_DL_DB_HANDLE;
                             RelationID: CSSM_DB_RECORDTYPE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_Authenticate has been deprecated in 10.7 and later.
## 	The replacement API is SecKeychainUnlock
##    --------------------------------------------------------------------------

proc CSSM_DL_Authenticate*(DLDBHandle: CSSM_DL_DB_HANDLE;
                          AccessRequest: CSSM_DB_ACCESS_TYPE;
                          AccessCred: ptr CSSM_ACCESS_CREDENTIALS): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_GetDbAcl has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_GetDbAcl*(DLDBHandle: CSSM_DL_DB_HANDLE;
                      SelectionTag: ptr CSSM_STRING; NumberOfAclInfos: ptr uint32;
                      AclInfos: ptr CSSM_ACL_ENTRY_INFO_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_ChangeDbAcl has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_ChangeDbAcl*(DLDBHandle: CSSM_DL_DB_HANDLE;
                         AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                         AclEdit: ptr CSSM_ACL_EDIT): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_GetDbOwner has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_GetDbOwner*(DLDBHandle: CSSM_DL_DB_HANDLE;
                        Owner: CSSM_ACL_OWNER_PROTOTYPE_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_ChangeDbOwner has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_ChangeDbOwner*(DLDBHandle: CSSM_DL_DB_HANDLE;
                           AccessCred: ptr CSSM_ACCESS_CREDENTIALS;
                           NewOwner: ptr CSSM_ACL_OWNER_PROTOTYPE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_GetDbNames has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_GetDbNames*(DLHandle: CSSM_DL_HANDLE; NameList: ptr CSSM_NAME_LIST_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_GetDbNameFromHandle has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_GetDbNameFromHandle*(DLDBHandle: CSSM_DL_DB_HANDLE;
                                 DbName: cstringArray): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_FreeNameList has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_FreeNameList*(DLHandle: CSSM_DL_HANDLE; NameList: CSSM_NAME_LIST_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_Authenticate has been deprecated in 10.7 and later.
## 	The replacement API are SecKeychainAddInternetPassword,
## 	SecKeychainAddGenericPassword, SecItemAdd
##    --------------------------------------------------------------------------

proc CSSM_DL_DataInsert*(DLDBHandle: CSSM_DL_DB_HANDLE;
                        RecordType: CSSM_DB_RECORDTYPE;
                        Attributes: ptr CSSM_DB_RECORD_ATTRIBUTE_DATA;
                        Data: ptr CSSM_DATA;
                        UniqueId: ptr CSSM_DB_UNIQUE_RECORD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_Authenticate has been deprecated in 10.7 and later.
## 	The replacement API is SecItemDelete
##    --------------------------------------------------------------------------

proc CSSM_DL_DataDelete*(DLDBHandle: CSSM_DL_DB_HANDLE;
                        UniqueRecordIdentifier: ptr CSSM_DB_UNIQUE_RECORD): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_Authenticate has been deprecated in 10.7 and later.
## 	The replacement API is SecItemUpdate
##    --------------------------------------------------------------------------

proc CSSM_DL_DataModify*(DLDBHandle: CSSM_DL_DB_HANDLE;
                        RecordType: CSSM_DB_RECORDTYPE;
                        UniqueRecordIdentifier: CSSM_DB_UNIQUE_RECORD_PTR;
    AttributesToBeModified: ptr CSSM_DB_RECORD_ATTRIBUTE_DATA;
                        DataToBeModified: ptr CSSM_DATA;
                        ModifyMode: CSSM_DB_MODIFY_MODE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_DataGetFirst has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs. SecItemCopyMatching may return multiple items if specified to
## 	do so.  The user could then retrieve the first in the list of items.
##    --------------------------------------------------------------------------

proc CSSM_DL_DataGetFirst*(DLDBHandle: CSSM_DL_DB_HANDLE; Query: ptr CSSM_QUERY;
                          ResultsHandle: CSSM_HANDLE_PTR;
                          Attributes: CSSM_DB_RECORD_ATTRIBUTE_DATA_PTR;
                          Data: CSSM_DATA_PTR;
                          UniqueId: ptr CSSM_DB_UNIQUE_RECORD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_DataGetNext has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs. SecItemCopyMatching may return multiple items if specified to
## 	do so.  The user could then retrieve the items in the list
##    --------------------------------------------------------------------------

proc CSSM_DL_DataGetNext*(DLDBHandle: CSSM_DL_DB_HANDLE;
                         ResultsHandle: CSSM_HANDLE;
                         Attributes: CSSM_DB_RECORD_ATTRIBUTE_DATA_PTR;
                         Data: CSSM_DATA_PTR;
                         UniqueId: ptr CSSM_DB_UNIQUE_RECORD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_DataAbortQuery has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_DataAbortQuery*(DLDBHandle: CSSM_DL_DB_HANDLE;
                            ResultsHandle: CSSM_HANDLE): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_DataGetFromUniqueRecordId has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_DataGetFromUniqueRecordId*(DLDBHandle: CSSM_DL_DB_HANDLE;
                                       UniqueRecord: ptr CSSM_DB_UNIQUE_RECORD;
    Attributes: CSSM_DB_RECORD_ATTRIBUTE_DATA_PTR; Data: CSSM_DATA_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_FreeUniqueRecord has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_FreeUniqueRecord*(DLDBHandle: CSSM_DL_DB_HANDLE;
                              UniqueRecord: CSSM_DB_UNIQUE_RECORD_PTR): CSSM_RETURN
##  --------------------------------------------------------------------------
## 	CSSM_DL_PassThrough has been deprecated in 10.7 and later.
## 	There is no alternate API as this call is only needed when calling
## 	CDSA APIs
##    --------------------------------------------------------------------------

proc CSSM_DL_PassThrough*(DLDBHandle: CSSM_DL_DB_HANDLE; PassThroughId: uint32;
                         InputParams: pointer; OutputParams: ptr pointer): CSSM_RETURN