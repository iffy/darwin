##
##  Copyright (c) 2005-2009,2011-2016 Apple Inc. All Rights Reserved.
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
##
##  oids.h - declaration of OID consts
##
##

##  This is a subset of libDER's oids.h. If the types header has
##  already been included, we should skip these typedef declarations.

when not defined(_LIB_DER_H_):
  ##
  ##  Basic data types
  ##
  type
    DERByte* = uint8_t
    DERSize* = csize
  ##
  ##  Primary representation of a block of memory.
  ##
  type
    DERItem* {.bycopy.} = object
      data*: ptr DERByte
      length*: DERSize

##  Algorithm oids.

var
  oidRsa*: DERItem             ##  PKCS1 RSA encryption, used to identify RSA keys
  oidMd2Rsa*: DERItem          ##  PKCS1 md2withRSAEncryption signature alg
  oidMd4Rsa*: DERItem          ##  PKCS1 md4withRSAEncryption signature alg
  oidMd5Rsa*: DERItem          ##  PKCS1 md5withRSAEncryption signature alg
  oidSha1Rsa*: DERItem         ##  PKCS1 sha1withRSAEncryption signature alg
  oidSha256Rsa*: DERItem       ##  PKCS1 sha256WithRSAEncryption signature alg
  oidSha384Rsa*: DERItem       ##  PKCS1 sha384WithRSAEncryption signature alg
  oidSha512Rsa*: DERItem       ##  PKCS1 sha512WithRSAEncryption signature alg
  oidSha224Rsa*: DERItem       ##  PKCS1 sha224WithRSAEncryption signature alg
  oidEcPubKey*: DERItem        ##  ECDH or ECDSA public key in a certificate
  oidSha1Ecdsa*: DERItem       ##  ECDSA with SHA1 signature alg
  oidSha224Ecdsa*: DERItem     ##  ECDSA with SHA224 signature alg
  oidSha256Ecdsa*: DERItem     ##  ECDSA with SHA256 signature alg
  oidSha384Ecdsa*: DERItem     ##  ECDSA with SHA384 signature alg
  oidSha512Ecdsa*: DERItem     ##  ECDSA with SHA512 signature alg
  oidSha1Dsa*: DERItem         ##  ANSI X9.57 DSA with SHA1 signature alg
  oidMd2*: DERItem             ##  OID_RSA_HASH 2
  oidMd4*: DERItem             ##  OID_RSA_HASH 4
  oidMd5*: DERItem             ##  OID_RSA_HASH 5
  oidSha1*: DERItem            ##  OID_OIW_ALGORITHM 26
  oidSha1DsaOIW*: DERItem      ##  OID_OIW_ALGORITHM 27
  oidSha1DsaCommonOIW*: DERItem ##  OID_OIW_ALGORITHM 28
  oidSha1RsaOIW*: DERItem      ##  OID_OIW_ALGORITHM 29
  oidSha256*: DERItem          ##  OID_NIST_HASHALG 1
  oidSha384*: DERItem          ##  OID_NIST_HASHALG 2
  oidSha512*: DERItem          ##  OID_NIST_HASHALG 3
  oidSha224*: DERItem          ##  OID_NIST_HASHALG 4
  oidFee*: DERItem             ##  APPLE_ALG_OID 1
  oidMd5Fee*: DERItem          ##  APPLE_ALG_OID 3
  oidSha1Fee*: DERItem         ##  APPLE_ALG_OID 4
  oidEcPrime192v1*: DERItem    ##  OID_EC_CURVE 1 prime192v1/secp192r1/ansiX9p192r1
  oidEcPrime256v1*: DERItem    ##  OID_EC_CURVE 7 prime256v1/secp256r1
  oidAnsip384r1*: DERItem      ##  OID_CERTICOM_EC_CURVE 34 ansip384r1/secp384r1
  oidAnsip521r1*: DERItem

##  OID_CERTICOM_EC_CURVE 35 ansip521r1/secp521r1
##  Standard X.509 Cert and CRL extensions.

var
  oidSubjectKeyIdentifier*: DERItem
  oidKeyUsage*: DERItem
  oidPrivateKeyUsagePeriod*: DERItem
  oidSubjectAltName*: DERItem
  oidIssuerAltName*: DERItem
  oidBasicConstraints*: DERItem
  oidNameConstraints*: DERItem
  oidCrlDistributionPoints*: DERItem
  oidCertificatePolicies*: DERItem
  oidAnyPolicy*: DERItem
  oidPolicyMappings*: DERItem
  oidAuthorityKeyIdentifier*: DERItem
  oidPolicyConstraints*: DERItem
  oidExtendedKeyUsage*: DERItem
  oidAnyExtendedKeyUsage*: DERItem
  oidInhibitAnyPolicy*: DERItem
  oidAuthorityInfoAccess*: DERItem
  oidSubjectInfoAccess*: DERItem
  oidAdOCSP*: DERItem
  oidAdCAIssuer*: DERItem
  oidNetscapeCertType*: DERItem
  oidEntrustVersInfo*: DERItem
  oidMSNTPrincipalName*: DERItem

##  Policy Qualifier IDs for Internet policy qualifiers.

var
  oidQtCps*: DERItem
  oidQtUNotice*: DERItem

##  X.501 Name IDs.

var
  oidCommonName*: DERItem
  oidCountryName*: DERItem
  oidLocalityName*: DERItem
  oidStateOrProvinceName*: DERItem
  oidOrganizationName*: DERItem
  oidOrganizationalUnitName*: DERItem
  oidDescription*: DERItem
  oidEmailAddress*: DERItem
  oidFriendlyName*: DERItem
  oidLocalKeyId*: DERItem

##  X.509 Extended Key Usages

var
  oidExtendedKeyUsageServerAuth*: DERItem
  oidExtendedKeyUsageClientAuth*: DERItem
  oidExtendedKeyUsageCodeSigning*: DERItem
  oidExtendedKeyUsageEmailProtection*: DERItem
  oidExtendedKeyUsageTimeStamping*: DERItem
  oidExtendedKeyUsageOCSPSigning*: DERItem
  oidExtendedKeyUsageIPSec*: DERItem
  oidExtendedKeyUsageMicrosoftSGC*: DERItem
  oidExtendedKeyUsageNetscapeSGC*: DERItem

##  Google Certificate Transparency OIDs

var
  oidGoogleEmbeddedSignedCertificateTimestamp*: DERItem
  oidGoogleOCSPSignedCertificateTimestamp*: DERItem
