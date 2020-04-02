##
##  Copyright (c) 2006-2014,2016 Apple Inc. All Rights Reserved.
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
## 	@header SecKey
## 	The functions provided in SecKey.h implement and manage a particular
##     type of keychain item that represents a key.  A key can be stored in a
##     keychain, but a key can also be a transient object.
##
## 	On OSX, you can use a SecKey as a SecKeychainItem in most functions.
##

when SEC_OS_OSX:
when SEC_OS_OSX:
  ## !
  ## 	@enum KeyItemAttributeConstants
  ## 	@abstract Specifies keychain item attributes for keys.
  ##     @constant kSecKeyKeyClass type uint32 (CSSM_KEYCLASS), value
  ##     is one of CSSM_KEYCLASS_PUBLIC_KEY, CSSM_KEYCLASS_PRIVATE_KEY
  ##     or CSSM_KEYCLASS_SESSION_KEY.
  ##     @constant kSecKeyPrintName type blob, human readable name of
  ##     the key.  Same as kSecLabelItemAttr for normal keychain items.
  ##     @constant kSecKeyAlias type blob, currently unused.
  ##     @constant kSecKeyPermanent type uint32, value is nonzero iff
  ##     this key is permanent (stored in some keychain).  This is always
  ##     1.
  ##     @constant kSecKeyPrivate type uint32, value is nonzero iff this
  ##     key is protected by a user login or a password, or both.
  ##     @constant kSecKeyModifiable type uint32, value is nonzero iff
  ##     attributes of this key can be modified.
  ##     @constant kSecKeyLabel type blob, for private and public keys
  ##     this contains the hash of the public key.  This is used to
  ##     associate certificates and keys.  Its value matches the value
  ##     of the kSecPublicKeyHashItemAttr of a certificate and it's used
  ##     to construct an identity from a certificate and a key.
  ##     For symmetric keys this is whatever the creator of the key
  ##     passed in during the generate key call.
  ##     @constant kSecKeyApplicationTag type blob, currently unused.
  ##     @constant kSecKeyKeyCreator type data, the data points to a
  ##     CSSM_GUID structure representing the moduleid of the csp owning
  ##     this key.
  ##     @constant kSecKeyKeyType type uint32, value is a CSSM_ALGORITHMS
  ##     representing the algorithm associated with this key.
  ##     @constant kSecKeyKeySizeInBits type uint32, value is the number
  ##     of bits in this key.
  ##     @constant kSecKeyEffectiveKeySize type uint32, value is the
  ##     effective number of bits in this key.  For example a des key
  ##     has a kSecKeyKeySizeInBits of 64 but a kSecKeyEffectiveKeySize
  ##     of 56.
  ##     @constant kSecKeyStartDate type CSSM_DATE.  Earliest date from
  ##     which this key may be used.  If the value is all zeros or not
  ##     present, no restriction applies.
  ##     @constant kSecKeyEndDate type CSSM_DATE.  Latest date at
  ##     which this key may be used.  If the value is all zeros or not
  ##     present, no restriction applies.
  ##     @constant kSecKeySensitive type uint32, iff value is nonzero
  ##     this key cannot be wrapped with CSSM_ALGID_NONE.
  ##     @constant kSecKeyAlwaysSensitive type uint32, value is nonzero
  ##     iff this key has always been marked sensitive.
  ##     @constant kSecKeyExtractable type uint32, value is nonzero iff
  ##     this key can be wrapped.
  ##     @constant kSecKeyNeverExtractable type uint32, value is nonzero
  ##     iff this key was never marked extractable.
  ##     @constant kSecKeyEncrypt type uint32, value is nonzero iff this
  ##     key can be used in an encrypt operation.
  ##     @constant kSecKeyDecrypt type uint32, value is nonzero iff this
  ##     key can be used in a decrypt operation.
  ##     @constant kSecKeyDerive type uint32, value is nonzero iff this
  ##     key can be used in a deriveKey operation.
  ##     @constant kSecKeySign type uint32, value is nonzero iff this
  ##     key can be used in a sign operation.
  ##     @constant kSecKeyVerify type uint32, value is nonzero iff this
  ##     key can be used in a verify operation.
  ##     @constant kSecKeySignRecover type uint32.
  ##     @constant kSecKeyVerifyRecover type uint32.
  ##     key can unwrap other keys.
  ##     @constant kSecKeyWrap type uint32, value is nonzero iff this
  ##     key can wrap other keys.
  ##     @constant kSecKeyUnwrap type uint32, value is nonzero iff this
  ##     key can unwrap other keys.
  ## 	@discussion
  ## 	The use of these enumerations has been deprecated.  Please
  ## 	use the equivalent items defined in SecItem.h
  ## 	@@@.
  ##
  const
    kSecKeyKeyClass* = 0
    kSecKeyPrintName* = 1
    kSecKeyAlias* = 2
    kSecKeyPermanent* = 3
    kSecKeyPrivate* = 4
    kSecKeyModifiable* = 5
    kSecKeyLabel* = 6
    kSecKeyApplicationTag* = 7
    kSecKeyKeyCreator* = 8
    kSecKeyKeyType* = 9
    kSecKeyKeySizeInBits* = 10
    kSecKeyEffectiveKeySize* = 11
    kSecKeyStartDate* = 12
    kSecKeyEndDate* = 13
    kSecKeySensitive* = 14
    kSecKeyAlwaysSensitive* = 15
    kSecKeyExtractable* = 16
    kSecKeyNeverExtractable* = 17
    kSecKeyEncrypt* = 18
    kSecKeyDecrypt* = 19
    kSecKeyDerive* = 20
    kSecKeySign* = 21
    kSecKeyVerify* = 22
    kSecKeySignRecover* = 23
    kSecKeyVerifyRecover* = 24
    kSecKeyWrap* = 25
    kSecKeyUnwrap* = 26
  ## !
  ##     @enum SecCredentialType
  ##     @abstract Determines the type of credential returned by SecKeyGetCredentials.
  ##     @constant kSecCredentialTypeWithUI Operations with this key are allowed to present UI if required.
  ##     @constant kSecCredentialTypeNoUI Operations with this key are not allowed to present UI, and will fail if UI is required.
  ##     @constant kSecCredentialTypeDefault The default setting for determining whether to present UI is used. This setting can be changed with a call to SecKeychainSetUserInteractionAllowed.
  ##
  type
    SecCredentialType* = uint32
  const
    kSecCredentialTypeDefault* = 0
    kSecCredentialTypeWithUI* = 1
    kSecCredentialTypeNoUI* = 2
## !
##     @typedef SecPadding
##     @abstract Supported padding types.
##

type
  SecPadding* = uint32_t

