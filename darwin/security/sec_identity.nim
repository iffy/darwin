##
##  Copyright (c) 2002-2011,2012-2013,2016 Apple Inc. All Rights Reserved.
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
##      @header SecIdentity
##     The functions provided in SecIdentity.h implement a convenient way to
##     match private keys with certificates.
##

when SEC_OS_OSX:
## !
##      @function SecIdentityGetTypeID
##      @abstract Returns the type identifier of SecIdentity instances.
##      @result The CFTypeID of SecIdentity instances.
##

proc SecIdentityGetTypeID*(): CFTypeID
when SEC_OS_OSX:
  ## !
  ##     @function SecIdentityCreateWithCertificate
  ##     @abstract Creates a new identity reference for the given certificate, assuming the associated private key is in one of the specified keychains.
  ##     @param keychainOrArray A reference to an array of keychains to search, a single keychain, or NULL to search the user's default keychain search list.
  ##     @param certificateRef A certificate reference.
  ##     @param identityRef On return, an identity reference. You are responsible for releasing this reference by calling the CFRelease function.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##
  proc SecIdentityCreateWithCertificate*(keychainOrArray: CFTypeRef;
                                        certificateRef: SecCertificateRef;
                                        identityRef: ptr SecIdentityRef): OSStatus
## !
##     @function SecIdentityCopyCertificate
##     @abstract Returns a reference to a certificate for the given identity
##     reference.
##     @param identityRef An identity reference.
##     @param certificateRef On return, a pointer to the found certificate
##     reference. You are responsible for releasing this reference by calling
##     the CFRelease function.
##     @result A result code. See "Security Error Codes" (SecBase.h).
##

proc SecIdentityCopyCertificate*(identityRef: SecIdentityRef;
                                certificateRef: ptr SecCertificateRef): OSStatus
## !
##      @function SecIdentityCopyPrivateKey
##     @abstract Returns the private key associated with an identity.
##     @param identityRef An identity reference.
##     @param privateKeyRef On return, a pointer to the private key for the given
##     identity. On iOS, the private key must be of class type kSecAppleKeyItemClass.
##     You are responsible for releasing this reference by calling the CFRelease function.
##     @result A result code. See "Security Error Codes" (SecBase.h).
##

proc SecIdentityCopyPrivateKey*(identityRef: SecIdentityRef;
                               privateKeyRef: ptr SecKeyRef): OSStatus
