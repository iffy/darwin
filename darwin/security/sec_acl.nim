##
##  Copyright (c) 2002-2011 Apple Inc. All Rights Reserved.
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
##  @header SecACL
##  The functions provided in SecACL are for managing entries in the access control list.
##

when SEC_OS_OSX:
  type
    SecKeychainPromptSelector* = uint16
  const
    kSecKeychainPromptRequirePassphase* = 0x00000001 ##  require re-entering of passphrase
                                                  ##  the following bits are ignored by 10.4 and earlier
    kSecKeychainPromptUnsigned* = 0x00000010 ##  prompt for unsigned clients
    kSecKeychainPromptUnsignedAct* = 0x00000020 ##  UNSIGNED bit overrides system default
    kSecKeychainPromptInvalid* = 0x00000040 ##  prompt for invalid signed clients
    kSecKeychainPromptInvalidAct* = 0x00000080
  ## !
  ## 	 @function SecACLGetTypeID
  ## 	 @abstract Returns the type identifier of SecACL instances.
  ## 	 @result The CFTypeID of SecACL instances.
  ##
  proc SecACLGetTypeID*(): CFTypeID
  ## !
  ## 	 @function SecACLCreateFromSimpleContents
  ## 	 @abstract Creates a new access control list entry from the application list, description, and prompt selector provided and adds it to an item's access.
  ## 	 @param access An access reference.
  ## 	 @param applicationList An array of SecTrustedApplication instances that will be allowed access without prompting.
  ## 	 @param description The human readable name that will be used to refer to this item when the user is prompted.
  ## 	 @param promptSelector A pointer to a CSSM prompt selector.
  ## 	 @param newAcl A pointer to an access control list entry.  On return, this points to the reference of the new access control list entry.
  ## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
  ## 	 @discussion This function is deprecated in 10.7 and later;
  ## 	 use SecACLCreateWithSimpleContents instead.
  ##
  proc SecACLCreateFromSimpleContents*(access: SecAccessRef;
                                      applicationList: CFArrayRef;
                                      description: CFStringRef; promptSelector: ptr CSSM_ACL_KEYCHAIN_PROMPT_SELECTOR;
                                      newAcl: ptr SecACLRef): OSStatus
  ## !
  ## 	 @function SecACLCreateWithSimpleContents
  ## 	 @abstract Creates a new access control list entry from the application list, description, and prompt selector provided and adds it to an item's access.
  ## 	 @param access An access reference.
  ## 	 @param applicationList An array of SecTrustedApplication instances that will be allowed access without prompting.
  ## 	 @param description The human readable name that will be used to refer to this item when the user is prompted.
  ## 	 @param promptSelector A SecKeychainPromptSelector selector.
  ## 	 @param newAcl A pointer to an access control list entry.  On return, this points to the reference of the new access control list entry.
  ## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
  ##
  proc SecACLCreateWithSimpleContents*(access: SecAccessRef;
                                      applicationList: CFArrayRef;
                                      description: CFStringRef; promptSelector: SecKeychainPromptSelector;
                                      newAcl: ptr SecACLRef): OSStatus
  ## !
  ## 	 @function SecACLRemove
  ## 	 @abstract Removes the access control list entry specified.
  ## 	 @param aclRef The reference to the access control list entry to remove.
  ## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
  ##
  proc SecACLRemove*(aclRef: SecACLRef): OSStatus
  ## !
  ## 	 @function SecACLCopySimpleContents
  ## 	 @abstract Returns the application list, description, and CSSM prompt selector for a given access control list entry.
  ## 	 @param acl An access control list entry reference.
  ## 	 @param applicationList On return, An array of SecTrustedApplication instances that will be allowed access without prompting, for the given access control list entry.  The caller needs to call CFRelease on this array when it's no longer needed.
  ## 	 @param description On return, the human readable name that will be used to refer to this item when the user is prompted, for the given access control list entry. The caller needs to call CFRelease on this string when it's no longer needed.
  ## 	 @param promptSelector A pointer to a CSSM prompt selector.  On return, this points to the CSSM prompt selector for the given access control list entry.
  ## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
  ## 	 @discussion This function is deprecated in 10.7 and later;
  ## 	 use SecACLCopyContents instead.
  ##
  proc SecACLCopySimpleContents*(acl: SecACLRef; applicationList: ptr CFArrayRef;
                                description: ptr CFStringRef; promptSelector: ptr CSSM_ACL_KEYCHAIN_PROMPT_SELECTOR): OSStatus
  ## !
  ## 	 @function SecACLCopyContents
  ## 	 @abstract Returns the application list, description, and prompt selector for a given access control list entry.
  ## 	 @param acl An access control list entry reference.
  ## 	 @param applicationList On return, An array of SecTrustedApplication instances that will be allowed access without prompting, for the given access control list entry.  The caller needs to call CFRelease on this array when it's no longer needed.
  ## 	 @param description On return, the human readable name that will be used to refer to this item when the user is prompted, for the given access control list entry. The caller needs to call CFRelease on this string when it's no longer needed.
  ## 	 @param promptSelector A pointer to a SecKeychainPromptSelector.  On return, this points to the SecKeychainPromptSelector for the given access control list entry.
  ## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
  ##
  proc SecACLCopyContents*(acl: SecACLRef; applicationList: ptr CFArrayRef;
                          description: ptr CFStringRef;
                          promptSelector: ptr SecKeychainPromptSelector): OSStatus
  ## !
  ## 	 @function SecACLSetSimpleContents
  ## 	 @abstract Sets the application list, description, and CSSM prompt selector for a given access control list entry.
  ## 	 @param acl A reference to the access control list entry to edit.
  ## 	 @param applicationList An application list reference.
  ## 	 @param description The human readable name that will be used to refer to this item when the user is prompted.
  ## 	 @param promptSelector A pointer to a CSSM prompt selector.
  ## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
  ## 	 @discussion This function is deprecated in 10.7 and later;
  ## 	 use SecACLSetContents instead.
  ##
  proc SecACLSetSimpleContents*(acl: SecACLRef; applicationList: CFArrayRef;
                               description: CFStringRef; promptSelector: ptr CSSM_ACL_KEYCHAIN_PROMPT_SELECTOR): OSStatus
  ## !
  ## 	 @function SecACLSetContents
  ## 	 @abstract Sets the application list, description, and prompt selector for a given access control list entry.
  ## 	 @param acl A reference to the access control list entry to edit.
  ## 	 @param applicationList An application list reference.
  ## 	 @param description The human readable name that will be used to refer to this item when the user is prompted.
  ## 	 @param promptSelector A SecKeychainPromptSelector selector.
  ## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
  ##
  proc SecACLSetContents*(acl: SecACLRef; applicationList: CFArrayRef;
                         description: CFStringRef;
                         promptSelector: SecKeychainPromptSelector): OSStatus