const
  kSecPaddingNone* = 0
  kSecPaddingPKCS1* = 1
  kSecPaddingOAEP* = 2 ##  __OSX_UNAVAILABLE   ,
                    ##  For SecKeyRawSign/SecKeyRawVerify only,
                    ##      ECDSA signature is raw byte format {r,s}, big endian.
                    ##      First half is r, second half is s
  kSecPaddingSigRaw* = 0x00004000 ##  For SecKeyRawSign/SecKeyRawVerify only, data to be signed is an MD2
                               ##        hash; standard ASN.1 padding will be done, as well as PKCS1 padding
                               ##        of the underlying RSA operation.
  kSecPaddingPKCS1MD2* = 0x00008000 ##  __OSX_DEPRECATED(10.0, 10.12, "MD2 is deprecated") __IOS_DEPRECATED(2.0, 5.0, "MD2 is deprecated") __TVOS_UNAVAILABLE __WATCHOS_UNAVAILABLE,
                                 ##  For SecKeyRawSign/SecKeyRawVerify only, data to be signed is an MD5
                                 ##        hash; standard ASN.1 padding will be done, as well as PKCS1 padding
                                 ##        of the underlying RSA operation.
  kSecPaddingPKCS1MD5* = 0x00008001 ##  __OSX_DEPRECATED(10.0, 10.12, "MD5 is deprecated") __IOS_DEPRECATED(2.0, 5.0, "MD5 is deprecated") __TVOS_UNAVAILABLE __WATCHOS_UNAVAILABLE,
                                 ##  For SecKeyRawSign/SecKeyRawVerify only, data to be signed is a SHA1
                                 ##        hash; standard ASN.1 padding will be done, as well as PKCS1 padding
                                 ##        of the underlying RSA operation.
  kSecPaddingPKCS1SHA1* = 0x00008002 ##  For SecKeyRawSign/SecKeyRawVerify only, data to be signed is a SHA224
                                  ##      hash; standard ASN.1 padding will be done, as well as PKCS1 padding
                                  ##      of the underlying RSA operation.
  kSecPaddingPKCS1SHA224* = 0x00008003 ##  __OSX_UNAVAILABLE ,
                                    ##  For SecKeyRawSign/SecKeyRawVerify only, data to be signed is a SHA256
                                    ##      hash; standard ASN.1 padding will be done, as well as PKCS1 padding
                                    ##      of the underlying RSA operation.
  kSecPaddingPKCS1SHA256* = 0x00008004 ##  __OSX_UNAVAILABLE ,
                                    ##  For SecKeyRawSign/SecKeyRawVerify only, data to be signed is a SHA384
                                    ##      hash; standard ASN.1 padding will be done, as well as PKCS1 padding
                                    ##      of the underlying RSA operation.
  kSecPaddingPKCS1SHA384* = 0x00008005 ##  __OSX_UNAVAILABLE ,
                                    ##  For SecKeyRawSign/SecKeyRawVerify only, data to be signed is a SHA512
                                    ##      hash; standard ASN.1 padding will be done, as well as PKCS1 padding
                                    ##      of the underlying RSA operation.
  kSecPaddingPKCS1SHA512* = 0x00008006 ##  __OSX_UNAVAILABLE ,

when SEC_OS_OSX:
  ## !
  ##     @typedef SecKeySizes
  ##     @abstract Supported key lengths.
  ##
  type
    SecKeySizes* = uint32_t
  const
    kSecDefaultKeySize* = 0     ##  Symmetric Keysizes - default is currently kSecAES128 for AES.
    kSec3DES192* = 192
    kSecAES128* = 128
    kSecAES192* = 192
    kSecAES256* = 256 ##  Supported ECC Keys for Suite-B from RFC 4492 section 5.1.1.
                   ##  default is currently kSecp256r1
    kSecp192r1* = 192
    kSecp256r1* = 256
    kSecp384r1* = 384
    kSecp521r1* = 521 ##  Yes, 521
                   ##  Boundaries for RSA KeySizes - default is currently 2048
                   ##  RSA keysizes must be multiples of 8
    kSecRSAMin* = 1024
    kSecRSAMax* = 4096
## !
## 	@enum Key Parameter Constants
## 	@discussion Predefined key constants used to get or set values in a dictionary.
## 	These are used to provide explicit parameters to key generation functions
## 	when non-default values are desired. See the description of the
## 	SecKeyGeneratePair API for usage information.
## 	@constant kSecPrivateKeyAttrs The value for this key is a CFDictionaryRef
## 	 containing attributes specific for the private key to be generated.
## 	@constant kSecPublicKeyAttrs The value for this key is a CFDictionaryRef
## 	 containing attributes specific for the public key to be generated.
##

var kSecPrivateKeyAttrs*: CFStringRef

var kSecPublicKeyAttrs*: CFStringRef

## !
## 	@function SecKeyGetTypeID
## 	@abstract Returns the type identifier of SecKey instances.
## 	@result The CFTypeID of SecKey instances.
##

