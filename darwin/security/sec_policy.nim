##
##  Copyright (c) 2002-2016 Apple Inc. All Rights Reserved.
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
##      @header SecPolicy
##      The functions provided in SecPolicy.h provide an interface to various
##      X.509 certificate trust policies.
##

## !
##      @enum Policy Constants
##      @discussion Predefined constants used to specify a policy.
##      @constant kSecPolicyAppleX509Basic
##      @constant kSecPolicyAppleSSL
##      @constant kSecPolicyAppleSMIME
##      @constant kSecPolicyAppleEAP
##      @constant kSecPolicyAppleiChat
##      @constant kSecPolicyAppleIPsec
##      @constant kSecPolicyApplePKINITClient
##      @constant kSecPolicyApplePKINITServer
##      @constant kSecPolicyAppleCodeSigning
##      @constant kSecPolicyMacAppStoreReceipt
##      @constant kSecPolicyAppleIDValidation
##      @constant kSecPolicyAppleTimeStamping
##      @constant kSecPolicyAppleRevocation
##      @constant kSecPolicyApplePassbookSigning
##      @constant kSecPolicyApplePayIssuerEncryption
##

var kSecPolicyAppleX509Basic*: CFStringRef

var kSecPolicyAppleSSL*: CFStringRef

var kSecPolicyAppleSMIME*: CFStringRef

var kSecPolicyAppleEAP*: CFStringRef

var kSecPolicyAppleIPsec*: CFStringRef

when TARGET_OS_OSX:
  var kSecPolicyAppleiChat*: CFStringRef
var kSecPolicyApplePKINITClient*: CFStringRef

var kSecPolicyApplePKINITServer*: CFStringRef

var kSecPolicyAppleCodeSigning*: CFStringRef

var kSecPolicyMacAppStoreReceipt*: CFStringRef

var kSecPolicyAppleIDValidation*: CFStringRef

var kSecPolicyAppleTimeStamping*: CFStringRef

var kSecPolicyAppleRevocation*: CFStringRef

var kSecPolicyApplePassbookSigning*: CFStringRef

var kSecPolicyApplePayIssuerEncryption*: CFStringRef

## !
##     @enum Policy Value Constants
##     @abstract Predefined property key constants used to get or set values in
##     a dictionary for a policy instance.
##     @discussion
##         All policies will have the following read-only value:
##             kSecPolicyOid       (the policy object identifier)
##
##         Additional policy values which your code can optionally set:
##             kSecPolicyName      (name which must be matched)
##             kSecPolicyClient    (evaluate for client, rather than server)
##             kSecPolicyRevocationFlags   (only valid for a revocation policy)
##             kSecPolicyTeamIdentifier    (only valid for a Passbook signing policy)
##
##     @constant kSecPolicyOid Specifies the policy OID (value is a CFStringRef)
##     @constant kSecPolicyName Specifies a CFStringRef (or CFArrayRef of same)
##         containing a name which must be matched in the certificate to satisfy
##         this policy. For SSL/TLS, EAP, and IPSec policies, this specifies the
##         server name which must match the common name of the certificate.
##         For S/MIME, this specifies the RFC822 email address. For Passbook
##         signing, this specifies the pass signer.
##     @constant kSecPolicyClient Specifies a CFBooleanRef value that indicates
##         this evaluation should be for a client certificate. If not set (or
##         false), the policy evaluates the certificate as a server certificate.
##     @constant kSecPolicyRevocationFlags Specifies a CFNumberRef that holds a
##         kCFNumberCFIndexType bitmask value. See "Revocation Policy Constants"
##         for a description of individual bits in this value.
##     @constant kSecPolicyTeamIdentifier Specifies a CFStringRef containing a
##         team identifier which must be matched in the certificate to satisfy
##         this policy. For the Passbook signing policy, this string must match
##         the Organizational Unit field of the certificate subject.
##

var kSecPolicyOid*: CFStringRef

var kSecPolicyName*: CFStringRef

var kSecPolicyClient*: CFStringRef

var kSecPolicyRevocationFlags*: CFStringRef

var kSecPolicyTeamIdentifier*: CFStringRef

