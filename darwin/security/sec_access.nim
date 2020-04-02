##
##  Copyright (c) 2002-2004,2011,2014 Apple Inc. All Rights Reserved.
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
## !
## 	@header SecAccess
## 	SecAccess implements a way to set and manipulate access control rules and
## 	restrictions on SecKeychainItems.
##

type
  SecAccessOwnerType* = UInt32

const
  kSecUseOnlyUID* = 1
  kSecUseOnlyGID* = 2
  kSecHonorRoot* = 0x00000100
  kSecMatchBits* = (kSecUseOnlyUID or kSecUseOnlyGID)

##  No restrictions. Permission to perform all operations on
##    the resource or available to an ACL owner.

var kSecACLAuthorizationAny*: CFStringRef

var kSecACLAuthorizationLogin*: CFStringRef

var kSecACLAuthorizationGenKey*: CFStringRef

var kSecACLAuthorizationDelete*: CFStringRef

var kSecACLAuthorizationExportWrapped*: CFStringRef

var kSecACLAuthorizationExportClear*: CFStringRef

var kSecACLAuthorizationImportWrapped*: CFStringRef

var kSecACLAuthorizationImportClear*: CFStringRef

var kSecACLAuthorizationSign*: CFStringRef

var kSecACLAuthorizationEncrypt*: CFStringRef

var kSecACLAuthorizationDecrypt*: CFStringRef

var kSecACLAuthorizationMAC*: CFStringRef

var kSecACLAuthorizationDerive*: CFStringRef

##  Defined authorization tag values for Keychain

var kSecACLAuthorizationKeychainCreate*: CFStringRef

var kSecACLAuthorizationKeychainDelete*: CFStringRef

var kSecACLAuthorizationKeychainItemRead*: CFStringRef

var kSecACLAuthorizationKeychainItemInsert*: CFStringRef

var kSecACLAuthorizationKeychainItemModify*: CFStringRef

var kSecACLAuthorizationKeychainItemDelete*: CFStringRef

var kSecACLAuthorizationChangeACL*: CFStringRef

var kSecACLAuthorizationChangeOwner*: CFStringRef

var kSecACLAuthorizationPartitionID*: CFStringRef

var kSecACLAuthorizationIntegrity*: CFStringRef

## !
## 	@function SecAccessGetTypeID
## 	@abstract Returns the type identifier of SecAccess instances.
## 	@result The CFTypeID of SecAccess instances.
##

proc SecAccessGetTypeID*(): CFTypeID
## !
## 	@function SecAccessCreate
## 	@abstract Creates a new SecAccessRef that is set to the currently designated system default
## 		configuration of a (newly created) security object. Note that the precise nature of
## 		this default may change between releases.
## 	@param descriptor The name of the item as it should appear in security dialogs
## 	@param trustedlist A CFArray of TrustedApplicationRefs, specifying which applications
## 		should be allowed to access an item without triggering confirmation dialogs.
## 		If NULL, defaults to (just) the application creating the item. To set no applications,
## 		pass a CFArray with no elements.
## 	@param accessRef On return, a pointer to the new access reference.
## 	@result A result code.  See "Security Error Codes" (SecBase.h).
##

proc SecAccessCreate*(descriptor: CFStringRef; trustedlist: CFArrayRef;
                     accessRef: ptr SecAccessRef): OSStatus
## !
## 	@function SecAccessCreateFromOwnerAndACL
## 	@abstract Creates a new SecAccessRef using the owner and access control list you provide.
## 	@param owner A pointer to a CSSM access control list owner.
## 	@param aclCount An unsigned 32-bit integer representing the number of items in the access control list.
## 	@param acls A pointer to the access control list.
## 	@param accessRef On return, a pointer to the new access reference.
## 	@result A result code.  See "Security Error Codes" (SecBase.h).
## 	@discussion For 10.7 and later please use the SecAccessCreateWithOwnerAndACL API
##

proc SecAccessCreateFromOwnerAndACL*(owner: ptr CSSM_ACL_OWNER_PROTOTYPE;
                                    aclCount: uint32;
                                    acls: ptr CSSM_ACL_ENTRY_INFO;
                                    accessRef: ptr SecAccessRef): OSStatus