proc SecKeyGetTypeID*(): CFTypeID
when SEC_OS_OSX:
  ## !
  ## 	@function SecKeyCreatePair
  ## 	@abstract Creates an asymmetric key pair and stores it in a specified keychain.
  ## 	@param keychainRef A reference to the keychain in which to store the private and public key items. Specify NULL for the default keychain.
  ## 	@param algorithm An algorithm for the key pair. This parameter is ignored if a valid (non-zero) contextHandle is supplied.
  ## 	@param keySizeInBits A key size for the key pair. This parameter is ignored if a valid (non-zero) contextHandle is supplied.
  ## 	@param contextHandle (optional) A CSSM_CC_HANDLE, or 0. If this argument is supplied, the algorithm and keySizeInBits parameters are ignored. If extra parameters are needed to generate a key (some algorithms require this), you should create a context using CSSM_CSP_CreateKeyGenContext, using the CSPHandle obtained by calling SecKeychainGetCSPHandle. Then use CSSM_UpdateContextAttributes to add parameters, and dispose of the context using CSSM_DeleteContext after calling this function.
  ## 	@param publicKeyUsage A bit mask indicating all permitted uses for the new public key. CSSM_KEYUSE bit mask values are defined in cssmtype.h.
  ## 	@param publicKeyAttr A bit mask defining attribute values for the new public key. The bit mask values are equivalent to a CSSM_KEYATTR_FLAGS and are defined in cssmtype.h.
  ## 	@param privateKeyUsage A bit mask indicating all permitted uses for the new private key. CSSM_KEYUSE bit mask values are defined in cssmtype.h.
  ## 	@param privateKeyAttr A bit mask defining attribute values for the new private key. The bit mask values are equivalent to a CSSM_KEYATTR_FLAGS and are defined in cssmtype.h.
  ## 	@param initialAccess (optional) A SecAccess object that determines the initial access rights to the private key. The public key is given "any/any" access rights by default.
  ## 	@param publicKey (optional) On return, the keychain item reference of the generated public key. Use the SecKeyGetCSSMKey function to obtain the CSSM_KEY. The caller must call CFRelease on this value if it is returned. Pass NULL if a reference to this key is not required.
  ## 	@param privateKey (optional) On return, the keychain item reference of the generated private key. Use the SecKeyGetCSSMKey function to obtain the CSSM_KEY. The caller must call CFRelease on this value if it is returned. Pass NULL if a reference to this key is not required.
  ## 	@result A result code. See "Security Error Codes" (SecBase.h).
  ## 	@discussion This API is deprecated for 10.7. Please use the SecKeyGeneratePair API instead.
  ##
  proc SecKeyCreatePair*(keychainRef: SecKeychainRef; algorithm: CSSM_ALGORITHMS;
                        keySizeInBits: uint32; contextHandle: CSSM_CC_HANDLE;
                        publicKeyUsage: CSSM_KEYUSE; publicKeyAttr: uint32;
                        privateKeyUsage: CSSM_KEYUSE; privateKeyAttr: uint32;
                        initialAccess: SecAccessRef; publicKey: ptr SecKeyRef;
                        privateKey: ptr SecKeyRef): OSStatus
  ## !
  ## 	@function SecKeyGenerate
  ## 	@abstract Creates a symmetric key and optionally stores it in a specified keychain.
  ## 	@param keychainRef (optional) A reference to the keychain in which to store the generated key. Specify NULL to generate a transient key.
  ## 	@param algorithm An algorithm for the symmetric key. This parameter is ignored if a valid (non-zero) contextHandle is supplied.
  ## 	@param keySizeInBits A key size for the key pair. This parameter is ignored if a valid (non-zero) contextHandle is supplied.
  ## 	@param contextHandle (optional) A CSSM_CC_HANDLE, or 0. If this argument is supplied, the algorithm and keySizeInBits parameters are ignored. If extra parameters are needed to generate a key (some algorithms require this), you should create a context using CSSM_CSP_CreateKeyGenContext, using the CSPHandle obtained by calling SecKeychainGetCSPHandle. Then use CSSM_UpdateContextAttributes to add parameters, and dispose of the context using CSSM_DeleteContext after calling this function.
  ## 	@param keyUsage A bit mask indicating all permitted uses for the new key. CSSM_KEYUSE bit mask values are defined in cssmtype.h.
  ## 	@param keyAttr A bit mask defining attribute values for the new key. The bit mask values are equivalent to a CSSM_KEYATTR_FLAGS and are defined in cssmtype.h.
  ## 	@param initialAccess (optional) A SecAccess object that determines the initial access rights for the key. This parameter is ignored if the keychainRef is NULL.
  ## 	@param keyRef On return, a reference to the generated key. Use the SecKeyGetCSSMKey function to obtain the CSSM_KEY. The caller must call CFRelease on this value if it is returned.
  ## 	@result A result code.  See "Security Error Codes" (SecBase.h).
  ## 	@discussion This API is deprecated for 10.7.  Please use the SecKeyGenerateSymmetric API instead.
  ##
  proc SecKeyGenerate*(keychainRef: SecKeychainRef; algorithm: CSSM_ALGORITHMS;
                      keySizeInBits: uint32; contextHandle: CSSM_CC_HANDLE;
                      keyUsage: CSSM_KEYUSE; keyAttr: uint32;
                      initialAccess: SecAccessRef; keyRef: ptr SecKeyRef): OSStatus
  ## !
  ##     @function SecKeyGetCSSMKey
  ##     @abstract Returns a pointer to the CSSM_KEY for the given key item reference.
  ##     @param key A keychain key item reference. The key item must be of class type kSecPublicKeyItemClass, kSecPrivateKeyItemClass, or kSecSymmetricKeyItemClass.
  ##     @param cssmKey On return, a pointer to a CSSM_KEY structure for the given key. This pointer remains valid until the key reference is released. The caller should not attempt to modify or free this data.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion  The CSSM_KEY is valid until the key item reference is released. This API is deprecated in 10.7. Its use should no longer be needed.
  ##
  proc SecKeyGetCSSMKey*(key: SecKeyRef; cssmKey: ptr ptr CSSM_KEY): OSStatus
  ## !
  ##     @function SecKeyGetCSPHandle
  ##     @abstract Returns the CSSM_CSP_HANDLE for the given key reference. The handle is valid until the key reference is released.
  ##     @param keyRef A key reference.
  ##     @param cspHandle On return, the CSSM_CSP_HANDLE for the given keychain.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ## 	@discussion This API is deprecated in 10.7. Its use should no longer be needed.
  ##
  proc SecKeyGetCSPHandle*(keyRef: SecKeyRef; cspHandle: ptr CSSM_CSP_HANDLE): OSStatus
  ## !
  ##     @function SecKeyGetCredentials
  ##     @abstract For a given key, return a pointer to a CSSM_ACCESS_CREDENTIALS structure which will allow the key to be used.
  ##     @param keyRef The key for which a credential is requested.
  ##     @param operation The type of operation to be performed with this key. See "Authorization tag type" for defined operations (cssmtype.h).
  ##     @param credentialType The type of credential requested.
  ##     @param outCredentials On return, a pointer to a CSSM_ACCESS_CREDENTIALS structure. This pointer remains valid until the key reference is released. The caller should not attempt to modify or free this data.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##
  proc SecKeyGetCredentials*(keyRef: SecKeyRef;
                            operation: CSSM_ACL_AUTHORIZATION_TAG;
                            credentialType: SecCredentialType;
                            outCredentials: ptr ptr CSSM_ACCESS_CREDENTIALS): OSStatus
  ## !
  ##  @function	SecKeyGenerateSymmetric
  ##  @abstract	Generates a random symmetric key with the specified length
  ##  and algorithm type.
  ##
  ##  @param parameters A dictionary containing one or more key-value pairs.
  ##  See the discussion sections below for a complete overview of options.
  ##  @param error An optional pointer to a CFErrorRef. This value is set
  ##  if an error occurred. If not NULL, the caller is responsible for
  ##  releasing the CFErrorRef.
  ##  @result On return, a SecKeyRef reference to the symmetric key, or
  ##  NULL if the key could not be created.
  ##
  ##  @discussion In order to generate a symmetric key, the parameters dictionary
  ##  must at least contain the following keys:
  ##
  ##  kSecAttrKeyType with a value of kSecAttrKeyTypeAES or any other
  ##  kSecAttrKeyType defined in SecItem.h
  ##  kSecAttrKeySizeInBits with a value being a CFNumberRef containing
  ##  the requested key size in bits.  Example sizes for AES keys are:
  ##  128, 192, 256, 512.
  ##
  ##  To store the generated symmetric key in a keychain, set these keys:
  ##  kSecUseKeychain (value is a SecKeychainRef)
  ##  kSecAttrLabel (a user-visible label whose value is a CFStringRef,
  ##  e.g. "My App's Encryption Key")
  ##  kSecAttrApplicationLabel (a label defined by your application, whose
  ##  value is a CFDataRef and which can be used to find this key in a
  ##  subsequent call to SecItemCopyMatching, e.g. "ID-1234567890-9876-0151")
  ##
  ##  To specify the generated key's access control settings, set this key:
  ##  kSecAttrAccess (value is a SecAccessRef)
  ##
  ##  The keys below may be optionally set in the parameters dictionary
  ##  (with a CFBooleanRef value) to override the default usage values:
  ##
  ##  kSecAttrCanEncrypt (defaults to true if not explicitly specified)
  ##  kSecAttrCanDecrypt (defaults to true if not explicitly specified)
  ##  kSecAttrCanWrap (defaults to true if not explicitly specified)
  ##  kSecAttrCanUnwrap (defaults to true if not explicitly specified)
  ##
  ##
  proc SecKeyGenerateSymmetric*(parameters: CFDictionaryRef; error: ptr CFErrorRef): SecKeyRef
  ## !
  ##  @function SecKeyCreateFromData
  ##  @abstract Creates a symmetric key with the given data and sets the
  ##  algorithm type specified.
  ##
  ##  @param parameters A dictionary containing one or more key-value pairs.
  ##  See the discussion sections below for a complete overview of options.
  ##  @result On return, a SecKeyRef reference to the symmetric key.
  ##
  ##  @discussion In order to generate a symmetric key the parameters dictionary must
  ##  at least contain the following keys:
  ##
  ##  kSecAttrKeyType with a value of kSecAttrKeyTypeAES or any other
  ##  kSecAttrKeyType defined in SecItem.h
  ##
  ##  The keys below may be optionally set in the parameters dictionary
  ##  (with a CFBooleanRef value) to override the default usage values:
  ##
  ##  kSecAttrCanEncrypt (defaults to true if not explicitly specified)
  ##  kSecAttrCanDecrypt (defaults to true if not explicitly specified)
  ##  kSecAttrCanWrap (defaults to true if not explicitly specified)
  ##  kSecAttrCanUnwrap (defaults to true if not explicitly specified)
  ##
  ##
  proc SecKeyCreateFromData*(parameters: CFDictionaryRef; keyData: CFDataRef;
                            error: ptr CFErrorRef): SecKeyRef
  ##  Derive, Wrap, and Unwrap
  ## !
  ##  @function SecKeyDeriveFromPassword
  ##  @abstract Derives a symmetric key from a password.
  ##
  ##  @param password The password from which the keyis to be derived.
  ##  @param parameters A dictionary containing one or more key-value pairs.
  ##  @param error If the call fails this will contain the error code.
  ##
  ##  @discussion In order to derive a key the parameters dictionary must contain at least contain the following keys:
  ##  kSecAttrSalt - a CFData for the salt value for mixing in the pseudo-random rounds.
  ##  kSecAttrPRF - the algorithm to use for the pseudo-random-function.
  ##    If 0, this defaults to kSecAttrPRFHmacAlgSHA1. Possible values are:
  ##
  ##  kSecAttrPRFHmacAlgSHA1
  ##  kSecAttrPRFHmacAlgSHA224
  ##  kSecAttrPRFHmacAlgSHA256
  ##  kSecAttrPRFHmacAlgSHA384
  ##  kSecAttrPRFHmacAlgSHA512
  ##
  ##  kSecAttrRounds - the number of rounds to call the pseudo random function.
  ##    If 0, a count will be computed to average 1/10 of a second.
  ##  kSecAttrKeySizeInBits with a value being a CFNumberRef
  ##    containing the requested key size in bits.  Example sizes for RSA keys are:
  ##    512, 768, 1024, 2048.
  ##
  ##  @result On success a SecKeyRef is returned.  On failure this result is NULL and the
  ##  error parameter contains the reason.
  ##
  ##
  proc SecKeyDeriveFromPassword*(password: CFStringRef;
                                parameters: CFDictionaryRef; error: ptr CFErrorRef): SecKeyRef
  ## !
  ##  @function SecKeyWrapSymmetric
  ##  @abstract Wraps a symmetric key with a symmetric key.
  ##
  ##  @param keyToWrap The key which is to be wrapped.
  ##  @param wrappingKey The key wrapping key.
  ##  @param parameters The parameter list to use for wrapping the key.
  ##  @param error If the call fails this will contain the error code.
  ##
  ##  @result On success a CFDataRef is returned.  On failure this result is NULL and the
  ##  error parameter contains the reason.
  ##
  ##  @discussion In order to wrap a key the parameters dictionary may contain the following key:
  ##  kSecSalt - a CFData for the salt value for the encrypt.
  ##
  ##
  proc SecKeyWrapSymmetric*(keyToWrap: SecKeyRef; wrappingKey: SecKeyRef;
                           parameters: CFDictionaryRef; error: ptr CFErrorRef): CFDataRef
  ## !
  ##  @function SecKeyUnwrapSymmetric
  ##  @abstract Unwrap a wrapped symmetric key.
  ##
  ##  @param keyToUnwrap The wrapped key to unwrap.
  ##  @param unwrappingKey The key unwrapping key.
  ##  @param parameters The parameter list to use for unwrapping the key.
  ##  @param error If the call fails this will contain the error code.
  ##
  ##  @result On success a SecKeyRef is returned.  On failure this result is NULL and the
  ##  error parameter contains the reason.
  ##
  ##  @discussion In order to unwrap a key the parameters dictionary may contain the following key:
  ##  kSecSalt - a CFData for the salt value for the decrypt.
  ##
  ##
  proc SecKeyUnwrapSymmetric*(keyToUnwrap: ptr CFDataRef; unwrappingKey: SecKeyRef;
                             parameters: CFDictionaryRef; error: ptr CFErrorRef): SecKeyRef