## !
##  @function SecPolicyGetTypeID
##  @abstract Returns the type identifier of SecPolicy instances.
##  @result The CFTypeID of SecPolicy instances.
##

proc SecPolicyGetTypeID*(): CFTypeID
## !
##  @function SecPolicyCopyProperties
##  @abstract Returns a dictionary of this policy's properties.
##  @param policyRef A policy reference.
##  @result A properties dictionary. See "Policy Value Constants" for a list
##  of currently defined property keys. It is the caller's responsibility to
##  CFRelease this reference when it is no longer needed.
##  @result A result code. See "Security Error Codes" (SecBase.h).
##  @discussion This function returns the properties for a policy, as set by the
##  policy's construction function or by a prior call to SecPolicySetProperties.
##

proc SecPolicyCopyProperties*(policyRef: SecPolicyRef): CFDictionaryRef
## !
##  @function SecPolicyCreateBasicX509
##  @abstract Returns a policy object for the default X.509 policy.
##  @result A policy object. The caller is responsible for calling CFRelease
##  on this when it is no longer needed.
##

proc SecPolicyCreateBasicX509*(): SecPolicyRef
## !
##  @function SecPolicyCreateSSL
##  @abstract Returns a policy object for evaluating SSL certificate chains.
##  @param server Passing true for this parameter creates a policy for SSL
##  server certificates.
##  @param hostname (Optional) If present, the policy will require the specified
##  hostname to match the hostname in the leaf certificate.
##  @result A policy object. The caller is responsible for calling CFRelease
##  on this when it is no longer needed.
##

proc SecPolicyCreateSSL*(server: Boolean; hostname: CFStringRef): SecPolicyRef
## !
##      @enum Revocation Policy Constants
##      @abstract Predefined constants which allow you to specify how revocation
##      checking will be performed for a trust evaluation.
##      @constant kSecRevocationOCSPMethod If this flag is set, perform revocation
##      checking using OCSP (Online Certificate Status Protocol).
##      @constant kSecRevocationCRLMethod If this flag is set, perform revocation
##      checking using the CRL (Certificate Revocation List) method.
##      @constant kSecRevocationPreferCRL If this flag is set, then CRL revocation
##      checking will be preferred over OCSP (by default, OCSP is preferred.)
##      Note that this flag only matters if both revocation methods are specified.
##      @constant kSecRevocationRequirePositiveResponse If this flag is set, then
##      the policy will fail unless a verified positive response is obtained. If
##      the flag is not set, revocation checking is done on a "best attempt" basis,
##      where failure to reach the server is not considered fatal.
##      @constant kSecRevocationNetworkAccessDisabled If this flag is set, then
##      no network access is performed; only locally cached replies are consulted.
##      This constant disallows network access for both revocation checks and
##      intermediate CA issuer fetching.
##      @constant kSecRevocationUseAnyAvailableMethod Specifies that either
##      OCSP or CRL may be used, depending on the method(s) specified in the
##      certificate and the value of kSecRevocationPreferCRL.
##

const
  kSecRevocationOCSPMethod* = (1 shl 0)
  kSecRevocationCRLMethod* = (1 shl 1)
  kSecRevocationPreferCRL* = (1 shl 2)
  kSecRevocationRequirePositiveResponse* = (1 shl 3)
  kSecRevocationNetworkAccessDisabled* = (1 shl 4)
  kSecRevocationUseAnyAvailableMethod* = (
    kSecRevocationOCSPMethod or kSecRevocationCRLMethod)

## !
##      @function SecPolicyCreateRevocation
##      @abstract Returns a policy object for checking revocation of certificates.
##      @result A policy object. The caller is responsible for calling CFRelease
##      on this when it is no longer needed.
##      @param revocationFlags Flags to specify revocation checking options.
##      @discussion Use this function to create a revocation policy with behavior
##      specified by revocationFlags. See the "Revocation Policy Constants" section
##      for a description of these flags. Note: it is usually not necessary to
##      create a revocation policy yourself unless you wish to override default
##      system behavior (e.g. to force a particular method, or to disable
##      revocation checking entirely.)
##

