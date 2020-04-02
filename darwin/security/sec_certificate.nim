##
##  Copyright (c) 2002-2017 Apple Inc. All Rights Reserved.
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
##      @header SecCertificate
##     The functions provided in SecCertificate.h implement and manage a
##     particular type of keychain item that represents a X.509 public key
##     certificate. You can store a certificate in a keychain, but a
##     certificate can also be a transient object.
##
##      You can use a certificate as a keychain item in most functions.
##

when SEC_OS_OSX:
  const
    _SECURITY_VERSION_GREATER_THAN_57610_* = true
## !
##  @function SecCertificateGetTypeID
##  @abstract Returns the type identifier of SecCertificate instances.
##  @result The CFTypeID of SecCertificate instances.
##

proc SecCertificateGetTypeID*(): CFTypeID
## !
##  @function SecCertificateCreateWithData
##  @abstract Create a certificate given it's DER representation as a CFData.
##  @param allocator CFAllocator to allocate the certificate with.
##  @param data DER encoded X.509 certificate.
##  @result Return NULL if the passed-in data is not a valid DER-encoded
##  X.509 certificate, return a SecCertificateRef otherwise.
##

proc SecCertificateCreateWithData*(allocator: CFAllocatorRef; data: CFDataRef): SecCertificateRef
## !
##  @function SecCertificateCopyData
##  @abstract Return the DER representation of an X.509 certificate.
##  @param certificate SecCertificate object created with
##  SecCertificateCreateWithData().
##  @result DER encoded X.509 certificate.
##

proc SecCertificateCopyData*(certificate: SecCertificateRef): CFDataRef
## !
##  @function SecCertificateCopySubjectSummary
##  @abstract Return a simple string which hopefully represents a human
##  understandable summary.
##  @param certificate  A reference to the certificate from which to derive
##  the subject summary string.
##  @discussion All the data in this string comes from the certificate itself
##  and thus it's in whatever language the certificate itself is in.
##  @result A CFStringRef which the caller should CFRelease() once it's no
##  longer needed.
##

proc SecCertificateCopySubjectSummary*(certificate: SecCertificateRef): CFStringRef
## !
##  @function SecCertificateCopyCommonName
##  @abstract Retrieves the common name of the subject of a given certificate.
##  @param certificate A reference to the certificate from which to retrieve the common name.
##  @param commonName On return, a reference to the common name. Your code must release this reference by calling the CFRelease function.
##  @result A result code. See "Security Error Codes" (SecBase.h).
##  @discussion All the data in this string comes from the certificate itself, and thus it's in whatever language the certificate itself is in.
##  Note that the certificate's common name field may not be present, or may be inadequate to describe the certificate; for display purposes,
##  you should consider using SecCertificateCopySubjectSummary instead of this function.
##

proc SecCertificateCopyCommonName*(certificate: SecCertificateRef;
                                  commonName: ptr CFStringRef): OSStatus
## !
##  @function SecCertificateCopyEmailAddresses
##  @abstract Returns an array of zero or more email addresses for the subject of a given certificate.
##  @param certificate A reference to the certificate from which to retrieve the email addresses.
##  @param emailAddresses On return, an array of zero or more CFStringRef elements corresponding to each email address found.
##  Your code must release this array reference by calling the CFRelease function.
##  @result A result code. See "Security Error Codes" (SecBase.h).
##

proc SecCertificateCopyEmailAddresses*(certificate: SecCertificateRef;
                                      emailAddresses: ptr CFArrayRef): OSStatus
## !
##  @function SecCertificateCopyNormalizedIssuerSequence
##  @abstract Return the certificate's normalized issuer
##  @param certificate The certificate from which to get values
##  @discussion The issuer is a sequence in the format used by SecItemCopyMatching.  The content returned is a DER-encoded X.509 distinguished name. For a display version of the issuer, call SecCertificateCopyValues. The caller must CFRelease the value returned.
##