## !
##     @function SecKeyGeneratePair
##     @abstract Generate a private/public keypair.
##     @param parameters A dictionary containing one or more key-value pairs.
##     See the discussion sections below for a complete overview of options.
##     @param publicKey On return, a SecKeyRef reference to the public key.
##     @param privateKey On return, a SecKeyRef reference to the private key.
##     @result A result code. See "Security Error Codes" (SecBase.h).
##
##     @discussion In order to generate a keypair the parameters dictionary must
##                 at least contain the following keys:
##
##  kSecAttrKeyType with a value of kSecAttrKeyTypeRSA or any other
##         kSecAttrKeyType defined in SecItem.h
##  kSecAttrKeySizeInBits with a value being a CFNumberRef containing
##         the requested key size in bits.  Example sizes for RSA keys are:
##         512, 768, 1024, 2048.
##
##     The values below may be set either in the top-level dictionary or in a
##     dictionary that is the value of the kSecPrivateKeyAttrs or
##     kSecPublicKeyAttrs key in the top-level dictionary.  Setting these
##     attributes explicitly will override the defaults below.  See SecItem.h
##     for detailed information on these attributes including the types of
##     the values.
##
##  kSecAttrLabel default NULL
##  kSecUseKeychain default NULL, which specifies the default keychain
##  kSecAttrIsPermanent default false
##         if this key is present and has a Boolean value of true, the key or
##         key pair will be added to the keychain.
##  kSecAttrTokenID default NULL
##         The CFStringRef ID of the token to generate the key or keypair on. This
##         attribute can contain CFStringRef and can be present only in the top-level
##         parameters dictionary.
##  kSecAttrApplicationTag default NULL
##  kSecAttrEffectiveKeySize default NULL same as kSecAttrKeySizeInBits
##  kSecAttrCanEncrypt default false for private keys, true for public keys
##  kSecAttrCanDecrypt default true for private keys, false for public keys
##  kSecAttrCanDerive default true
##  kSecAttrCanSign default true for private keys, false for public keys
##  kSecAttrCanVerify default false for private keys, true for public keys
##  kSecAttrCanWrap default false for private keys, true for public keys
##  kSecAttrCanUnwrap default true for private keys, false for public keys
##
##     NOTE: The function always saves keys in the keychain on macOS and as such attribute
##     kSecAttrIsPermanent is ignored. The function respects attribute kSecAttrIsPermanent
##     on iOS, tvOS and watchOS.
##     It is recommended to use SecKeyCreateRandomKey() which respects kSecAttrIsPermanent
##     on all platforms.
##

proc SecKeyGeneratePair*(parameters: CFDictionaryRef; publicKey: ptr SecKeyRef;
                        privateKey: ptr SecKeyRef): OSStatus
when SEC_OS_IPHONE:
  ## !
  ##  @function SecKeyRawSign
  ##  @abstract Given a private key and data to sign, generate a digital
  ##  signature.
  ##  @param key Private key with which to sign.
  ##  @param padding See Padding Types above, typically kSecPaddingPKCS1SHA1.
  ##  @param dataToSign The data to be signed, typically the digest of the
  ##  actual data.
  ##  @param dataToSignLen Length of dataToSign in bytes.
  ##  @param sig Pointer to buffer in which the signature will be returned.
  ##  @param sigLen IN/OUT maximum length of sig buffer on input, actualy
  ##  length of sig on output.
  ##  @result A result code. See "Security Error Codes" (SecBase.h).
  ##  @discussion If the padding argument is kSecPaddingPKCS1, PKCS1 padding
  ##  will be performed prior to signing. If this argument is kSecPaddingNone,
  ##  the incoming data will be signed "as is".
  ##
  ##  When PKCS1 padding is performed, the maximum length of data that can
  ##  be signed is the value returned by SecKeyGetBlockSize() - 11.
  ##
  ##  NOTE: The behavior this function with kSecPaddingNone is undefined if the
  ##  first byte of dataToSign is zero; there is no way to verify leading zeroes
  ##  as they are discarded during the calculation.
  ##
  ##  If you want to generate a proper PKCS1 style signature with DER encoding
  ##  of the digest type - and the dataToSign is a SHA1 digest - use
  ##  kSecPaddingPKCS1SHA1.
  ##
  proc SecKeyRawSign*(key: SecKeyRef; padding: SecPadding; dataToSign: ptr uint8_t;
                     dataToSignLen: csize; sig: ptr uint8_t; sigLen: ptr csize): OSStatus
  ## !
  ##  @function SecKeyRawVerify
  ##  @abstract Given a public key, data which has been signed, and a signature,
  ##  verify the signature.
  ##  @param key Public key with which to verify the signature.
  ##  @param padding See Padding Types above, typically kSecPaddingPKCS1SHA1.
  ##  @param signedData The data over which sig is being verified, typically
  ##  the digest of the actual data.
  ##  @param signedDataLen Length of signedData in bytes.
  ##  @param sig Pointer to the signature to verify.
  ##  @param sigLen Length of sig in  bytes.
  ##  @result A result code. See "Security Error Codes" (SecBase.h).
  ##  @discussion If the padding argument is kSecPaddingPKCS1, PKCS1 padding
  ##  will be checked during verification. If this argument is kSecPaddingNone,
  ##  the incoming data will be compared directly to sig.
  ##
  ##  If you are verifying a proper PKCS1-style signature, with DER encoding
  ##  of the digest type - and the signedData is a SHA1 digest - use
  ##  kSecPaddingPKCS1SHA1.
  ##
  proc SecKeyRawVerify*(key: SecKeyRef; padding: SecPadding; signedData: ptr uint8_t;
                       signedDataLen: csize; sig: ptr uint8_t; sigLen: csize): OSStatus
  ## !
  ##  @function SecKeyEncrypt
  ##  @abstract Encrypt a block of plaintext.
  ##  @param key Public key with which to encrypt the data.
  ##  @param padding See Padding Types above, typically kSecPaddingPKCS1.
  ##  @param plainText The data to encrypt.
  ##  @param plainTextLen Length of plainText in bytes, this must be less
  ##  or equal to the value returned by SecKeyGetBlockSize().
  ##  @param cipherText Pointer to the output buffer.
  ##  @param cipherTextLen On input, specifies how much space is available at
  ##  cipherText; on return, it is the actual number of cipherText bytes written.
  ##  @result A result code. See "Security Error Codes" (SecBase.h).
  ##  @discussion If the padding argument is kSecPaddingPKCS1 or kSecPaddingOAEP,
  ##  PKCS1 (respectively kSecPaddingOAEP) padding will be performed prior to encryption.
  ##  If this argument is kSecPaddingNone, the incoming data will be encrypted "as is".
  ##  kSecPaddingOAEP is the recommended value. Other value are not recommended
  ##  for security reason (Padding attack or malleability).
  ##
  ##  When PKCS1 padding is performed, the maximum length of data that can
  ##  be encrypted is the value returned by SecKeyGetBlockSize() - 11.
  ##
  ##  When memory usage is a critical issue, note that the input buffer
  ##  (plainText) can be the same as the output buffer (cipherText).
  ##
  proc SecKeyEncrypt*(key: SecKeyRef; padding: SecPadding; plainText: ptr uint8_t;
                     plainTextLen: csize; cipherText: ptr uint8_t;
                     cipherTextLen: ptr csize): OSStatus
  ## !
  ##  @function SecKeyDecrypt
  ##  @abstract Decrypt a block of ciphertext.
  ##  @param key Private key with which to decrypt the data.
  ##  @param padding See Padding Types above, typically kSecPaddingPKCS1.
  ##  @param cipherText The data to decrypt.
  ##  @param cipherTextLen Length of cipherText in bytes, this must be less
  ##  or equal to the value returned by SecKeyGetBlockSize().
  ##  @param plainText Pointer to the output buffer.
  ##  @param plainTextLen On input, specifies how much space is available at
  ##  plainText; on return, it is the actual number of plainText bytes written.
  ##  @result A result code. See "Security Error Codes" (SecBase.h).
  ##  @discussion If the padding argument is kSecPaddingPKCS1 or kSecPaddingOAEP,
  ##  the corresponding padding will be removed after decryption.
  ##  If this argument is kSecPaddingNone, the decrypted data will be returned "as is".
  ##
  ##  When memory usage is a critical issue, note that the input buffer
  ##  (plainText) can be the same as the output buffer (cipherText).
  ##
  proc SecKeyDecrypt*(key: SecKeyRef; padding: SecPadding; cipherText: ptr uint8_t;
                     cipherTextLen: csize; plainText: ptr uint8_t;
                     plainTextLen: ptr csize): OSStatus
    ##  Private key
    ##  kSecPaddingNone,
    ##                                                              kSecPaddingPKCS1,
    ##                                                              kSecPaddingOAEP
    ##  length of cipherText
    ##  IN/OUT