## !
## 	 @function SecACLGetAuthorizations
## 	 @abstract Retrieve the CSSM authorization tags of a given access control list entry.
## 	 @param acl An access control list entry reference.
## 	 @param tags On return, this points to the first item in an array of CSSM authorization tags.
## 	 @param tagCount On return, this points to the number of tags in the CSSM authorization tag array.
## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
## 	 @discussion This function is deprecated in 10.7 and later;
## 	 use SecACLCopyAuthorizations instead.
##

proc SecACLGetAuthorizations*(acl: SecACLRef; tags: ptr CSSM_ACL_AUTHORIZATION_TAG;
                             tagCount: ptr uint32): OSStatus
## !
## 	 @function SecACLCopyAuthorizations
## 	 @abstract Retrieve the authorization tags of a given access control list entry.
## 	 @param acl An access control list entry reference.
## 	 @result On return, a CFArrayRef of the authorizations for this ACL.
##

proc SecACLCopyAuthorizations*(acl: SecACLRef): CFArrayRef
## !
## 	 @function SecACLSetAuthorizations
## 	 @abstract Sets the CSSM authorization tags of a given access control list entry.
## 	 @param acl An access control list entry reference.
## 	 @param tags A pointer to the first item in an array of CSSM authorization tags.
## 	 @param tagCount The number of tags in the CSSM authorization tag array.
## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
## 	 @discussion This function is deprecated in 10.7 and later;
## 	 use SecACLUpdateAuthorizations instead.
##

proc SecACLSetAuthorizations*(acl: SecACLRef; tags: ptr CSSM_ACL_AUTHORIZATION_TAG;
                             tagCount: uint32): OSStatus
## !
## 	 @function SecACLUpdateAuthorizations
## 	 @abstract Sets the authorization tags of a given access control list entry.
## 	 @param acl An access control list entry reference.
## 	 @param authorizations A pointer to an array of authorization tags.
## 	 @result A result code.  See "Security Error Codes" (SecBase.h).
##

proc SecACLUpdateAuthorizations*(acl: SecACLRef; authorizations: CFArrayRef): OSStatus