##
##  Copyright (c) 2018 Apple Inc. All Rights Reserved.
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

when not defined(SEC_OBJECT_IMPL):
  ## !
  ##  These are os_object compatible and ARC-able wrappers around existing CoreFoundation
  ##  Security types, including: SecTrustRef, SecIdentityRef, and SecCertificateRef. They allow
  ##  clients to use these types in os_object-type APIs and data structures. The underlying
  ##  CoreFoundation types may be extracted and used by clients as needed.
  ##
  SEC_OBJECT_DECL(sec_trust)
  SEC_OBJECT_DECL(sec_identity)
  SEC_OBJECT_DECL(sec_certificate)
## !
##  @enum tls_protocol_version_t enumeration
##  @abstract Enumerations for the set of supported TLS and DTLS protocol versions.
##
##  @constant tls_protocol_version_TLSv10 TLS 1.0 [https://tools.ietf.org/html/rfc4346]
##  @constant tls_protocol_version_TLSv11 TLS 1.1 [https://tools.ietf.org/html/rfc2246]
##  @constant tls_protocol_version_TLSv12 TLS 1.2 [https://tools.ietf.org/html/rfc5246]
##  @constant tls_protocol_version_TLSv13 TLS 1.3 [https://tools.ietf.org/html/rfc8446]
##  @constant tls_protocol_version_DTLSv10 DTLS 1.0 [https://tools.ietf.org/html/rfc4347]
##  @constant tls_protocol_version_DTLSv12 DTLS 1.2 [https://tools.ietf.org/html/rfc6347]
##

type
  tls_protocol_version_t* = uint16_t

const
  tls_protocol_version_TLSv10* = 0x00000301
  tls_protocol_version_TLSv11* = 0x00000302
  tls_protocol_version_TLSv12* = 0x00000303
  tls_protocol_version_TLSv13* = 0x00000304
  tls_protocol_version_DTLSv10* = 0x0000FEFF
  tls_protocol_version_DTLSv12* = 0x0000FEFD

## !
##  @enum tls_ciphersuite_t enumeration
##  @abstract Enumerations for the set of supported TLS and DTLS ciphersuites.
##
##  See https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml#tls-parameters-4
##  for ciphersuite codepoint allocations and reference RFCs.
##
##  @constant tls_ciphersuite_RSA_WITH_3DES_EDE_CBC_SHA
##  @constant tls_ciphersuite_RSA_WITH_AES_128_CBC_SHA
##  @constant tls_ciphersuite_RSA_WITH_AES_256_CBC_SHA
##  @constant tls_ciphersuite_RSA_WITH_AES_128_GCM_SHA256
##  @constant tls_ciphersuite_RSA_WITH_AES_256_GCM_SHA384
##  @constant tls_ciphersuite_RSA_WITH_AES_128_CBC_SHA256
##  @constant tls_ciphersuite_RSA_WITH_AES_256_CBC_SHA256
##  @constant tls_ciphersuite_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA
##  @constant tls_ciphersuite_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
##  @constant tls_ciphersuite_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
##  @constant tls_ciphersuite_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA
##  @constant tls_ciphersuite_ECDHE_RSA_WITH_AES_128_CBC_SHA
##  @constant tls_ciphersuite_ECDHE_RSA_WITH_AES_256_CBC_SHA
##  @constant tls_ciphersuite_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
##  @constant tls_ciphersuite_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
##  @constant tls_ciphersuite_ECDHE_RSA_WITH_AES_128_CBC_SHA256
##  @constant tls_ciphersuite_ECDHE_RSA_WITH_AES_256_CBC_SHA384
##  @constant tls_ciphersuite_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
##  @constant tls_ciphersuite_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
##  @constant tls_ciphersuite_ECDHE_RSA_WITH_AES_128_GCM_SHA256
##  @constant tls_ciphersuite_ECDHE_RSA_WITH_AES_256_GCM_SHA384
##  @constant tls_ciphersuite_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
##  @constant tls_ciphersuite_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
##  @constant tls_ciphersuite_AES_128_GCM_SHA256
##  @constant tls_ciphersuite_AES_256_GCM_SHA384
##  @constant tls_ciphersuite_CHACHA20_POLY1305_SHA256
##

type
  tls_ciphersuite_t* = uint16_t

const
  tls_ciphersuite_RSA_WITH_3DES_EDE_CBC_SHA* = 0x0000000A
  tls_ciphersuite_RSA_WITH_AES_128_CBC_SHA* = 0x0000002F
  tls_ciphersuite_RSA_WITH_AES_256_CBC_SHA* = 0x00000035
  tls_ciphersuite_RSA_WITH_AES_128_GCM_SHA256* = 0x0000009C
  tls_ciphersuite_RSA_WITH_AES_256_GCM_SHA384* = 0x0000009D
  tls_ciphersuite_RSA_WITH_AES_128_CBC_SHA256* = 0x0000003C
  tls_ciphersuite_RSA_WITH_AES_256_CBC_SHA256* = 0x0000003D
  tls_ciphersuite_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA* = 0x0000C008
  tls_ciphersuite_ECDHE_ECDSA_WITH_AES_128_CBC_SHA* = 0x0000C009
  tls_ciphersuite_ECDHE_ECDSA_WITH_AES_256_CBC_SHA* = 0x0000C00A
  tls_ciphersuite_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA* = 0x0000C012
  tls_ciphersuite_ECDHE_RSA_WITH_AES_128_CBC_SHA* = 0x0000C013
  tls_ciphersuite_ECDHE_RSA_WITH_AES_256_CBC_SHA* = 0x0000C014
  tls_ciphersuite_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256* = 0x0000C023
  tls_ciphersuite_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384* = 0x0000C024
  tls_ciphersuite_ECDHE_RSA_WITH_AES_128_CBC_SHA256* = 0x0000C027
  tls_ciphersuite_ECDHE_RSA_WITH_AES_256_CBC_SHA384* = 0x0000C028
  tls_ciphersuite_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256* = 0x0000C02B
  tls_ciphersuite_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384* = 0x0000C02C
  tls_ciphersuite_ECDHE_RSA_WITH_AES_128_GCM_SHA256* = 0x0000C02F
  tls_ciphersuite_ECDHE_RSA_WITH_AES_256_GCM_SHA384* = 0x0000C030
  tls_ciphersuite_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256* = 0x0000CCA8
  tls_ciphersuite_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256* = 0x0000CCA9
  tls_ciphersuite_AES_128_GCM_SHA256* = 0x00001301
  tls_ciphersuite_AES_256_GCM_SHA384* = 0x00001302
  tls_ciphersuite_CHACHA20_POLY1305_SHA256* = 0x00001303