## !
##  @function SecKeyCreateRandomKey
##  @abstract Generates a new public/private key pair.
##  @param parameters A dictionary containing one or more key-value pairs.
##     See the discussion sections below for a complete overview of options.
##  @param error On error, will be populated with an error object describing the failure.
##  See "Security Error Codes" (SecBase.h).
##  @return Newly generated private key.  To get associated public key, use SecKeyCopyPublicKey().
##  @discussion In order to generate a keypair the parameters dictionary must
##     at least contain the following keys:
##
##  kSecAttrKeyType with a value being kSecAttrKeyTypeRSA or any other
##  kSecAttrKeyType defined in SecItem.h
##  kSecAttrKeySizeInBits with a value being a CFNumberRef or CFStringRef
##  containing the requested key size in bits.  Example sizes for RSA
##  keys are: 512, 768, 1024, 2048.
##
##  The values below may be set either in the top-level dictionary or in a
##  dictionary that is the value of the kSecPrivateKeyAttrs or
##  kSecPublicKeyAttrs key in the top-level dictionary.  Setting these
##  attributes explicitly will override the defaults below.  See SecItem.h
##  for detailed information on these attributes including the types of
##  the values.
##
##  kSecAttrLabel default NULL
##  kSecAttrIsPermanent if this key is present and has a Boolean value of true,
##    the key or key pair will be added to the default keychain.
##  kSecAttrTokenID if this key should be generated on specified token.  This
##    attribute can contain CFStringRef and can be present only in the top-level
##    parameters dictionary.
##  kSecAttrApplicationTag default NULL
##  kSecAttrEffectiveKeySize default NULL same as kSecAttrKeySizeInBits
##  kSecAttrCanEncrypt default false for private keys, true for public keys
##  kSecAttrCanDecrypt default true for private keys, false for public keys
##  kSecAttrCanDerive default true
##  kSecAttrCanSign default true for private keys, false for public keys
##  kSecAttrCanVerify default false for private keys, true for public keys
##  kSecAttrCanWrap default false for private keys, true for public keys
##  kSecAttrCanUnwrap default true for private keys, false for public keys
##

proc SecKeyCreateRandomKey*(parameters: CFDictionaryRef; error: ptr CFErrorRef): SecKeyRef
## !
##     @function SecKeyCreateWithData
##     @abstract Create a SecKey from a well-defined external representation.
##     @param keyData CFData representing the key. The format of the data depends on the type of key being created.
##     @param attributes Dictionary containing attributes describing the key to be imported. The keys in this dictionary
##     are kSecAttr* constants from SecItem.h.  Mandatory attributes are:
##  kSecAttrKeyType
##  kSecAttrKeyClass
##     @param error On error, will be populated with an error object describing the failure.
##     See "Security Error Codes" (SecBase.h).
##     @result A SecKey object representing the key, or NULL on failure.
##     @discussion This function does not add keys to any keychain, but the SecKey object it returns can be added
##     to keychain using the SecItemAdd function.
##     The requested data format depend on the type of key (kSecAttrKeyType) being created:
##  kSecAttrKeyTypeRSA               PKCS#1 format, public key can be also in x509 public key format
##  kSecAttrKeyTypeECSECPrimeRandom  ANSI X9.63 format (04 || X || Y [ || K])
##

proc SecKeyCreateWithData*(keyData: CFDataRef; attributes: CFDictionaryRef;
                          error: ptr CFErrorRef): SecKeyRef
## !
##     @function SecKeyGetBlockSize
##     @abstract Returns block length of the key in bytes.
##     @param key The key for which the block length is requested.
##     @result The block length of the key in bytes.
##     @discussion If for example key is an RSA key the value returned by
##     this function is the size of the modulus.
##

proc SecKeyGetBlockSize*(key: SecKeyRef): csize
## !
##     @function SecKeyCopyExternalRepresentation
##     @abstract Create an external representation for the given key suitable for the key's type.
##     @param key The key to be exported.
##     @param error On error, will be populated with an error object describing the failure.
##     See "Security Error Codes" (SecBase.h).
##     @result A CFData representing the key in a format suitable for that key type.
##     @discussion This function may fail if the key is not exportable (e.g., bound to a smart card or Secure Enclave).
##     The format in which the key will be exported depends on the type of key:
##  kSecAttrKeyTypeRSA               PKCS#1 format
##  kSecAttrKeyTypeECSECPrimeRandom  ANSI X9.63 format (04 || X || Y [ || K])
##

proc SecKeyCopyExternalRepresentation*(key: SecKeyRef; error: ptr CFErrorRef): CFDataRef
## !
##     @function SecKeyCopyAttributes
##     @abstract Retrieve keychain attributes of a key.
##     @param key The key whose attributes are to be retrieved.
##     @result Dictionary containing attributes of the key. The keys that populate this dictionary are defined
##     and discussed in SecItem.h.
##     @discussion The attributes provided by this function are:
##  kSecAttrCanEncrypt
##  kSecAttrCanDecrypt
##  kSecAttrCanDerive
##  kSecAttrCanSign
##  kSecAttrCanVerify
##  kSecAttrKeyClass
##  kSecAttrKeyType
##  kSecAttrKeySizeInBits
##  kSecAttrTokenID
##  kSecAttrApplicationLabel
##     Other values returned in that dictionary are RFU.
##

