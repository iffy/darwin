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
##  oidscrl.h -- Object Identifiers for X509 CRLs and OCSP
##

const
  INTEL_X509V2_CRL_R08* =
    INTEL_SEC_FORMATS
    2
    1
  INTEL_X509V2_CRL_R08_LENGTH* = INTEL_SEC_FORMATS_LENGTH + 2

var
  CSSMOID_X509V2CRLSignedCrlStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLSignedCrlCStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLTbsCertListStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLTbsCertListCStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLVersion*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLIssuerStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLIssuerNameCStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLIssuerNameLDAP*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLThisUpdate*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLNextUpdate*: CSSM_OID ##  CRL Entry (CRL CertList) OIDS
  ##  CRL OIDs
  CSSMOID_X509V1CRLRevokedCertificatesStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLRevokedCertificatesCStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLNumberOfRevokedCertEntries*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLRevokedEntryStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLRevokedEntryCStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLRevokedEntrySerialNumber*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V1CRLRevokedEntryRevocationDate*: CSSM_OID ##  CRL Entry (CRL CertList) Extension OIDs
  ##  CRL OIDs
  CSSMOID_X509V2CRLRevokedEntryAllExtensionsStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLRevokedEntryAllExtensionsCStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLRevokedEntryNumberOfExtensions*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLRevokedEntrySingleExtensionStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLRevokedEntrySingleExtensionCStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLRevokedEntryExtensionId*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLRevokedEntryExtensionCritical*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLRevokedEntryExtensionType*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLRevokedEntryExtensionValue*: CSSM_OID ##  CRL Extension OIDs
  ##  CRL OIDs
  CSSMOID_X509V2CRLAllExtensionsStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLAllExtensionsCStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLNumberOfExtensions*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLSingleExtensionStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLSingleExtensionCStruct*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLExtensionId*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLExtensionCritical*: CSSM_OID ##  CRL OIDs
  CSSMOID_X509V2CRLExtensionType*: CSSM_OID ##  OCSP
  ##  CRL OIDs
  CSSMOID_PKIX_OCSP*: CSSM_OID ##  CRL OIDs
  CSSMOID_PKIX_OCSP_BASIC*: CSSM_OID ##  CRL OIDs
  CSSMOID_PKIX_OCSP_NONCE*: CSSM_OID ##  CRL OIDs
  CSSMOID_PKIX_OCSP_CRL*: CSSM_OID ##  CRL OIDs
  CSSMOID_PKIX_OCSP_RESPONSE*: CSSM_OID ##  CRL OIDs
  CSSMOID_PKIX_OCSP_NOCHECK*: CSSM_OID ##  CRL OIDs
  CSSMOID_PKIX_OCSP_ARCHIVE_CUTOFF*: CSSM_OID ##  CRL OIDs
  CSSMOID_PKIX_OCSP_SERVICE_LOCATOR*: CSSM_OID ##  CRL OIDs
