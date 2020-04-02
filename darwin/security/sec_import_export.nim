##
##  Copyright (c) 2000-2011,2012-2014,2016 Apple Inc. All Rights Reserved.
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
##      @header SecImportExport
##      contains import/export functionality for keys and certificates.
##

when SEC_OS_OSX:
when SEC_OS_OSX:
  ##
  ##  Supported import/export Formats
  ##
  type
    SecExternalFormat* = uint32_t
  const                       ##
       ##  When importing: unknown format
       ##  When exporting: default format for item
       ##
    kSecFormatUnknown* = 0      ##
                        ##  Public and Private Key formats.
                        ##  Default for export is kSecFormatOpenSSL.
                        ##
    kSecFormatOpenSSL* = 1      ##  a.k.a. X509 for public keys
    kSecFormatSSH* = 2          ##  OpenSSH v.1
    kSecFormatBSAFE* = 3        ##  Symmetric Key Formats
    kSecFormatRawKey* = 4       ##  raw unformatted key bits; default
                       ##  Formats for wrapped symmetric and private keys
    kSecFormatWrappedPKCS8* = 5
    kSecFormatWrappedOpenSSL* = 6 ##  traditional openssl
    kSecFormatWrappedSSH* = 7   ##  OpenSSH v.1
    kSecFormatWrappedLSH* = 8   ##  Formats for certificates
    kSecFormatX509Cert* = 9     ##  DER encoded; default
                         ##  Aggregate Types
    kSecFormatPEMSequence* = 10 ##  sequence of certs and/or keys, implies PEM
                             ##     armour. Default format for multiple items
    kSecFormatPKCS7* = 11       ##  sequence of certs
    kSecFormatPKCS12* = 12      ##  set of certs and private keys
    kSecFormatNetscapeCertSequence* = 13 ##  sequence of certs, form netscape-cert-sequence
                                      ##  Added in Mac OS X 10.5
    kSecFormatSSHv2* = 14       ##  OpenSSH v.2. Note that OpenSSH v2 private keys
                       ##  are in format kSecFormatOpenSSL or
                       ##  kSecFormatWrappedOpenSSL.
  ##
  ##  Indication of basic item type when importing.
  ##
  type
    SecExternalItemType* = uint32_t
  const
    kSecItemTypeUnknown* = 0    ##  caller doesn't know what this is
    kSecItemTypePrivateKey* = 1
    kSecItemTypePublicKey* = 2
    kSecItemTypeSessionKey* = 3
    kSecItemTypeCertificate* = 4
    kSecItemTypeAggregate* = 5  ##  PKCS7, PKCS12, kSecFormatPEMSequence, etc.
  ##
  ##  Flags passed to SecKeychainItemExport() and SecKeychainItemImport().
  ##
  type
    SecItemImportExportFlags* = uint32_t
  const
    kSecItemPemArmour* = 0x00000001 ##  exported blob is PEM formatted
  ##
  ##  SecKeyRef-specific flags, specified in SecKeyImportExportParameters.flags
  ##
  type
    SecKeyImportExportFlags* = uint32_t
  const ##
       ##  When true, prevents the importing of more than one private key
       ##  in a given SecKeychainItemImport().
       ##
    kSecKeyImportOnlyOne* = 0x00000001 ##
                                    ##  When true, passphrase for import/export is obtained by user prompt
                                    ##  instead of by caller-supplied data (SecKeyImportExportParameters.passphrase).
                                    ##  This is the preferred method for obtaining a user-supplied passphrase
                                    ##  as it avoids having the cleartext passphrase appear in the app's
                                    ##  address space at any time.
                                    ##
    kSecKeySecurePassphrase* = 0x00000002 ##
                                       ##  When true, imported private keys will have no Access Control List
                                       ##  (ACL) attached to them. In the absence of both this bit and the accessRef
                                       ##  field in SecKeyImportExportParameters (see below), imported private
                                       ##  keys are given a default ACL.
                                       ##
    kSecKeyNoAccessControl* = 0x00000004
  ##
  ##  Version of a SecKeyImportExportParameters.
  ##
  const
    SEC_KEY_IMPORT_EXPORT_PARAMS_VERSION* = 0
  ##
  ##  Parameters specific to SecKeyRefs.
  ##
  type
    SecKeyImportExportParameters* {.bycopy.} = object
      version*: uint32_t       ##  for import and export
      ##  SEC_KEY_IMPORT_EXPORT_PARAMS_VERSION
      flags*: SecKeyImportExportFlags ##  SecKeyImportExportFlags bits
      passphrase*: CFTypeRef   ##  kSecFormatPKCS12, kSecFormatWrapped*
                           ##     formats only. Legal types are
                           ##     CFStringRef and CFDataRef.
      alertTitle*: CFStringRef ##  title of secure passphrase alert panel
      alertPrompt*: CFStringRef ##  prompt in secure passphrase alert panel
                              ##  for import only
      accessRef*: SecAccessRef ##  specifies the initial ACL of imported
                             ##     key(s)
      keyUsage*: CSSM_KEYUSE   ##  CSSM_KEYUSE_DECRYPT, CSSM_KEYUSE_SIGN,
                           ##     etc.
      keyAttributes*: CSSM_KEYATTR_FLAGS ##  CSSM_KEYATTR_PERMANENT, etc.

    SecItemImportExportKeyParameters* {.bycopy.} = object
      version*: uint32_t       ##  for import and export
      ##  SEC_KEY_IMPORT_EXPORT_PARAMS_VERSION
      flags*: SecKeyImportExportFlags ##  SecKeyImportExportFlags bits
      passphrase*: CFTypeRef   ##  kSecFormatPKCS12, kSecFormatWrapped*
                           ##     formats only. Legal types are
                           ##     CFStringRef and CFDataRef.
      alertTitle*: CFStringRef ##  title of secure passphrase alert panel
      alertPrompt*: CFStringRef ##  prompt in secure passphrase alert panel
                              ##  for import only
      accessRef*: SecAccessRef ##  specifies the initial ACL of imported
                             ##     key(s)
      keyUsage*: CFArrayRef ##  An Array containing usage attributes from SecItem.h, e.g.
                          ##      kSecAttrCanEncrypt;, kSecAttrCanDecrypt, kSecAttrCanDerive, etc.
                          ##
      keyAttributes*: CFArrayRef ##  An array containing zero or more key attributes
                               ##     for an imported key. Possible values (from SecItem.h):
                               ##     kSecAttrIsPermanent, kSecAttrIsSensitive, kSecAttrIsExtractable
                               ##     Pass NULL in this field to use default attributes:
                               ##     - kSecAttrIsPermanent if a keychain is specified
                               ##     - kSecAttrIsSensitive for private keys
                               ##     - kSecAttrIsExtractable by default
                               ##

  ##
  ##  SecKeychainItemExport()
  ##
  ##  This function takes one or more SecKeychainItemRefs and creates an
  ##  external representation of the item(s) in the form of a CFDataRef.
  ##  Caller specifies the format of the external representation via a
  ##  SecExternalFormat enum. Caller may specify kSecFormatUnknown for
  ##  the format, in which case a the default format for the item
  ##  being exported is used (as described in the SecExternalFormat enums).
  ##  PEM armouring is optional and is specified by the kSecItemPemArmour
  ##  flag in importFlags.
  ##
  ##  If exactly one item is to be exported, the keychainItemOrArray argument
  ##  can be a SecKeychainItem. Otherwise this argument is a CFArrayRef
  ##  containing a number of SecKeychainItems.
  ##
  ##  The exported item(s) is (are) returned to the caller via the
  ##  CFDataRef *exportedData argument. Caller must CFRelease the result.
  ##
  ##  The following SecKeychainItems may be exported:
  ##
  ##    SecCertificateRef
  ##    SecKeyRef
  ##    SecIdentityRef
  ##
  ##
  ##  Key-related SecKeyImportExportParameters fields
  ##  -----------------------------------------------
  ##
  ##  When exporting SecKeyRefs in one of the wrapped formats
  ##  (kSecFormatWrappedOpenSSL, kSecFormatWrappedSSH,
  ##  kSecFormatWrappedPKCS8), or in PKCS12 format, caller must
  ##  either explicitly specify the passphrase field or set
  ##  the kSecKeySecurePassphrase bit in SecKeyImportExportFlags.
  ##
  ##  If kSecKeySecurePassphrase is selected, caller can optionally
  ##  specify strings for the passphrase panel's title bar and for
  ##  the prompt which appears in the panel via the alertTitle and
  ##  alertPrompt fields in SecKeyImportExportParameters.
  ##
  ##  If an explicit passphrase is specified, note that PKCS12
  ##  explicitly requires that passphrases are in Unicode format;
  ##  passing in a CFStringRef as the passphrase is the safest way
  ##  to ensure that this requirement is met (and that the result
  ##  will be compatible with other implementations). If a CFDataRef
  ##  is supplied as the passphrase for a PKCS12 export operation,
  ##  the referent data is assumed to be in UTF8 form and will be
  ##  converted as appropriate.
  ##
  ##  If no key items are being exported, the keyParams argument may be NULL.
  ##  @discussion This API has been deprecated. Please us the SecItemExport API instead.
  ##
  proc SecKeychainItemExport*(keychainItemOrArray: CFTypeRef;
                             outputFormat: SecExternalFormat;
                             flags: SecItemImportExportFlags;
                             keyParams: ptr SecKeyImportExportParameters;
                             exportedData: ptr CFDataRef): OSStatus
    ##  kSecItemPemArmour, etc.
    ##  optional
    ##  external representation returned here
  ##
  ##  SecItemExport()
  ##
  ##  This function takes one or more SecItemRefs and creates an
  ##  external representation of the item(s) in the form of a CFDataRef.
  ##  Caller specifies the format of the external representation via a
  ##  SecExternalFormat enum. Caller may specify kSecFormatUnknown for
  ##  the format, in which case a the default format for the item
  ##  being exported is used (as described in the SecExternalFormat enums).
  ##  PEM armouring is optional and is specified by the kSecItemPemArmour
  ##  flag in importFlags.
  ##
  ##  If exactly one item is to be exported, the keychainItemOrArray argument
  ##  can be a SecKeychainItem. Otherwise this argument is a CFArrayRef
  ##  containing a number of SecKeychainItems.
  ##
  ##  The exported item(s) is (are) returned to the caller via the
  ##  CFDataRef *exportedData argument. Caller must CFRelease the result.
  ##
  ##  The following SecKeychainItems may be exported:
  ##
  ##    SecCertificateRef
  ##    SecKeyRef
  ##    SecIdentityRef
  ##
  ##
  ##  Key-related SecItemExport fields
  ##  -----------------------------------------------
  ##
  ##  When exporting SecKeyRefs in one of the wrapped formats
  ##  (kSecFormatWrappedOpenSSL, kSecFormatWrappedSSH,
  ##  kSecFormatWrappedPKCS8), or in PKCS12 format, caller must
  ##  either explicitly specify the passphrase field or set
  ##  the kSecKeySecurePassphrase bit in SecKeyImportExportFlags.
  ##
  ##  If kSecKeySecurePassphrase is selected, caller can optionally
  ##  specify strings for the passphrase panel's title bar and for
  ##  the prompt which appears in the panel via the alertTitle and
  ##  alertPrompt fields in SecItemImportExportKeyParameters.
  ##
  ##  If an explicit passphrase is specified, note that PKCS12
  ##  explicitly requires that passphrases are in Unicode format;
  ##  passing in a CFStringRef as the passphrase is the safest way
  ##  to ensure that this requirement is met (and that the result
  ##  will be compatible with other implementations). If a CFDataRef
  ##  is supplied as the passphrase for a PKCS12 export operation,
  ##  the referent data is assumed to be in UTF8 form and will be
  ##  converted as appropriate.
  ##
  ##  If no key items are being exported, the keyParams argument may be NULL.
  ##
  ##
  proc SecItemExport*(secItemOrArray: CFTypeRef; outputFormat: SecExternalFormat;
                     flags: SecItemImportExportFlags;
                     keyParams: ptr SecItemImportExportKeyParameters;
                     exportedData: ptr CFDataRef): OSStatus
    ##  kSecItemPemArmour, etc.
    ##  optional
    ##  external representation returned here
  ##
  ##  SecKeychainItemImport()
  ##
  ##  This function takes a CFDataRef containing the external representation
  ##  of one or more objects and creates SecKeychainItems corresponding to
  ##  those objects and optionally imports those SecKeychainItems into a
  ##  specified keychain. The format of the incoming representation is
  ##  specified by one or more of the following:
  ##
  ##  -- A SecExternalFormat. This optional in/out argument is used when
  ##     the caller knows exactly what format the external representation
  ##     is in. It's also used to return to the caller the format which the
  ##     function actually determines the external representation to be in.
  ##     A value of kSecFormatUnknown is specified on entry when the caller
  ##     wishes to know the inferred format on return.
  ##
  ##  -- A SecExternalItemType - optional, in/out. Used to specify what kind
  ##     of item is in the incoming representation, if known by the caller.
  ##     It's also used to return to the caller the item type which the
  ##     function actually determines the external representation to contain.
  ##     A value of kSecItemTypeUnknown is specified on entry when the caller
  ##     wishes to know the inferred item type on return.
  ##
  ##  -- fileNameOrExtension, a CFStringRef. This optional argument contains
  ##     the name of the file from which the external representation was
  ##     obtained; it can also be simply an extension like CFSTR(".p7r").
  ##     This is a convenience for apps like KeychainAccess which can import a
  ##     number of different formats.
  ##
  ##  The SecKeychainItemImport() call does its best to figure out what is
  ##  in an incoming external item given the info provided by the above three
  ##  arguments. In most cases, SecKeychainItemImport() can even figure out
  ##  what's in an external item if none of these are specified, but it would
  ##  be unwise for an application to count on that ability.
  ##
  ##  PEM formatting is determined internally via inspection of the incoming
  ##  data, so the kSecItemPemArmour in the flags field is ignored.
  ##
  ##  Zero, one, or both of the following occurs upon successful completion
  ##  of this function:
  ##
  ##  -- The imported item(s) is (are) imported to the specified importKeychain.
  ##     If importKeychain is NULL, this step does not occur.
  ##
  ##  -- The imported item(s) is (are) returned to the caller via the
  ##     CFArrayRef *outItems argument. If outItems is NULL, this step
  ##     does not occur. If outItems is NON-NULL, then *outItems will be
  ##     a CFArrayRef containing a number of SecKeychainItems upon return.
  ##     Caller must CFRelease the result.
  ##
  ##  The possible types of returned SecKeychainItems are:
  ##
  ##    SecCertificateRef
  ##    SecKeyRef
  ##    SecIdentityRef
  ##
  ##  Note that when importing a PKCS12 blob, typically one SecIdentityRef
  ##  and zero or more additional SecCertificateRefs are returned in
  ##  outItems. No SecKeyRefs will appear there unless a key
  ##  is found in the incoming blob with does not have a matching
  ##  certificate.
  ##
  ##  A typical case in which an app specifies the outItems
  ##  argument and a NULL for importKeychain is when the app wishes to
  ##  perform some user interaction, perhaps on a per-item basis, before
  ##  committing to actually import the item(s). In this case, if the app
  ##  does wish to proceed with the import, the standard import calls
  ##  (SecCertificateAddToKeychain(), SecKeyAddToKeychain (implementation
  ##  TBD)) would be used.
  ##
  ##  Passing in NULL for both outItems and importKeychain
  ##  is a perfectly acceptable way of using this function to determine,
  ##  in a non-intrusive way, what is inside a given data blob. No effect
  ##  other than returning inputFormat and/or itemType occurs in this
  ##  case.
  ##
  ##
  ##  Key-related SecKeyImportExportParameters fields
  ##  -----------------------------------------------
  ##
  ##  If importKeychain is NULL, the kSecKeyImportOnlyOne bit in the flags
  ##  argument is ignored. Otherwise, if the kSecKeyImportOnlyOne bit is set, and
  ##  there is more than one key in the incoming external representation, no
  ##  items will be imported to the specified keychain and errSecMultipleKeys will
  ##  be returned.
  ##
  ##  The accessRef field allows the caller to specify the initial SecAccessRef
  ##  for imported private keys. If more than one private key is being imported,
  ##  all private keys get the same initial SecAccessRef. If this field is NULL
  ##  when private keys are being imported, then the ACL attached to imported
  ##  private keys depends on the kSecKeyNoAccessControl bit in the specified
  ##  keyParams->flags. If this bit is 0, or keyParams is NULL, the default ACL
  ##  will be used. If this bit is 1, no ACL will be attached to imported
  ##  private keys.
  ##
  ##  keyUsage and keyAttributes specify the low-level usage and attribute flags
  ##  of imported keys. Each is a word of bits. The default value for keyUsage
  ##  (used when keyParams is NULL or if keyParams->keyUsage is zero) is
  ##  CSSM_KEYUSE_ANY. The default value for keyAttributes defaults is
  ##  CSSM_KEYATTR_SENSITIVE | CSSM_KEYATTR_EXTRACTABLE; the CSSM_KEYATTR_PERMANENT
  ##  bit is also added to the default if a non-NULL importKeychain is provided.
  ##
  ##  The following are valid bits in keyAttributes:
  ##
  ##    CSSM_KEYATTR_PERMANENT
  ##    CSSM_KEYATTR_SENSITIVE
  ##    CSSM_KEYATTR_EXTRACTABLE
  ##
  ##  If the CSSM_KEYATTR_PERMANENT is set then the importKeychain argument must
  ##  be valid or errSecInvalidKeychain will be returned if in fact any keys are found
  ##  in the external representation.
  ##
  ##  Note that if the caller does not set the CSSM_KEYATTR_EXTRACTABLE, this key
  ##  will never be able to be extracted from the keychain in any form, not even
  ##  in wrapped form. The CSSM_KEYATTR_SENSITIVE indicates that the key can only
  ##  be extracted in wrapped form.
  ##
  ##  The CSSM_KEYATTR_RETURN_xxx bits are always forced to
  ##  CSSM_KEYATTR_RETURN_REF regardless of the specified keyAttributes
  ##  field.
  ##
  ##  When importing SecKeyRefs in one of the wrapped formats
  ##  (kSecFormatWrappedOpenSSL, kSecFormatWrappedSSH,
  ##  kSecFormatWrappedPKCS8), or in PKCS12 format, caller must
  ##  either explicitly specify the passphrase field or set
  ##  the kSecKeySecurePassphrase bit in SecKeyImportExportFlags.
  ##
  ##  If kSecKeySecurePassphrase is selected, caller can optionally
  ##  specify strings for the passphrase panel's title bar and for
  ##  the prompt which appears in the panel via the alertTitle and
  ##  alertPrompt fields in SecKeyImportExportParameters.
  ##
  ##  If an explicit passphrase is specified, note that PKCS12
  ##  explicitly requires that passphrases are in Unicode format;
  ##  passing in a CFStringRef as the passphrase is the safest way
  ##  to ensure that this requirement is met (and that the result
  ##  will be compatible with other implementations). If a CFDataRef
  ##  is supplied as the passphrase for a PKCS12 export operation,
  ##  the referent data is assumed to be in UTF8 form and will be
  ##  converted as appropriate.
  ##
  ##  If no key items are being imported, the keyParams argument may be NULL.
  ##
  ##  The SecItemImportExportFlags argument is currently unused; caller should pass
  ##  in 0.
  ##
  ##  @discussion  This API has been deprecated.  Please use the SecItemImport API instead.
  ##
  proc SecKeychainItemImport*(importedData: CFDataRef;
                             fileNameOrExtension: CFStringRef;
                             inputFormat: ptr SecExternalFormat;
                             itemType: ptr SecExternalItemType;
                             flags: SecItemImportExportFlags;
                             keyParams: ptr SecKeyImportExportParameters;
                             importKeychain: SecKeychainRef;
                             outItems: ptr CFArrayRef): OSStatus
    ##  optional
    ##  optional, IN/OUT
    ##  optional, IN/OUT
    ##  optional
    ##  optional
    ##  optional
  ##
  ##  SecItemImport()
  ##
  ##  This function takes a CFDataRef containing the external representation
  ##  of one or more objects and creates SecKeychainItems corresponding to
  ##  those objects and optionally imports those SecKeychainItems into a
  ##  specified keychain. The format of the incoming representation is
  ##  specified by one or more of the following:
  ##
  ##  -- A SecExternalFormat. This optional in/out argument is used when
  ##     the caller knows exactly what format the external representation
  ##     is in. It's also used to return to the caller the format which the
  ##     function actually determines the external representation to be in.
  ##     A value of kSecFormatUnknown is specified on entry when the caller
  ##     wishes to know the inferred format on return.
  ##
  ##  -- A SecExternalItemType - optional, in/out. Used to specify what kind
  ##     of item is in the incoming representation, if known by the caller.
  ##     It's also used to return to the caller the item type which the
  ##     function actually determines the external representation to contain.
  ##     A value of kSecItemTypeUnknown is specified on entry when the caller
  ##     wishes to know the inferred item type on return.
  ##
  ##  -- fileNameOrExtension, a CFStringRef. This optional argument contains
  ##     the name of the file from which the external representation was
  ##     obtained; it can also be simply an extension like CFSTR(".p7r").
  ##     This is a convenience for apps like KeychainAccess which can import a
  ##     number of different formats.
  ##
  ##  The SecItemImport() call does its best to figure out what is
  ##  in an incoming external item given the info provided by the above three
  ##  arguments. In most cases, SecItemImport() can even figure out
  ##  what's in an external item if none of these are specified, but it would
  ##  be unwise for an application to count on that ability.
  ##
  ##  PEM formatting is determined internally via inspection of the incoming
  ##  data, so the kSecItemPemArmour in the flags field is ignored.
  ##
  ##  Zero, one, or both of the following occurs upon successful completion
  ##  of this function:
  ##
  ##  -- The imported item(s) is (are) imported to the specified importKeychain.
  ##     If importKeychain is NULL, this step does not occur.
  ##
  ##  -- The imported item(s) is (are) returned to the caller via the
  ##     CFArrayRef *outItems argument. If outItems is NULL, this step
  ##     does not occur. If outItems is NON-NULL, then *outItems will be
  ##     a CFArrayRef containing a number of SecKeychainItems upon return.
  ##     Caller must CFRelease the result.
  ##
  ##  The possible types of returned SecKeychainItems are:
  ##
  ##    SecCertificateRef
  ##    SecKeyRef
  ##    SecIdentityRef
  ##
  ##  Note that when importing a PKCS12 blob, typically one SecIdentityRef
  ##  and zero or more additional SecCertificateRefs are returned in
  ##  outItems. No SecKeyRefs will appear there unless a key
  ##  is found in the incoming blob with does not have a matching
  ##  certificate.
  ##
  ##  A typical case in which an app specifies the outItems
  ##  argument and a NULL for importKeychain is when the app wishes to
  ##  perform some user interaction, perhaps on a per-item basis, before
  ##  committing to actually import the item(s). In this case, if the app
  ##  does wish to proceed with the import, the standard import calls
  ##  (SecCertificateAddToKeychain(), SecKeyAddToKeychain (implementation
  ##  TBD)) would be used.
  ##
  ##  Passing in NULL for both outItems and importKeychain
  ##  is a perfectly acceptable way of using this function to determine,
  ##  in a non-intrusive way, what is inside a given data blob. No effect
  ##  other than returning inputFormat and/or itemType occurs in this
  ##  case.
  ##
  ##
  ##  Key-related SecItemImportExportKeyParameters fields
  ##  -----------------------------------------------
  ##
  ##  If importKeychain is NULL, the kSecKeyImportOnlyOne bit in the flags
  ##  argument is ignored. Otherwise, if the kSecKeyImportOnlyOne bit is set, and
  ##  there is more than one key in the incoming external representation, no
  ##  items will be imported to the specified keychain and errSecMultipleKeys will
  ##  be returned.
  ##
  ##  The accessRef field allows the caller to specify the initial SecAccessRef
  ##  for imported private keys. If more than one private key is being imported,
  ##  all private keys get the same initial SecAccessRef. If this field is NULL
  ##  when private keys are being imported, then the ACL attached to imported
  ##  private keys depends on the kSecKeyNoAccessControl bit in the specified
  ##  keyParams->flags. If this bit is 0, or keyParams is NULL, the default ACL
  ##  will be used. If this bit is 1, no ACL will be attached to imported
  ##  private keys.
  ##
  ##  keyUsage and keyAttributes specify the low-level usage and attribute flags
  ##  of imported keys. These fields contain a CFArray whose values are constants
  ##  from SecItem.h.
  ##
  ##  Possible values in the keyUsage array:
  ##
  ##    kSecAttrCanEncrypt
  ##    kSecAttrCanDecrypt
  ##    kSecAttrCanDerive
  ##    kSecAttrCanSign
  ##    kSecAttrCanVerify
  ##    kSecAttrCanWrap
  ##    kSecAttrCanUnwrap
  ##
  ##  If keyUsage is set to NULL, then any key usage is permitted.
  ##
  ##  Possible values in the keyAttributes array:
  ##
  ##    kSecAttrIsPermanent
  ##    kSecAttrIsSensitive
  ##    kSecAttrIsExtractable
  ##
  ##  If keyAttributes is set to NULL, then default values are used:
  ##    kSecAttrIsPermanent if an import keychain is specified
  ##    kSecAttrIsSensitive for non-public keys
  ##    kSecAttrIsExtractable
  ##
  ##  If the kSecAttrIsPermanent attribute is set, then the
  ##  importKeychain argument must be valid or errSecInvalidKeychain
  ##  will be returned even if keys were able to be imported.
  ##
  ##  Note that if the caller provides a keyAttributes array but
  ##  does not set kSecAttrIsExtractable, this key will never be
  ##  able to be extracted from the keychain in any form, not even
  ##  in wrapped form. kSecAttrIsSensitive indicates that the key
  ##  can only be extracted in wrapped form.
  ##
  ##  When importing SecKeyRefs in one of the wrapped formats
  ##  (kSecFormatWrappedOpenSSL, kSecFormatWrappedSSH,
  ##  kSecFormatWrappedPKCS8), or in PKCS12 format, caller must
  ##  either explicitly specify the passphrase field or set
  ##  the kSecKeySecurePassphrase bit in SecKeyImportExportFlags.
  ##
  ##  If kSecKeySecurePassphrase is selected, caller can optionally
  ##  specify strings for the passphrase panel's title bar and for
  ##  the prompt which appears in the panel via the alertTitle and
  ##  alertPrompt fields in SecItemImportExportKeyParameters.
  ##
  ##  If an explicit passphrase is specified, note that PKCS12
  ##  explicitly requires that passphrases are in Unicode format;
  ##  passing in a CFStringRef as the passphrase is the safest way
  ##  to ensure that this requirement is met (and that the result
  ##  will be compatible with other implementations). If a CFDataRef
  ##  is supplied as the passphrase for a PKCS12 export operation,
  ##  the referent data is assumed to be in UTF8 form and will be
  ##  converted as appropriate.
  ##
  ##  If no key items are being imported, the keyParams argument may be NULL.
  ##
  ##  The SecItemImportExportFlags argument is currently unused; caller should pass
  ##  in 0.
  ##
  proc SecItemImport*(importedData: CFDataRef; fileNameOrExtension: CFStringRef;
                     inputFormat: ptr SecExternalFormat;
                     itemType: ptr SecExternalItemType;
                     flags: SecItemImportExportFlags;
                     keyParams: ptr SecItemImportExportKeyParameters;
                     importKeychain: SecKeychainRef; outItems: ptr CFArrayRef): OSStatus
    ##  optional
    ##  optional, IN/OUT
    ##  optional, IN/OUT
    ##  optional
    ##  optional
    ##  optional