proc SecKeyCopyAttributes*(key: SecKeyRef): CFDictionaryRef
## !
##     @function SecKeyCopyPublicKey
##     @abstract Retrieve the public key from a key pair or private key.
##     @param key The key from which to retrieve a public key.
##     @result The public key or NULL if public key is not available for specified key.
##     @discussion Fails if key does not contain a public key or no public key can be computed from it.
##

proc SecKeyCopyPublicKey*(key: SecKeyRef): SecKeyRef
## !
##     @enum SecKeyAlgorithm
##     @abstract Available algorithms for performing cryptographic operations with SecKey object.  String representation
##     of constant can be used for logging or debugging purposes, because they contain human readable names of the algorithm.
##
##     @constant kSecKeyAlgorithmRSASignatureRaw
##     Raw RSA sign/verify operation, size of input data must be the same as value returned by SecKeyGetBlockSize().
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPKCS1v15Raw
##     RSA sign/verify operation, assumes that input data is digest and OID and digest algorithm as specified in PKCS# v1.5.
##     This algorithm is typically not used directly, instead use algorithm with specified digest, like
##     kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA256.
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA1
##     RSA signature with PKCS#1 padding, input data must be SHA-1 generated digest.
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA224
##     RSA signature with PKCS#1 padding, input data must be SHA-224 generated digest.
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA256
##     RSA signature with PKCS#1 padding, input data must be SHA-256 generated digest.
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA384
##     RSA signature with PKCS#1 padding, input data must be SHA-384 generated digest.
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA512
##     RSA signature with PKCS#1 padding, input data must be SHA-512 generated digest.
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA1
##     RSA signature with PKCS#1 padding, SHA-1 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA224
##     RSA signature with PKCS#1 padding, SHA-224 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA256
##     RSA signature with PKCS#1 padding, SHA-256 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA384
##     RSA signature with PKCS#1 padding, SHA-384 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA512
##     RSA signature with PKCS#1 padding, SHA-512 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPSSSHA1
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, input data must be SHA-1 generated digest.
##     PSS padding is calculated using MGF1 with SHA1 and saltLength parameter is set to 20 (SHA-1 output size).
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPSSSHA224
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, input data must be SHA-224 generated digest.
##     PSS padding is calculated using MGF1 with SHA224 and saltLength parameter is set to 28 (SHA-224 output size).
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPSSSHA256
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, input data must be SHA-256 generated digest.
##     PSS padding is calculated using MGF1 with SHA256 and saltLength parameter is set to 32 (SHA-256 output size).
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPSSSHA384
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, input data must be SHA-384 generated digest.
##     PSS padding is calculated using MGF1 with SHA384 and saltLength parameter is set to 48 (SHA-384 output size).
##
##     @constant kSecKeyAlgorithmRSASignatureDigestPSSSHA512
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, input data must be SHA-512 generated digest.
##     PSS padding is calculated using MGF1 with SHA512 and saltLength parameter is set to 64 (SHA-512 output size).
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePSSSHA1
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, SHA-1 digest is generated from input data of any size.
##     PSS padding is calculated using MGF1 with SHA1 and saltLength parameter is set to 20 (SHA-1 output size).
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePSSSHA224
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, SHA-224 digest is generated from input data of any size.
##     PSS padding is calculated using MGF1 with SHA224 and saltLength parameter is set to 28 (SHA-224 output size).
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePSSSHA256
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, SHA-256 digest is generated from input data of any size.
##     PSS padding is calculated using MGF1 with SHA256 and saltLength parameter is set to 32 (SHA-256 output size).
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePSSSHA384
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, SHA-384 digest is generated from input data of any size.
##     PSS padding is calculated using MGF1 with SHA384 and saltLength parameter is set to 48 (SHA-384 output size).
##
##     @constant kSecKeyAlgorithmRSASignatureMessagePSSSHA512
##     RSA signature with RSASSA-PSS padding according to PKCS#1 v2.1, SHA-512 digest is generated from input data of any size.
##     PSS padding is calculated using MGF1 with SHA512 and saltLength parameter is set to 64 (SHA-512 output size).
##
##     @constant kSecKeyAlgorithmECDSASignatureRFC4754
##     ECDSA algorithm, signature is concatenated r and s, big endian, data is message digest.
##
##     @constant kSecKeyAlgorithmECDSASignatureDigestX962
##     ECDSA algorithm, signature is in DER x9.62 encoding, input data is message digest.
##
##     @constant kSecKeyAlgorithmECDSASignatureDigestX962SHA1
##     ECDSA algorithm, signature is in DER x9.62 encoding, input data is message digest created by SHA1 algorithm.
##
##     @constant kSecKeyAlgorithmECDSASignatureDigestX962SHA1
##     ECDSA algorithm, signature is in DER x9.62 encoding, input data is message digest created by SHA224 algorithm.
##
##     @constant kSecKeyAlgorithmECDSASignatureDigestX962SHA1
##     ECDSA algorithm, signature is in DER x9.62 encoding, input data is message digest created by SHA256 algorithm.
##
##     @constant kSecKeyAlgorithmECDSASignatureDigestX962SHA1
##     ECDSA algorithm, signature is in DER x9.62 encoding, input data is message digest created by SHA384 algorithm.
##
##     @constant kSecKeyAlgorithmECDSASignatureDigestX962SHA1
##     ECDSA algorithm, signature is in DER x9.62 encoding, input data is message digest created by SHA512 algorithm.
##
##     @constant kSecKeyAlgorithmECDSASignatureMessageX962SHA1
##     ECDSA algorithm, signature is in DER x9.62 encoding, SHA-1 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmECDSASignatureMessageX962SHA224
##     ECDSA algorithm, signature is in DER x9.62 encoding, SHA-224 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmECDSASignatureMessageX962SHA256
##     ECDSA algorithm, signature is in DER x9.62 encoding, SHA-256 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmECDSASignatureMessageX962SHA384
##     ECDSA algorithm, signature is in DER x9.62 encoding, SHA-384 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmECDSASignatureMessageX962SHA512
##     ECDSA algorithm, signature is in DER x9.62 encoding, SHA-512 digest is generated from input data of any size.
##
##     @constant kSecKeyAlgorithmRSAEncryptionRaw
##     Raw RSA encryption or decryption, size of data must match RSA key modulus size.  Note that direct
##     use of this algorithm without padding is cryptographically very weak, it is important to always introduce
##     some kind of padding.  Input data size must be less or equal to the key block size and returned block has always
##     the same size as block size, as returned by SecKeyGetBlockSize().
##
##     @constant kSecKeyAlgorithmRSAEncryptionPKCS1
##     RSA encryption or decryption, data is padded using PKCS#1 padding scheme.  This algorithm should be used only for
##     backward compatibility with existing protocols and data. New implementations should choose cryptographically
##     stronger algorithm instead (see kSecKeyAlgorithmRSAEncryptionOAEP).  Input data must be at most
##     "key block size - 11" bytes long and returned block has always the same size as block size, as returned
##     by SecKeyGetBlockSize().
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA1
##     RSA encryption or decryption, data is padded using OAEP padding scheme internally using SHA1. Input data must be at most
##     "key block size - 42" bytes long and returned block has always the same size as block size, as returned
##     by SecKeyGetBlockSize().  Use kSecKeyAlgorithmRSAEncryptionOAEPSHA1AESGCM to be able to encrypt and decrypt arbitrary long data.
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA224
##     RSA encryption or decryption, data is padded using OAEP padding scheme internally using SHA224. Input data must be at most
##     "key block size - 58" bytes long and returned block has always the same size as block size, as returned
##     by SecKeyGetBlockSize().  Use kSecKeyAlgorithmRSAEncryptionOAEPSHA224AESGCM to be able to encrypt and decrypt arbitrary long data.
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA256
##     RSA encryption or decryption, data is padded using OAEP padding scheme internally using SHA256. Input data must be at most
##     "key block size - 66" bytes long and returned block has always the same size as block size, as returned
##     by SecKeyGetBlockSize().  Use kSecKeyAlgorithmRSAEncryptionOAEPSHA256AESGCM to be able to encrypt and decrypt arbitrary long data.
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA384
##     RSA encryption or decryption, data is padded using OAEP padding scheme internally using SHA384. Input data must be at most
##     "key block size - 98" bytes long and returned block has always the same size as block size, as returned
##     by SecKeyGetBlockSize().  Use kSecKeyAlgorithmRSAEncryptionOAEPSHA384AESGCM to be able to encrypt and decrypt arbitrary long data.
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA512
##     RSA encryption or decryption, data is padded using OAEP padding scheme internally using SHA512. Input data must be at most
##     "key block size - 130" bytes long and returned block has always the same size as block size, as returned
##     by SecKeyGetBlockSize().  Use kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM to be able to encrypt and decrypt arbitrary long data.
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA1AESGCM
##     Randomly generated AES session key is encrypted by RSA with OAEP padding.  User data are encrypted using session key in GCM
##     mode with all-zero 16 bytes long IV (initialization vector).  Finally 16 byte AES-GCM tag is appended to ciphertext.
##     256bit AES key is used if RSA key is 4096bit or bigger, otherwise 128bit AES key is used.  Raw public key data is used
##     as authentication data for AES-GCM encryption.
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA224AESGCM
##     Randomly generated AES session key is encrypted by RSA with OAEP padding.  User data are encrypted using session key in GCM
##     mode with all-zero 16 bytes long IV (initialization vector).  Finally 16 byte AES-GCM tag is appended to ciphertext.
##     256bit AES key is used if RSA key is 4096bit or bigger, otherwise 128bit AES key is used.  Raw public key data is used
##     as authentication data for AES-GCM encryption.
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA256AESGCM
##     Randomly generated AES session key is encrypted by RSA with OAEP padding.  User data are encrypted using session key in GCM
##     mode with all-zero 16 bytes long IV (initialization vector).  Finally 16 byte AES-GCM tag is appended to ciphertext.
##     256bit AES key is used if RSA key is 4096bit or bigger, otherwise 128bit AES key is used.  Raw public key data is used
##     as authentication data for AES-GCM encryption.
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA384AESGCM
##     Randomly generated AES session key is encrypted by RSA with OAEP padding.  User data are encrypted using session key in GCM
##     mode with all-zero 16 bytes long IV (initialization vector).  Finally 16 byte AES-GCM tag is appended to ciphertext.
##     256bit AES key is used if RSA key is 4096bit or bigger, otherwise 128bit AES key is used.  Raw public key data is used
##     as authentication data for AES-GCM encryption.
##
##     @constant kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM
##     Randomly generated AES session key is encrypted by RSA with OAEP padding.  User data are encrypted using session key in GCM
##     mode with all-zero 16 bytes long IV (initialization vector).  Finally 16 byte AES-GCM tag is appended to ciphertext.
##     256bit AES key is used if RSA key is 4096bit or bigger, otherwise 128bit AES key is used.  Raw public key data is used
##     as authentication data for AES-GCM encryption.
##
##     @constant kSecKeyAlgorithmECIESEncryptionStandardX963SHA1AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA256AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA1.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionStandardX963SHA224AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA224AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA224.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionStandardX963SHA256AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA256AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA256.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionStandardX963SHA384AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA384AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA384.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionStandardX963SHA512AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA512AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA512.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionCofactorX963SHA1AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA256AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA1.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionCofactorX963SHA224AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA224AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA224.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionCofactorX963SHA256AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA256AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA256.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionCofactorX963SHA384AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA384AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA384.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionCofactorX963SHA512AESGCM
##     Legacy ECIES encryption or decryption, use kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA512AESGCM in new code.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA512.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG and all-zero 16 byte long IV (initialization vector).
##
##     @constant kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA224AESGCM
##     ECIES encryption or decryption.  This algorithm does not limit the size of the message to be encrypted or decrypted.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA224.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG, AES key is first half of KDF output and 16 byte long IV (initialization vector) is second half
##     of KDF output.
##
##     @constant kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA256AESGCM
##     ECIES encryption or decryption.  This algorithm does not limit the size of the message to be encrypted or decrypted.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA256.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG, AES key is first half of KDF output and 16 byte long IV (initialization vector) is second half
##     of KDF output.
##
##     @constant kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA384AESGCM
##     ECIES encryption or decryption.  This algorithm does not limit the size of the message to be encrypted or decrypted.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA384.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG, AES key is first half of KDF output and 16 byte long IV (initialization vector) is second half
##     of KDF output.
##
##     @constant kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA512AESGCM
##     ECIES encryption or decryption.  This algorithm does not limit the size of the message to be encrypted or decrypted.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA512.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG, AES key is first half of KDF output and 16 byte long IV (initialization vector) is second half
##     of KDF output.
##
##     @constant kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA224AESGCM
##     ECIES encryption or decryption.  This algorithm does not limit the size of the message to be encrypted or decrypted.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA224.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG, AES key is first half of KDF output and 16 byte long IV (initialization vector) is second half
##     of KDF output.
##
##     @constant kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA256AESGCM
##     ECIES encryption or decryption.  This algorithm does not limit the size of the message to be encrypted or decrypted.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA256.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG, AES key is first half of KDF output and 16 byte long IV (initialization vector) is second half
##     of KDF output.
##
##     @constant kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA384AESGCM
##     ECIES encryption or decryption.  This algorithm does not limit the size of the message to be encrypted or decrypted.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA384.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG, AES key is first half of KDF output and 16 byte long IV (initialization vector) is second half
##     of KDF output.
##
##     @constant kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA512AESGCM
##     ECIES encryption or decryption.  This algorithm does not limit the size of the message to be encrypted or decrypted.
##     Encryption is done using AES-GCM with key negotiated by kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA512.  AES Key size
##     is 128bit for EC keys <=256bit and 256bit for bigger EC keys. Ephemeral public key data is used as sharedInfo for KDF.
##     AES-GCM uses 16 bytes long TAG, AES key is first half of KDF output and 16 byte long IV (initialization vector) is second half
##     of KDF output.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeCofactor
##     Compute shared secret using ECDH cofactor algorithm, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys.
##     This algorithm does not accept any parameters, length of output raw shared secret is given by the length of the key.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA1
##     Compute shared secret using ECDH cofactor algorithm, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA1 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA224
##     Compute shared secret using ECDH cofactor algorithm, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA224 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA256
##     Compute shared secret using ECDH cofactor algorithm, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA256 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA384
##     Compute shared secret using ECDH cofactor algorithm, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA384 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA512
##     Compute shared secret using ECDH cofactor algorithm, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA512 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeStandard
##     Compute shared secret using ECDH algorithm without cofactor, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys.
##     This algorithm does not accept any parameters, length of output raw shared secret is given by the length of the key.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA1
##     Compute shared secret using ECDH algorithm without cofactor, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA1 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA224
##     Compute shared secret using ECDH algorithm without cofactor, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA224 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA256
##     Compute shared secret using ECDH algorithm without cofactor, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA256 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA384
##     Compute shared secret using ECDH algorithm without cofactor, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA384 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##
##     @constant kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA512
##     Compute shared secret using ECDH algorithm without cofactor, suitable only for kSecAttrKeyTypeECSECPrimeRandom keys
##     and apply ANSI X9.63 KDF with SHA512 as hashing function.  Requires kSecKeyKeyExchangeParameterRequestedSize and allows
##     kSecKeyKeyExchangeParameterSharedInfo parameters to be used.
##