proc SecCertificateCopyNormalizedIssuerSequence*(certificate: SecCertificateRef): CFDataRef
## !
##  @function SecCertificateCopyNormalizedSubjectSequence
##  @abstract Return the certificate's normalized subject
##  @param certificate The certificate from which to get values
##  @discussion The subject is a sequence in the format used by SecItemCopyMatching. The content returned is a DER-encoded X.509 distinguished name. For a display version of the subject, call SecCertificateCopyValues. The caller must CFRelease the value returned.
##

proc SecCertificateCopyNormalizedSubjectSequence*(certificate: SecCertificateRef): CFDataRef
## !
##  @function SecCertificateCopyKey
##  @abstract Retrieves the public key for a given certificate.
##  @param certificate A reference to the certificate from which to retrieve the public key.
##  @result A reference to the public key for the specified certificate. Your code must release this reference by calling the CFRelease function. If the public key has an encoding issue or uses an unsupported algorithm, the returned reference will be null.
##  @discussion RSA and ECDSA public keys are supported. All other public key algorithms are unsupported.
##

proc SecCertificateCopyKey*(certificate: SecCertificateRef): SecKeyRef
when TARGET_OS_IPHONE:
  ## !
  ##  @function SecCertificateCopyPublicKey
  ##  @abstract Retrieves the public key for a given certificate.
  ##  @param certificate A reference to the certificate from which to retrieve the public key.
  ##  @result A reference to the public key for the specified certificate. Your code must release this reference by calling the CFRelease function.
  ##  @discussion NOTE: Deprecated in iOS 12.0; use SecCertificateCopyKey instead for cross-platform availability.
  ##
  proc SecCertificateCopyPublicKey*(certificate: SecCertificateRef): SecKeyRef
when TARGET_OS_OSX:
  ## !
  ##  @function SecCertificateCopyPublicKey
  ##  @abstract Retrieves the public key for a given certificate.
  ##  @param certificate A reference to the certificate from which to retrieve the public key.
  ##  @param key On return, a reference to the public key for the specified certificate. Your code must release this reference by calling the CFRelease function.
  ##  @result A result code. See "Security Error Codes" (SecBase.h).
  ##  @discussion NOTE: Deprecated in macOS 10.14; use SecCertificateCopyKey instead for cross-platform availability.
  ##
  proc SecCertificateCopyPublicKey*(certificate: SecCertificateRef;
                                   key: ptr SecKeyRef): OSStatus
## !
##  @function SecCertificateCopySerialNumberData
##  @abstract Return the certificate's serial number.
##  @param certificate The certificate from which to get values.
##  @param error An optional pointer to a CFErrorRef which will be set on return from the function if an error occurred. If not NULL, the caller is responsible for releasing the CFErrorRef.
##  @discussion Return the content of a DER-encoded integer (without the tag and length fields) for this certificate's serial number. The caller must CFRelease the value returned.
##

proc SecCertificateCopySerialNumberData*(certificate: SecCertificateRef;
                                        error: ptr CFErrorRef): CFDataRef
when TARGET_OS_IPHONE:
  ## !
  ##  @function SecCertificateCopySerialNumber
  ##  @abstract Return the certificate's serial number.
  ##  @param certificate The certificate from which to get values.
  ##  @discussion Return the content of a DER-encoded integer (without the tag and length fields) for this certificate's serial number. The caller must CFRelease the value returned. NOTE: Deprecated in iOS 11.0; use SecCertificateCopySerialNumberData instead for cross-platform availability.
  ##
  proc SecCertificateCopySerialNumber*(certificate: SecCertificateRef): CFDataRef
when TARGET_OS_OSX:
  ## !
  ##  @function SecCertificateCopySerialNumber
  ##  @abstract Return the certificate's serial number.
  ##  @param certificate The certificate from which to get values.
  ##  @param error An optional pointer to a CFErrorRef which will be set on return from the function if an error occurred. If not NULL, the caller is responsible for releasing the CFErrorRef.
  ##  @discussion Return the content of a DER-encoded integer (without the tag and length fields) for this certificate's serial number. The caller must CFRelease the value returned. NOTE: Deprecated in macOS 10.13; use SecCertificateCopySerialNumberData instead for cross-platform availability.
  ##
  proc SecCertificateCopySerialNumber*(certificate: SecCertificateRef;
                                      error: ptr CFErrorRef): CFDataRef