## !
## 	@function SecAccessCreateWithOwnerAndACL
## 	@abstract Creates a new SecAccessRef using either for a user or a group with a list of ACLs
## 	@param userId An user id that specifies the user to associate with this SecAccessRef.
## 	@param groupId A group id that specifies the group to associate with this SecAccessRef.
## 	@param ownerType Specifies the how the ownership of the new SecAccessRef is defined.
## 	@param acls A CFArrayRef of the ACLs to associate with this SecAccessRef
## 	@param error Optionally a pointer to a CFErrorRef to return any errors with may have occured
## 	@result  A pointer to the new access reference.
##

proc SecAccessCreateWithOwnerAndACL*(userId: uid_t; groupId: gid_t;
                                    ownerType: SecAccessOwnerType;
                                    acls: CFArrayRef; error: ptr CFErrorRef): SecAccessRef
## !
## 	@function SecAccessGetOwnerAndACL
## 	@abstract Retrieves the owner and the access control list of a given access.
## 	@param accessRef A reference to the access from which to retrieve the information.
## 	@param owner On return, a pointer to the access control list owner.
## 	@param aclCount On return, a pointer to an unsigned 32-bit integer representing the number of items in the access control list.
## 	@param acls On return, a pointer to the access control list.
## 	@result A result code.  See "Security Error Codes" (SecBase.h).
## 	@discussion For 10.7 and later please use the SecAccessCopyOwnerAndACL API
##

proc SecAccessGetOwnerAndACL*(accessRef: SecAccessRef;
                             owner: ptr CSSM_ACL_OWNER_PROTOTYPE_PTR;
                             aclCount: ptr uint32;
                             acls: ptr CSSM_ACL_ENTRY_INFO_PTR): OSStatus
## !
## 	@function SecAccessCopyOwnerAndACL
## 	@abstract Retrieves the owner and the access control list of a given access.
## 	@param accessRef A reference to the access from which to retrieve the information.
## 	@param userId On return, the user id of the owner
## 	@param groupId On return, the group id of the owner
## 	@param ownerType On return, the type of owner for this AccessRef
## 	@param aclList On return, a pointer to a new created CFArray of SecACL instances.  The caller is responsible for calling CFRelease on this array.
## 	@result A result code.  See "Security Error Codes" (SecBase.h).
##

proc SecAccessCopyOwnerAndACL*(accessRef: SecAccessRef; userId: ptr uid_t;
                              groupId: ptr gid_t;
                              ownerType: ptr SecAccessOwnerType;
                              aclList: ptr CFArrayRef): OSStatus
## !
## 	@function SecAccessCopyACLList
## 	@abstract Copies all the access control lists of a given access.
## 	@param accessRef A reference to the access from which to retrieve the information.
## 	@param aclList On return, a pointer to a new created CFArray of SecACL instances.  The caller is responsible for calling CFRelease on this array.
## 	@result A result code.  See "Security Error Codes" (SecBase.h).
##

proc SecAccessCopyACLList*(accessRef: SecAccessRef; aclList: ptr CFArrayRef): OSStatus
## !
## 	@function SecAccessCopySelectedACLList
## 	@abstract Copies selected access control lists from a given access.
## 	@param accessRef A reference to the access from which to retrieve the information.
## 	@param action An authorization tag specifying what action with which to select the action control lists.
## 	@param aclList On return, a pointer to the selected access control lists.
## 	@result A result code.  See "Security Error Codes" (SecBase.h).
## 	@discussion For 10.7 and later please use the SecAccessCopyMatchingACLList API
##

proc SecAccessCopySelectedACLList*(accessRef: SecAccessRef;
                                  action: CSSM_ACL_AUTHORIZATION_TAG;
                                  aclList: ptr CFArrayRef): OSStatus
## !
## 	@function SecAccessCopyMatchingACLList
## 	@abstract Copies selected access control lists from a given access.
## 	@param accessRef A reference to the access from which to retrieve the information.
## 	@param authorizationTag An authorization tag specifying what action with which to select the action control lists.
## 	@result A pointer to the selected access control lists.
##

proc SecAccessCopyMatchingACLList*(accessRef: SecAccessRef;
                                  authorizationTag: CFTypeRef): CFArrayRef