when SEC_OS_OSX:
  ## !
  ##     @function SecIdentityCopyPreference
  ##     @abstract Returns the preferred identity for the specified name and key usage, optionally limiting the result to an identity issued by a certificate whose subject is one of the distinguished names in validIssuers. If a preferred identity does not exist, NULL is returned.
  ##     @param name A string containing a URI, RFC822 email address, DNS hostname, or other name which uniquely identifies the service requiring an identity.
  ##     @param keyUsage A CSSM_KEYUSE key usage value, as defined in cssmtype.h. Pass 0 to ignore this parameter.
  ##     @param validIssuers (optional) An array of CFDataRef instances whose contents are the subject names of allowable issuers, as returned by a call to SSLCopyDistinguishedNames (SecureTransport.h). Pass NULL if any issuer is allowed.
  ##     @param identity On return, a reference to the preferred identity, or NULL if none was found. You are responsible for releasing this reference by calling the CFRelease function.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion This API is deprecated in 10.7. Please use the SecIdentityCopyPreferred API instead.
  ##
  proc SecIdentityCopyPreference*(name: CFStringRef; keyUsage: CSSM_KEYUSE;
                                 validIssuers: CFArrayRef;
                                 identity: ptr SecIdentityRef): OSStatus
  ## !
  ##     @function SecIdentityCopyPreferred
  ##     @abstract Returns the preferred identity for the specified name and key usage, optionally limiting the result to an identity issued by a certificate whose subject is one of the distinguished names in validIssuers. If a preferred identity does not exist, NULL is returned.
  ##     @param name A string containing a URI, RFC822 email address, DNS hostname, or other name which uniquely identifies the service requiring an identity.
  ##     @param keyUsage A CFArrayRef value, containing items defined in SecItem.h  Pass NULL to ignore this parameter. (kSecAttrCanEncrypt, kSecAttrCanDecrypt, kSecAttrCanDerive, kSecAttrCanSign, kSecAttrCanVerify, kSecAttrCanWrap, kSecAttrCanUnwrap)
  ##     @param validIssuers (optional) An array of CFDataRef instances whose contents are the subject names of allowable issuers, as returned by a call to SSLCopyDistinguishedNames (SecureTransport.h). Pass NULL if any issuer is allowed.
  ##     @result An identity or NULL, if the preferred identity has not been set. Your code should then typically perform a search for possible identities using the SecItem APIs.
  ##     @discussion If a preferred identity has not been set for the supplied name, the returned identity reference will be NULL. Your code should then perform a search for possible identities, using the SecItemCopyMatching API.
  ##
  proc SecIdentityCopyPreferred*(name: CFStringRef; keyUsage: CFArrayRef;
                                validIssuers: CFArrayRef): SecIdentityRef
  ## !
  ##     @function SecIdentitySetPreference
  ##     @abstract Sets the preferred identity for the specified name and key usage.
  ##     @param identity A reference to the identity which will be preferred.
  ##     @param name A string containing a URI, RFC822 email address, DNS hostname, or other name which uniquely identifies a service requiring this identity.
  ##     @param keyUsage A CSSM_KEYUSE key usage value, as defined in cssmtype.h. Pass 0 to specify any key usage.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##      @discussion This API is deprecated in 10.7. Please use the SecIdentitySetPreferred API instead.
  ##
  proc SecIdentitySetPreference*(identity: SecIdentityRef; name: CFStringRef;
                                keyUsage: CSSM_KEYUSE): OSStatus
  ## !
  ##     @function SecIdentitySetPreferred
  ##     @abstract Sets the preferred identity for the specified name and key usage.
  ##     @param identity A reference to the identity which will be preferred. If NULL is passed, any existing preference for the specified name is cleared instead.
  ##     @param name A string containing a URI, RFC822 email address, DNS hostname, or other name which uniquely identifies a service requiring this identity.
  ##     @param keyUsage A CFArrayRef value, containing items defined in SecItem.h  Pass NULL to specify any key usage. (kSecAttrCanEncrypt, kSecAttrCanDecrypt, kSecAttrCanDerive, kSecAttrCanSign, kSecAttrCanVerify, kSecAttrCanWrap, kSecAttrCanUnwrap)
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##
  proc SecIdentitySetPreferred*(identity: SecIdentityRef; name: CFStringRef;
                               keyUsage: CFArrayRef): OSStatus
  ## !
  ##      @function     SecIdentityCopySystemIdentity
  ##      @abstract     Obtain the system-wide SecIdentityRef associated with
  ##                    a specified domain.
  ##      @param        domain  Identifies the SecIdentityRef to be obtained, typically
  ##                            in the form "com.apple.subdomain...".
  ##      @param        idRef     On return, the system SecIdentityRef assicated with
  ##                              the specified domain. Caller must CFRelease this when
  ##                              finished with it.
  ##      @param        actualDomain (optional) The actual domain name of the
  ##                                 the returned identity is returned here. This
  ##                                 may be different from the requested domain.
  ##     @result        A result code.  See "Security Error Codes" (SecBase.h).
  ##      @discussion   If no system SecIdentityRef exists for the specified
  ##                    domain, a domain-specific alternate may be returned
  ##                    instead, typically (but not exclusively) the
  ##                    kSecIdentityDomainDefault SecIdentityRef.
  ##
  proc SecIdentityCopySystemIdentity*(domain: CFStringRef;
                                     idRef: ptr SecIdentityRef;
                                     actualDomain: ptr CFStringRef): OSStatus
    ##  optional
  ## !
  ##      @function     SecIdentitySetSystemIdentity
  ##      @abstract     Assign the supplied SecIdentityRef to the specified
  ##                    domain.
  ##      @param        domain Identifies the domain to which the specified
  ##                    SecIdentityRef will be assigned.
  ##      @param        idRef (optional) The identity to be assigned to the specified
  ##                    domain. Pass NULL to delete a possible entry for the specified
  ##                    domain; in this case, it is not an error if no identity
  ##                    exists for the specified domain.
  ##     @result        A result code.  See "Security Error Codes" (SecBase.h).
  ##      @discussion   The caller must be running as root.
  ##
  proc SecIdentitySetSystemIdentity*(domain: CFStringRef; idRef: SecIdentityRef): OSStatus
  ##
  ##  Defined system identity domains.
  ##
  ## !
  ##      @const kSecIdentityDomainDefault The system-wide default identity.
  ##
  var kSecIdentityDomainDefault*: CFStringRef
  ## !
  ##      @const kSecIdentityDomainKerberosKDC Kerberos KDC identity.
  ##
  var kSecIdentityDomainKerberosKDC*: CFStringRef