##
##  Legacy functions (OS X only)
##

when SEC_OS_OSX:
  ## !
  ##     @enum CertificateItemAttributes
  ##     @abstract Indicates the type of a certificate item attribute.
  ##     @constant kSecSubjectItemAttr Indicates a DER-encoded subject distinguished name.
  ##     @constant kSecIssuerItemAttr Indicates a DER-encoded issuer distinguished name.
  ##     @constant kSecSerialNumberItemAttr Indicates a DER-encoded certificate serial number (without the tag and length).
  ##     @constant kSecPublicKeyHashItemAttr Indicates a public key hash.
  ##     @constant kSecSubjectKeyIdentifierItemAttr Indicates a subject key identifier.
  ##     @constant kSecCertTypeItemAttr Indicates a certificate type.
  ##     @constant kSecCertEncodingItemAttr Indicates a certificate encoding.
  ##
  const                       ## DEPRECATED_IN_MAC_OS_X_VERSION_10_7_AND_LATER
    kSecSubjectItemAttr* = "subj"
    kSecIssuerItemAttr* = "issu"
    kSecSerialNumberItemAttr* = "snbr"
    kSecPublicKeyHashItemAttr* = "hpky"
    kSecSubjectKeyIdentifierItemAttr* = "skid"
    kSecCertTypeItemAttr* = "ctyp"
    kSecCertEncodingItemAttr* = "cenc"
  ## !
  ##     @function SecCertificateCreateFromData
  ##     @abstract Creates a certificate based on the input data, type, and encoding.
  ##     @param data A pointer to the certificate data.
  ##     @param type The certificate type as defined in cssmtype.h.
  ##     @param encoding The certificate encoding as defined in cssmtype.h.
  ##     @param certificate On return, a reference to the newly created certificate.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion This API is deprecated in 10.7  Please use the SecCertificateCreateWithData API instead.
  ##
  proc SecCertificateCreateFromData*(data: ptr CSSM_DATA; `type`: CSSM_CERT_TYPE;
                                    encoding: CSSM_CERT_ENCODING;
                                    certificate: ptr SecCertificateRef): OSStatus
  ## !
  ##     @function SecCertificateAddToKeychain
  ##     @abstract Adds a certificate to the specified keychain.
  ##     @param certificate A reference to a certificate.
  ##     @param keychain A reference to the keychain in which to add the certificate. Pass NULL to add the certificate to the default keychain.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion This function is successful only if the certificate was created using the SecCertificateCreateFromData or
  ##     SecCertificateCreateWithData functions, and the certificate has not yet been added to the specified keychain.
  ##
  proc SecCertificateAddToKeychain*(certificate: SecCertificateRef;
                                   keychain: SecKeychainRef): OSStatus
  ## !
  ##     @function SecCertificateGetData
  ##     @abstract Retrieves the data for a given certificate.
  ##     @param certificate A reference to the certificate from which to retrieve the data.
  ##     @param data On return, the CSSM_DATA structure pointed to by data is filled in. You must allocate the space for a CSSM_DATA structure before calling this function. This data pointer is only guaranteed to remain valid as long as the certificate remains unchanged and valid.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion This API is deprecated in 10.7. Please use the SecCertificateCopyData API instead.
  ##
  proc SecCertificateGetData*(certificate: SecCertificateRef; data: CSSM_DATA_PTR): OSStatus
  ## !
  ##     @function SecCertificateGetType
  ##     @abstract Retrieves the type for a given certificate.
  ##     @param certificate A reference to the certificate from which to obtain the type.
  ##     @param certificateType On return, the certificate type of the certificate. Certificate types are defined in cssmtype.h.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion This API is deprecated in 10.7. Please use the SecCertificateCopyValues API instead.
  ##
  proc SecCertificateGetType*(certificate: SecCertificateRef;
                             certificateType: ptr CSSM_CERT_TYPE): OSStatus
  ## !
  ##     @function SecCertificateGetSubject
  ##     @abstract Retrieves the subject name for a given certificate.
  ##     @param certificate A reference to the certificate from which to obtain the subject name.
  ##     @param subject On return, a pointer to a CSSM_X509_NAME struct which contains the subject's X.509 name (x509defs.h). This pointer remains valid until the certificate reference is released. The caller should not attempt to free this pointer.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion Prior to Mac OS X 10.5, this function did not return any output in the subject parameter. Your code should check the returned pointer value (in addition to the function result) before attempting to use it.
  ##         For example:
  ##         const CSSM_X509_NAME *subject = NULL;
  ##         OSStatus status = SecCertificateGetSubject(certificate, &subject);
  ##         if ( (status == errSecSuccess) && (subject != NULL) ) {
  ##             // subject is valid
  ##         }
  ##        This API is deprecated in 10.7. Please use the SecCertificateCopyValues API instead.
  ##
  proc SecCertificateGetSubject*(certificate: SecCertificateRef;
                                subject: ptr ptr CSSM_X509_NAME): OSStatus
  ## !
  ##     @function SecCertificateGetIssuer
  ##     @abstract Retrieves the issuer name for a given certificate.
  ##     @param certificate A reference to the certificate from which to obtain the issuer name.
  ##     @param issuer On return, a pointer to a CSSM_X509_NAME struct which contains the issuer's X.509 name (x509defs.h). This pointer remains valid until the certificate reference is released. The caller should not attempt to free this pointer.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion Prior to Mac OS X 10.5, this function did not return any output in the issuer parameter. Your code should check the returned pointer value (in addition to the function result) before attempting to use it.
  ##         For example:
  ##         const CSSM_X509_NAME *issuer = NULL;
  ##         OSStatus status = SecCertificateGetIssuer(certificate, &issuer);
  ##         if ( (status == errSecSuccess) && (issuer != NULL) ) {
  ##             // issuer is valid
  ##         }
  ##         This API is deprecated in 10.7. Please use the SecCertificateCopyValues API instead.
  ##
  proc SecCertificateGetIssuer*(certificate: SecCertificateRef;
                               issuer: ptr ptr CSSM_X509_NAME): OSStatus
  ## !
  ##     @function SecCertificateGetCLHandle
  ##     @abstract Retrieves the certificate library handle for a given certificate.
  ##     @param certificate A reference to the certificate from which to obtain the certificate library handle.
  ##     @param clHandle On return, the certificate library handle of the given certificate. This handle remains valid at least as long as the certificate does.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion This API is deprecated in 10.7. Please use the SecCertificateCopyValues API instead.
  ##
  proc SecCertificateGetCLHandle*(certificate: SecCertificateRef;
                                 clHandle: ptr CSSM_CL_HANDLE): OSStatus
  ## !
  ##     @function SecCertificateGetAlgorithmID
  ##     @abstract Retrieves the algorithm identifier for a given certificate.
  ##     @param certificate A reference to the certificate from which to retrieve the algorithm identifier.
  ##     @param algid On return, a pointer to a CSSM_X509_ALGORITHM_IDENTIFIER struct which identifies the algorithm for this certificate (x509defs.h). This pointer remains valid until the certificate reference is released. The caller should not attempt to free this pointer.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     discussion This API is deprecated in 10.7. Please use the SecCertificateCopyValues API instead.
  ##
  proc SecCertificateGetAlgorithmID*(certificate: SecCertificateRef; algid: ptr ptr CSSM_X509_ALGORITHM_IDENTIFIER): OSStatus
  ## !
  ##     @function SecCertificateCopyPreference
  ##     @abstract Returns the preferred certificate for the specified name and key usage. If a preferred certificate does not exist for the specified name and key usage, NULL is returned.
  ##     @param name A string containing an email address (RFC822) or other name for which a preferred certificate is requested.
  ##     @param keyUsage A CSSM_KEYUSE key usage value, as defined in cssmtype.h. Pass 0 to ignore this parameter.
  ##     @param certificate On return, a reference to the preferred certificate, or NULL if none was found. You are responsible for releasing this reference by calling the CFRelease function.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion This function will typically be used to obtain the preferred encryption certificate for an email recipient.
  ##     This API is deprecated in 10.7. Please use the SecCertificateCopyPreferred API instead.
  ##
  proc SecCertificateCopyPreference*(name: CFStringRef; keyUsage: uint32;
                                    certificate: ptr SecCertificateRef): OSStatus
  ## !
  ##     @function SecCertificateCopyPreferred
  ##     @abstract Returns the preferred certificate for the specified name and key usage. If a preferred certificate does not exist for the specified name and key usage, NULL is returned.
  ##     @param name A string containing an email address (RFC822) or other name for which a preferred certificate is requested.
  ##     @param keyUsage A CFArrayRef value, containing items defined in SecItem.h  Pass NULL to ignore this parameter. (kSecAttrCanEncrypt, kSecAttrCanDecrypt, kSecAttrCanDerive, kSecAttrCanSign, kSecAttrCanVerify, kSecAttrCanWrap, kSecAttrCanUnwrap)
  ##     @result On return, a reference to the preferred certificate, or NULL if none was found. You are responsible for releasing this reference by calling the CFRelease function.
  ##     @discussion This function will typically be used to obtain the preferred encryption certificate for an email recipient. If a preferred certificate has not been set
  ##     for the supplied name, the returned reference will be NULL. Your code should then perform a search for possible certificates, using the SecItemCopyMatching API.
  ##
  proc SecCertificateCopyPreferred*(name: CFStringRef; keyUsage: CFArrayRef): SecCertificateRef
  ## !
  ##     @function SecCertificateSetPreference
  ##     @abstract Sets the preferred certificate for a specified name, key usage, and date.
  ##     @param certificate A reference to the certificate which will be preferred.
  ##     @param name A string containing an email address (RFC822) or other name for which a preferred certificate will be associated.
  ##     @param keyUsage A CSSM_KEYUSE key usage value, as defined in cssmtype.h. Pass 0 to avoid specifying a particular key usage.
  ##     @param date (optional) A date reference. If supplied, the preferred certificate will be changed only if this date is later than the currently saved setting. Pass NULL if this preference should not be restricted by date.
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion This function will typically be used to set the preferred encryption certificate for an email recipient, either manually (when encrypting email to a recipient) or automatically upon receipt of encrypted email.
  ##     This API is deprecated in 10.7. Plese use the SecCertificateSetPreferred API instead.
  ##
  proc SecCertificateSetPreference*(certificate: SecCertificateRef;
                                   name: CFStringRef; keyUsage: uint32;
                                   date: CFDateRef): OSStatus
  ## !
  ##     @function SecCertificateSetPreferred
  ##     @abstract Sets the preferred certificate for a specified name and optional key usage.
  ##     @param certificate A reference to the preferred certificate. If NULL is passed, any existing preference for the specified name is cleared instead.
  ##     @param name A string containing an email address (RFC822) or other name for which a preferred certificate will be associated.
  ##     @param keyUsage A CFArrayRef value, containing items defined in SecItem.h  Pass NULL to ignore this parameter. (kSecAttrCanEncrypt, kSecAttrCanDecrypt, kSecAttrCanDerive, kSecAttrCanSign, kSecAttrCanVerify, kSecAttrCanWrap, kSecAttrCanUnwrap)
  ##     @result A result code. See "Security Error Codes" (SecBase.h).
  ##     @discussion This function will typically be used to set the preferred encryption certificate for an email recipient, either manually (when encrypting email to a recipient)
  ##     or automatically upon receipt of encrypted email.
  ##
  proc SecCertificateSetPreferred*(certificate: SecCertificateRef;
                                  name: CFStringRef; keyUsage: CFArrayRef): OSStatus
  ## !
  ##  @typedef SecKeyUsage
  ##  @abstract Flags to indicate key usages in the KeyUsage extension of a certificate
  ##  @constant kSecKeyUsageUnspecified No KeyUsage extension in certificate.
  ##  @constant kSecKeyUsageDigitalSignature DigitalSignature bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageNonRepudiation NonRepudiation bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageContentCommitment ContentCommitment bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageKeyEncipherment KeyEncipherment bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageDataEncipherment DataEncipherment bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageKeyAgreement KeyAgreement bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageKeyCertSign KeyCertSign bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageCRLSign CRLSign bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageEncipherOnly EncipherOnly bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageDecipherOnly DecipherOnly bit set in KeyUsage extension.
  ##  @constant kSecKeyUsageCritical KeyUsage extension is marked critical.
  ##  @constant kSecKeyUsageAll For masking purposes, all SecKeyUsage values.
  ##
  type
    SecKeyUsage* = uint32_t
  const
    kSecKeyUsageUnspecified* = 0
    kSecKeyUsageDigitalSignature* = 1 shl 0
    kSecKeyUsageNonRepudiation* = 1 shl 1
    kSecKeyUsageContentCommitment* = 1 shl 1
    kSecKeyUsageKeyEncipherment* = 1 shl 2
    kSecKeyUsageDataEncipherment* = 1 shl 3
    kSecKeyUsageKeyAgreement* = 1 shl 4
    kSecKeyUsageKeyCertSign* = 1 shl 5
    kSecKeyUsageCRLSign* = 1 shl 6
    kSecKeyUsageEncipherOnly* = 1 shl 7
    kSecKeyUsageDecipherOnly* = 1 shl 8
    kSecKeyUsageCritical* = 1 shl 31
    kSecKeyUsageAll* = 0x7FFFFFFF
  ## !
  ##  @enum kSecPropertyKey
  ##  @abstract Constants used to access dictionary entries returned by SecCertificateCopyValues
  ##  @constant kSecPropertyKeyType The type of the entry
  ##  @constant kSecPropertyKeyLabel The label of the entry
  ##  @constant kSecPropertyKeyLocalizedLabel The localized label of the entry
  ##  @constant kSecPropertyKeyValue The value of the entry
  ##
  var kSecPropertyKeyType*: CFStringRef
  var kSecPropertyKeyLabel*: CFStringRef
  var kSecPropertyKeyLocalizedLabel*: CFStringRef
  var kSecPropertyKeyValue*: CFStringRef
  ## !
  ##     @enum kSecPropertyType
  ##     @abstract Public Constants for property list values returned by SecCertificateCopyValues
  ##     @discussion Note that kSecPropertyTypeTitle and kSecPropertyTypeError are defined in SecTrust.h
  ##
  var kSecPropertyTypeWarning*: CFStringRef
  var kSecPropertyTypeSuccess*: CFStringRef
  var kSecPropertyTypeSection*: CFStringRef
  var kSecPropertyTypeData*: CFStringRef
  var kSecPropertyTypeString*: CFStringRef
  var kSecPropertyTypeURL*: CFStringRef
  var kSecPropertyTypeDate*: CFStringRef
  var kSecPropertyTypeArray*: CFStringRef
  var kSecPropertyTypeNumber*: CFStringRef
  ## !
  ##     @function SecCertificateCopyValues
  ##     @abstract        Creates a dictionary that represents a certificate's contents.
  ##     @param certificate The certificate from which to get values
  ##     @param keys        An array of string OID values, or NULL. If present, this is
  ##                     the subset of values from the certificate to return. If NULL,
  ##                     all values will be returned. Only OIDs that are top level keys
  ##                     in the returned dictionary can be specified. Unknown OIDs are
  ##                     ignored.
  ##     @param error    An optional pointer to a CFErrorRef. This value is
  ##                     set if an error occurred.  If not NULL the caller is
  ##                     responsible for releasing the CFErrorRef.
  ##     @discussion        The keys array will contain all of the keys used in the
  ##                     returned dictionary. The top level keys in the returned
  ##                     dictionary are OIDs, many of which are found in SecCertificateOIDs.h.
  ##                     Each entry that is returned is itself a dictionary with four
  ##                     entries, whose keys are kSecPropertyKeyType, kSecPropertyKeyLabel,
  ##                     kSecPropertyKeyLocalizedLabel, kSecPropertyKeyValue. The label
  ##                     entries may contain a descriptive (localized) string, or an
  ##                     OID string. The kSecPropertyKeyType describes the type in the
  ##                     value entry. The value entry may be any CFType, although it
  ##                     is usually a CFStringRef, CFArrayRef or a CFDictionaryRef.
  ##
  proc SecCertificateCopyValues*(certificate: SecCertificateRef; keys: CFArrayRef;
                                error: ptr CFErrorRef): CFDictionaryRef
  ## !
  ##     @function             SecCertificateCopyLongDescription
  ##     @abstract            Return the long description of a certificate
  ##     @param alloc         The CFAllocator which should be used to allocate
  ##                         memory for the dictionary and its storage for values. This
  ##                         parameter may be NULL in which case the current default
  ##                         CFAllocator is used. If this reference is not a valid
  ##                         CFAllocator, the behavior is undefined.
  ##     @param certificate    The certificate from which to retrieve the long description
  ##     @param    error        An optional pointer to a CFErrorRef. This value is
  ##                         set if an error occurred.  If not NULL the caller is
  ##                         responsible for releasing the CFErrorRef.
  ##     @result                A CFStringRef of the long description or NULL. If NULL and the error
  ##                         parameter is supplied the error will be returned in the error parameter
  ##     @discussion            Note that the format of this string may change in the future
  ##
  proc SecCertificateCopyLongDescription*(alloc: CFAllocatorRef;
      certificate: SecCertificateRef; error: ptr CFErrorRef): CFStringRef
  ## !
  ##     @function             SecCertificateCopyShortDescription
  ##     @abstract            Return the short description of a certificate
  ##     @param alloc         The CFAllocator which should be used to allocate
  ##                         memory for the dictionary and its storage for values. This
  ##                         parameter may be NULL in which case the current default
  ##                         CFAllocator is used. If this reference is not a valid
  ##                         CFAllocator, the behavior is undefined.
  ##     @param certificate    The certificate from which to retrieve the short description
  ##     @param    error        An optional pointer to a CFErrorRef. This value is
  ##                         set if an error occurred.  If not NULL the caller is
  ##                         responsible for releasing the CFErrorRef.
  ##     @result                A CFStringRef of the short description or NULL. If NULL and the error
  ##                         parameter is supplied the error will be returned in the error parameter
  ##  @discussion            Note that the format of this string may change in the future
  ##
  proc SecCertificateCopyShortDescription*(alloc: CFAllocatorRef;
      certificate: SecCertificateRef; error: ptr CFErrorRef): CFStringRef
  ## !
  ##     @function            SecCertificateCopyNormalizedIssuerContent
  ##     @abstract            Return the certificate's normalized issuer
  ##     @param certificate    The certificate from which to get values
  ##     @param error        An optional pointer to a CFErrorRef. This value is
  ##                         set if an error occurred.  If not NULL the caller is
  ##                         responsible for releasing the CFErrorRef.
  ##     @discussion            The issuer is a sequence in the format used by
  ##                         SecItemCopyMatching.  The content returned is a DER-encoded
  ##                         X.509 distinguished name. For a display version of the issuer,
  ##                         call SecCertificateCopyValues. The caller must CFRelease
  ##                         the value returned.
  ##
  proc SecCertificateCopyNormalizedIssuerContent*(certificate: SecCertificateRef;
      error: ptr CFErrorRef): CFDataRef
  ## !
  ##     @function           SecCertificateCopyNormalizedSubjectContent
  ##     @abstract           Return the certificate's normalized subject
  ##     @param certificate  The certificate from which to get values
  ##     @param error        An optional pointer to a CFErrorRef. This value is
  ##                         set if an error occurred.  If not NULL the caller is
  ##                         responsible for releasing the CFErrorRef.
  ##     @discussion         The subject is a sequence in the format used by
  ##                         SecItemCopyMatching. The content returned is a DER-encoded
  ##                         X.509 distinguished name. For a display version of the subject,
  ##                         call SecCertificateCopyValues. The caller must CFRelease
  ##                         the value returned.
  ##
  proc SecCertificateCopyNormalizedSubjectContent*(
      certificate: SecCertificateRef; error: ptr CFErrorRef): CFDataRef