## !
##  @enum tls_ciphersuite_group_t enumeration
##  @abstract Convenience ciphersuite groups that collate ciphersuites of comparable security
##   properties into a single alias.
##
##  @constant tls_ciphersuite_group_default
##  @constant tls_ciphersuite_group_compatibility
##  @constant tls_ciphersuite_group_legacy
##  @constant tls_ciphersuite_group_ats
##  @constant tls_ciphersuite_group_ats_compatibility
##

type
  tls_ciphersuite_group_t* = uint16_t

const
  tls_ciphersuite_group_default* = 0
  tls_ciphersuite_group_compatibility* = 1
  tls_ciphersuite_group_legacy* = 2
  tls_ciphersuite_group_ats* = 3
  tls_ciphersuite_group_ats_compatibility* = 4

## !
##  @enum SSLProtocol enumeration
##  @abstract Enumerations for the set of supported TLS and DTLS protocol versions.
##
##  @note This enumeration is deprecated. Use `tls_protocol_version_t` instead.
##

type
  SSLProtocol* = cint

const
  kSSLProtocolUnknown* = 0
  kTLSProtocol1* = 4
  kTLSProtocol11* = 7
  kTLSProtocol12* = 8
  kDTLSProtocol1* = 9
  kTLSProtocol13* = 10
  kDTLSProtocol12* = 11
  kTLSProtocolMaxSupported* = 999
  kSSLProtocol2* = 1
  kSSLProtocol3* = 2
  kSSLProtocol3Only* = 3
  kTLSProtocol1Only* = 5
  kSSLProtocolAll* = 6

## !
##  @function sec_trust_create
##
##  @abstract
##       Create an ARC-able `sec_trust_t` instance from a `SecTrustRef`.
##
##  @param trust
##       A `SecTrustRef` instance.
##
##  @return a `sec_trust_t` instance.
##

proc sec_trust_create*(trust: SecTrustRef): sec_trust_t
## !
##  @function sec_trust_copy_ref
##
##  @abstract
##       Copy a retained reference to the underlying `SecTrustRef` instance.
##
##  @param trust
##       A `sec_trust_t` instance.
##
##  @return The underlying `SecTrustRef` instance.
##

proc sec_trust_copy_ref*(trust: sec_trust_t): SecTrustRef
## !
##  @function sec_identity_create
##
##  @abstract
##       Create an ARC-able `sec_identity_t` instance from a `SecIdentityRef`.
##
##  @param identity
##       A `SecIdentityRef` instance.
##
##  @return a `sec_identity_t` instance.
##

proc sec_identity_create*(identity: SecIdentityRef): sec_identity_t
## !
##  @function sec_identity_create_with_certificates
##
##  @abstract
##       Create an ARC-able `sec_identity_t` instance from a `SecIdentityRef` and
##       array of SecCertificateRef instances.
##
##  @param identity
##       A `SecIdentityRef` instance.
##
##  @param certificates
##       An array of `SecCertificateRef` instances.
##
##  @return a `sec_identity_t` instance.
##

proc sec_identity_create_with_certificates*(identity: SecIdentityRef;
    certificates: CFArrayRef): sec_identity_t
## !
##  @function sec_identity_copy_ref
##
##  @abstract
##       Copy a retained reference to the underlying `SecIdentityRef` instance.
##
##  @param identity
##       A `sec_identity_t` instance.
##
##  @return The underlying `SecIdentityRef` instance.
##

proc sec_identity_copy_ref*(identity: sec_identity_t): SecIdentityRef
## !
##  @function sec_identity_copy_certificates_ref
##
##  @abstract
##       Copy a retained reference to the underlying `CFArrayRef` container of `SecCertificateRef` types.
##
##  @param identity
##       A `sec_identity_t` instance.
##
##  @return The underlying `CFArrayRef` container with `SecCertificateRef` instances.
##

proc sec_identity_copy_certificates_ref*(identity: sec_identity_t): CFArrayRef
## !
##  @function sec_certificate_create
##
##  @abstract
##       Create an ARC-able `sec_certificate_t` instance from a `SecCertificateRef`.
##
##  @param certificate
##       A `SecCertificateRef` instance.
##
##  @return a `sec_certificate_t` instance.
##

proc sec_certificate_create*(certificate: SecCertificateRef): sec_certificate_t
## !
##  @function sec_certificate_copy_ref
##
##  @abstract
##       Copy a retained reference to the underlying `SecCertificateRef` instance.
##
##  @param certificate
##       A `sec_certificate_t` instance.
##
##  @return The underlying `SecCertificateRef` instance.
##

proc sec_certificate_copy_ref*(certificate: sec_certificate_t): SecCertificateRef