type
  SecKeyAlgorithm* = CFStringRef

var kSecKeyAlgorithmRSASignatureRaw*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPKCS1v15Raw*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA1*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA224*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA256*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA384*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPKCS1v15SHA512*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA1*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA224*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA256*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA384*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePKCS1v15SHA512*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPSSSHA1*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPSSSHA224*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPSSSHA256*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPSSSHA384*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureDigestPSSSHA512*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePSSSHA1*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePSSSHA224*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePSSSHA256*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePSSSHA384*: SecKeyAlgorithm

var kSecKeyAlgorithmRSASignatureMessagePSSSHA512*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureRFC4754*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureDigestX962*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureDigestX962SHA1*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureDigestX962SHA224*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureDigestX962SHA256*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureDigestX962SHA384*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureDigestX962SHA512*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureMessageX962SHA1*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureMessageX962SHA224*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureMessageX962SHA256*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureMessageX962SHA384*: SecKeyAlgorithm

var kSecKeyAlgorithmECDSASignatureMessageX962SHA512*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionRaw*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionPKCS1*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA1*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA224*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA256*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA384*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA512*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA1AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA224AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA256AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA384AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionStandardX963SHA1AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionStandardX963SHA224AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionStandardX963SHA256AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionStandardX963SHA384AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionStandardX963SHA512AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionCofactorX963SHA1AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionCofactorX963SHA224AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionCofactorX963SHA256AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionCofactorX963SHA384AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionCofactorX963SHA512AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA224AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA256AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA384AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionStandardVariableIVX963SHA512AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA224AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA256AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA384AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECIESEncryptionCofactorVariableIVX963SHA512AESGCM*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeStandard*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA1*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA224*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA256*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA384*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeStandardX963SHA512*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeCofactor*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA1*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA224*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA256*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA384*: SecKeyAlgorithm