proc SecPolicyCreateRevocation*(revocationFlags: CFOptionFlags): SecPolicyRef
## !
##      @function SecPolicyCreateWithProperties
##      @abstract Returns a policy object based on an object identifier for the
##      policy type. See the "Policy Constants" section for a list of defined
##      policy object identifiers.
##      @param policyIdentifier The identifier for the desired policy type.
##      @param properties (Optional) A properties dictionary. See "Policy Value
##      Constants" for a list of currently defined property keys.
##      @result The returned policy reference, or NULL if the policy could not be
##      created.
##

proc SecPolicyCreateWithProperties*(policyIdentifier: CFTypeRef;
                                   properties: CFDictionaryRef): SecPolicyRef
##
##   Legacy functions (OS X only)
##

when TARGET_OS_OSX:
  ## !
  ##     @enum Policy Value Constants (OS X)
  ##     @discussion Predefined property key constants used to get or set values in
  ##         a dictionary for a policy instance.
  ##
  ##         Some policy values may specify CFBooleanRef key usage constraints:
  ##             kSecPolicyKU_DigitalSignature
  ##             kSecPolicyKU_NonRepudiation
  ##             kSecPolicyKU_KeyEncipherment
  ##             kSecPolicyKU_DataEncipherment
  ##             kSecPolicyKU_KeyAgreement
  ##             kSecPolicyKU_KeyCertSign
  ##             kSecPolicyKU_CRLSign
  ##             kSecPolicyKU_EncipherOnly
  ##             kSecPolicyKU_DecipherOnly
  ##
  ##         kSecPolicyKU policy values define certificate-level key purposes,
  ##         in contrast to the key-level definitions in SecItem.h
  ##
  ##         For example, a key in a certificate might be acceptable to use for
  ##         signing a CRL, but not for signing another certificate. In either
  ##         case, this key would have the ability to sign (i.e. kSecAttrCanSign
  ##         is true), but may only sign for specific purposes allowed by these
  ##         policy constants. Similarly, a public key might have the capability
  ##         to perform encryption or decryption, but the certificate in which it
  ##         resides might have a decipher-only certificate policy.
  ##
  ##         These constants correspond to values defined in RFC 5280, section
  ##         4.2.1.3 (Key Usage) which define the purpose of a key contained in a
  ##         certificate, in contrast to section 4.1.2.7 which define the uses that
  ##         a key is capable of.
  ##
  ##         Note: these constants are not available on iOS. Your code should
  ##         avoid direct reliance on these values for making policy decisions
  ##         and use higher level policies where possible.
  ##
  ##     @constant kSecPolicyKU_DigitalSignature Specifies that the certificate must
  ##         have a key usage that allows it to be used for signing.
  ##     @constant kSecPolicyKU_NonRepudiation Specifies that the certificate must
  ##         have a key usage that allows it to be used for non-repudiation.
  ##     @constant kSecPolicyKU_KeyEncipherment Specifies that the certificate must
  ##         have a key usage that allows it to be used for key encipherment.
  ##     @constant kSecPolicyKU_DataEncipherment Specifies that the certificate must
  ##         have a key usage that allows it to be used for data encipherment.
  ##     @constant kSecPolicyKU_KeyAgreement Specifies that the certificate must
  ##         have a key usage that allows it to be used for key agreement.
  ##     @constant kSecPolicyKU_KeyCertSign Specifies that the certificate must
  ##         have a key usage that allows it to be used for signing certificates.
  ##     @constant kSecPolicyKU_CRLSign Specifies that the certificate must
  ##         have a key usage that allows it to be used for signing CRLs.
  ##     @constant kSecPolicyKU_EncipherOnly Specifies that the certificate must
  ##         have a key usage that permits it to be used for encryption only.
  ##     @constant kSecPolicyKU_DecipherOnly Specifies that the certificate must
  ##         have a key usage that permits it to be used for decryption only.
  ##
  var kSecPolicyKU_DigitalSignature*: CFStringRef
  var kSecPolicyKU_NonRepudiation*: CFStringRef
  var kSecPolicyKU_KeyEncipherment*: CFStringRef
  var kSecPolicyKU_DataEncipherment*: CFStringRef
  var kSecPolicyKU_KeyAgreement*: CFStringRef
  var kSecPolicyKU_KeyCertSign*: CFStringRef
  var kSecPolicyKU_CRLSign*: CFStringRef
  var kSecPolicyKU_EncipherOnly*: CFStringRef
  var kSecPolicyKU_DecipherOnly*: CFStringRef
  ## !
  ##      @function SecPolicyCreateWithOID
  ##      @abstract Returns a policy object based on an object identifier for the
  ##      policy type. See the "Policy Constants" section for a list of defined
  ##      policy object identifiers.
  ##      @param policyOID The OID of the desired policy.
  ##      @result The returned policy reference, or NULL if the policy could not be
  ##      created.
  ##      @discussion This function is deprecated in Mac OS X 10.9 and later;
  ##      use SecPolicyCreateWithProperties (or a more specific policy creation
  ##      function) instead.
  ##
  proc SecPolicyCreateWithOID*(policyOID: CFTypeRef): SecPolicyRef
  ## !
  ##      @function SecPolicyGetOID
  ##      @abstract Returns a policy's object identifier.
  ##      @param policyRef A policy reference.
  ##      @param oid On return, a pointer to the policy's object identifier.
  ##      @result A result code. See "Security Error Codes" (SecBase.h).
  ##      @discussion This function is deprecated in Mac OS X 10.7 and later;
  ##      use SecPolicyCopyProperties instead.
  ##
  proc SecPolicyGetOID*(policyRef: SecPolicyRef; oid: ptr CSSM_OID): OSStatus
  ## !
  ##      @function SecPolicyGetValue
  ##      @abstract Returns a policy's value.
  ##      @param policyRef A policy reference.
  ##      @param value On return, a pointer to the policy's value.
  ##      @result A result code. See "Security Error Codes" (SecBase.h).
  ##      @discussion This function is deprecated in Mac OS X 10.7 and later;
  ##      use SecPolicyCopyProperties instead.
  ##
  proc SecPolicyGetValue*(policyRef: SecPolicyRef; value: ptr CSSM_DATA): OSStatus
  ## !
  ##      @function SecPolicySetValue
  ##      @abstract Sets a policy's value.
  ##      @param policyRef A policy reference.
  ##      @param value The value to be set into the policy object, replacing any
  ##      previous value.
  ##      @result A result code. See "Security Error Codes" (SecBase.h).
  ##      @discussion This function is deprecated in Mac OS X 10.7 and later. Policy
  ##      instances should be considered read-only; in cases where your code would
  ##      consider changing properties of a policy, it should instead create a new
  ##      policy instance with the desired properties.
  ##
  proc SecPolicySetValue*(policyRef: SecPolicyRef; value: ptr CSSM_DATA): OSStatus
  ## !
  ##      @function SecPolicySetProperties
  ##      @abstract Sets a policy's properties.
  ##      @param policyRef A policy reference.
  ##      @param properties A properties dictionary. See "Policy Value Constants"
  ##      for a list of currently defined property keys. This dictionary replaces the
  ##      policy's existing properties, if any. Note that the policy OID (specified
  ##      by kSecPolicyOid) is a read-only property of the policy and cannot be set.
  ##      @result A result code. See "Security Error Codes" (SecBase.h).
  ##      @discussion This function is deprecated in Mac OS X 10.9 and later. Policy
  ##      instances should be considered read-only; in cases where your code would
  ##      consider changing properties of a policy, it should instead create a new
  ##      policy instance with the desired properties.
  ##
  proc SecPolicySetProperties*(policyRef: SecPolicyRef; properties: CFDictionaryRef): OSStatus
  ## !
  ##      @function SecPolicyGetTPHandle
  ##      @abstract Returns the CSSM trust policy handle for the given policy.
  ##      @param policyRef A policy reference.
  ##      @param tpHandle On return, a pointer to a value of type CSSM_TP_HANDLE.
  ##      @result A result code. See "Security Error Codes" (SecBase.h).
  ##      @discussion This function is deprecated in Mac OS X 10.7 and later.
  ##
  proc SecPolicyGetTPHandle*(policyRef: SecPolicyRef; tpHandle: ptr CSSM_TP_HANDLE): OSStatus