## !
##     @enum Import/Export options
##     @discussion Predefined key constants used when passing dictionary-based arguments to import/export functions.
##     @constant kSecImportExportPassphrase Specifies a passphrase represented by a CFStringRef to be used when exporting to (or importing from) PKCS#12 format.
##      @constant kSecImportExportKeychain On OSX, specifies a keychain represented by a SecKeychainRef to be used as the target when importing from PKCS#12 format.
##      @constant kSecImportExportAccess On OSX, specifies an access represented by a SecAccessRef for the initial access (ACL) of a key imported from PKCS#12 format.
##

var kSecImportExportPassphrase*: CFStringRef

var kSecImportExportKeychain*: CFStringRef

var kSecImportExportAccess*: CFStringRef

## !
##     @enum Import/Export item description
##     @discussion Predefined key constants used to pass back a CFArray with a
##         CFDictionary per item.
##
##     @constant kSecImportItemLabel a CFStringRef representing the item label.
##         This implementation specific identifier cannot be expected to have
##         any format.
##     @constant kSecImportItemKeyID a CFDataRef representing the key id.  Often
##         the SHA-1 digest of the public key.
##     @constant kSecImportItemIdentity a SecIdentityRef representing the identity.
##     @constant kSecImportItemTrust a SecTrustRef set up with all relevant
##         certificates.  Not guaranteed to succesfully evaluate.
##     @constant kSecImportItemCertChain a CFArrayRef holding all relevant
##         certificates for this item's identity
##

var kSecImportItemLabel*: CFStringRef

var kSecImportItemKeyID*: CFStringRef

var kSecImportItemTrust*: CFStringRef

var kSecImportItemCertChain*: CFStringRef

var kSecImportItemIdentity*: CFStringRef

## !
##      @function SecPKCS12Import
##      @abstract Imports the contents of a PKCS12 formatted blob.
##      @param pkcs12_data The PKCS#12 formatted data to be imported.
##      @param options A dictionary containing import options. A
##        kSecImportExportPassphrase entry is required at minimum. Only password-based
##        PKCS12 blobs are currently supported.
##      @param items On return, an array containing a dictionary for every item
##        extracted. Use kSecImportItem constants to access specific elements of
##        these dictionaries. Your code must CFRelease the array when it is no longer
##        needed.
##      @result errSecSuccess in case of success. errSecDecode means either the
##        blob can't be read or it is malformed. errSecAuthFailed means an
##        incorrect password was supplied, or data in the container is damaged.
##

proc SecPKCS12Import*(pkcs12_data: CFDataRef; options: CFDictionaryRef;
                     items: ptr CFArrayRef): OSStatus