var kSecKeyAlgorithmECDHKeyExchangeCofactorX963SHA512*: SecKeyAlgorithm

## !
##     @function SecKeyCreateSignature
##     @abstract Given a private key and data to sign, generate a digital signature.
##     @param key Private key with which to sign.
##     @param algorithm One of SecKeyAlgorithm constants suitable to generate signature with this key.
##     @param dataToSign The data to be signed, typically the digest of the actual data.
##     @param error On error, will be populated with an error object describing the failure.
##     See "Security Error Codes" (SecBase.h).
##     @result The signature over dataToSign represented as a CFData, or NULL on failure.
##     @discussion Computes digital signature using specified key over input data.  The operation algorithm
##     further defines the exact format of input data, operation to be performed and output signature.
##

proc SecKeyCreateSignature*(key: SecKeyRef; algorithm: SecKeyAlgorithm;
                           dataToSign: CFDataRef; error: ptr CFErrorRef): CFDataRef
## !
##     @function SecKeyVerifySignature
##     @abstract Given a public key, data which has been signed, and a signature, verify the signature.
##     @param key Public key with which to verify the signature.
##     @param algorithm One of SecKeyAlgorithm constants suitable to verify signature with this key.
##     @param signedData The data over which sig is being verified, typically the digest of the actual data.
##     @param signature The signature to verify.
##     @param error On error, will be populated with an error object describing the failure.
##     See "Security Error Codes" (SecBase.h).
##     @result True if the signature was valid, False otherwise.
##     @discussion Verifies digital signature operation using specified key and signed data.  The operation algorithm
##     further defines the exact format of input data, signature and operation to be performed.
##

proc SecKeyVerifySignature*(key: SecKeyRef; algorithm: SecKeyAlgorithm;
                           signedData: CFDataRef; signature: CFDataRef;
                           error: ptr CFErrorRef): Boolean
## !
##     @function SecKeyCreateEncryptedData
##     @abstract Encrypt a block of plaintext.
##     @param key Public key with which to encrypt the data.
##     @param algorithm One of SecKeyAlgorithm constants suitable to perform encryption with this key.
##     @param plaintext The data to encrypt. The length and format of the data must conform to chosen algorithm,
##     typically be less or equal to the value returned by SecKeyGetBlockSize().
##     @param error On error, will be populated with an error object describing the failure.
##     See "Security Error Codes" (SecBase.h).
##     @result The ciphertext represented as a CFData, or NULL on failure.
##     @discussion Encrypts plaintext data using specified key.  The exact type of the operation including the format
##     of input and output data is specified by encryption algorithm.
##

proc SecKeyCreateEncryptedData*(key: SecKeyRef; algorithm: SecKeyAlgorithm;
                               plaintext: CFDataRef; error: ptr CFErrorRef): CFDataRef
## !
##     @function SecKeyCreateDecryptedData
##     @abstract Decrypt a block of ciphertext.
##     @param key Private key with which to decrypt the data.
##     @param algorithm One of SecKeyAlgorithm constants suitable to perform decryption with this key.
##     @param ciphertext The data to decrypt. The length and format of the data must conform to chosen algorithm,
##     typically be less or equal to the value returned by SecKeyGetBlockSize().
##     @param error On error, will be populated with an error object describing the failure.
##     See "Security Error Codes" (SecBase.h).
##     @result The plaintext represented as a CFData, or NULL on failure.
##     @discussion Decrypts ciphertext data using specified key.  The exact type of the operation including the format
##     of input and output data is specified by decryption algorithm.
##

proc SecKeyCreateDecryptedData*(key: SecKeyRef; algorithm: SecKeyAlgorithm;
                               ciphertext: CFDataRef; error: ptr CFErrorRef): CFDataRef
## !
##     @enum SecKeyKeyExchangeParameter SecKey Key Exchange parameters
##     @constant kSecKeyKeyExchangeParameterRequestedSize Contains CFNumberRef with requested result size in bytes.
##     @constant kSecKeyKeyExchangeParameterSharedInfo Contains CFDataRef with additional shared info
##     for KDF (key derivation function).
##

type
  SecKeyKeyExchangeParameter* = CFStringRef

var kSecKeyKeyExchangeParameterRequestedSize*: SecKeyKeyExchangeParameter

var kSecKeyKeyExchangeParameterSharedInfo*: SecKeyKeyExchangeParameter

## !
##     @function SecKeyCopyKeyExchangeResult
##     @abstract Perform Diffie-Hellman style of key exchange operation, optionally with additional key-derivation steps.
##     @param algorithm One of SecKeyAlgorithm constants suitable to perform this operation.
##     @param publicKey Remote party's public key.
##     @param parameters Dictionary with parameters, see SecKeyKeyExchangeParameter constants.  Used algorithm
##     determines the set of required and optional parameters to be used.
##     @param error Pointer to an error object on failure.
##     See "Security Error Codes" (SecBase.h).
##     @result Result of key exchange operation as a CFDataRef, or NULL on failure.
##

proc SecKeyCopyKeyExchangeResult*(privateKey: SecKeyRef;
                                 algorithm: SecKeyAlgorithm; publicKey: SecKeyRef;
                                 parameters: CFDictionaryRef;
                                 error: ptr CFErrorRef): CFDataRef
## !
##     @enum SecKeyOperationType
##     @abstract Defines types of cryptographic operations available with SecKey instance.
##
##     @constant kSecKeyOperationTypeSign
##     Represents SecKeyCreateSignature()
##
##     @constant kSecKeyOperationTypeVerify
##     Represents SecKeyVerifySignature()
##
##     @constant kSecKeyOperationTypeEncrypt
##     Represents SecKeyCreateEncryptedData()
##
##     @constant kSecKeyOperationTypeDecrypt
##     Represents SecKeyCreateDecryptedData()
##
##     @constant kSecKeyOperationTypeKeyExchange
##     Represents SecKeyCopyKeyExchangeResult()
##

type
  SecKeyOperationType* = CFIndex

const
  kSecKeyOperationTypeSign* = 0
  kSecKeyOperationTypeVerify* = 1
  kSecKeyOperationTypeEncrypt* = 2
  kSecKeyOperationTypeDecrypt* = 3
  kSecKeyOperationTypeKeyExchange* = 4

## !
##     @function SecKeyIsAlgorithmSupported
##     @abstract Checks whether key supports specified algorithm for specified operation.
##     @param key Key to query
##     @param operation Operation type for which the key is queried
##     @param algorithm Algorithm which is queried
##     @return True if key supports specified algorithm for specified operation, False otherwise.
##

proc SecKeyIsAlgorithmSupported*(key: SecKeyRef; operation: SecKeyOperationType;
                                algorithm: SecKeyAlgorithm): Boolean