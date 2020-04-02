##
##  Copyright (c) 2002-2012 Apple Inc. All Rights Reserved.
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
## 	@header SecCertificateOIDs
## 	These constants are used to access entries in the dictionary returned by
## 	SecCertificateCopyValues, which are the parsed field from a certificate.
##

var kSecOIDADC_CERT_POLICY*: CFStringRef

var kSecOIDAPPLE_CERT_POLICY*: CFStringRef

var kSecOIDAPPLE_EKU_CODE_SIGNING*: CFStringRef

var kSecOIDAPPLE_EKU_CODE_SIGNING_DEV*: CFStringRef

var kSecOIDAPPLE_EKU_ICHAT_ENCRYPTION*: CFStringRef

var kSecOIDAPPLE_EKU_ICHAT_SIGNING*: CFStringRef

var kSecOIDAPPLE_EKU_RESOURCE_SIGNING*: CFStringRef

var kSecOIDAPPLE_EKU_SYSTEM_IDENTITY*: CFStringRef

var kSecOIDAPPLE_EXTENSION*: CFStringRef

var kSecOIDAPPLE_EXTENSION_ADC_APPLE_SIGNING*: CFStringRef

var kSecOIDAPPLE_EXTENSION_ADC_DEV_SIGNING*: CFStringRef

var kSecOIDAPPLE_EXTENSION_APPLE_SIGNING*: CFStringRef

var kSecOIDAPPLE_EXTENSION_CODE_SIGNING*: CFStringRef

var kSecOIDAPPLE_EXTENSION_INTERMEDIATE_MARKER*: CFStringRef

var kSecOIDAPPLE_EXTENSION_WWDR_INTERMEDIATE*: CFStringRef

var kSecOIDAPPLE_EXTENSION_ITMS_INTERMEDIATE*: CFStringRef

var kSecOIDAPPLE_EXTENSION_AAI_INTERMEDIATE*: CFStringRef

var kSecOIDAPPLE_EXTENSION_APPLEID_INTERMEDIATE*: CFStringRef

var kSecOIDAuthorityInfoAccess*: CFStringRef

var kSecOIDAuthorityKeyIdentifier*: CFStringRef

var kSecOIDBasicConstraints*: CFStringRef

var kSecOIDBiometricInfo*: CFStringRef

var kSecOIDCSSMKeyStruct*: CFStringRef

var kSecOIDCertIssuer*: CFStringRef

var kSecOIDCertificatePolicies*: CFStringRef

var kSecOIDClientAuth*: CFStringRef

var kSecOIDCollectiveStateProvinceName*: CFStringRef

var kSecOIDCollectiveStreetAddress*: CFStringRef

var kSecOIDCommonName*: CFStringRef

var kSecOIDCountryName*: CFStringRef

var kSecOIDCrlDistributionPoints*: CFStringRef

var kSecOIDCrlNumber*: CFStringRef

var kSecOIDCrlReason*: CFStringRef

var kSecOIDDOTMAC_CERT_EMAIL_ENCRYPT*: CFStringRef

var kSecOIDDOTMAC_CERT_EMAIL_SIGN*: CFStringRef

var kSecOIDDOTMAC_CERT_EXTENSION*: CFStringRef

var kSecOIDDOTMAC_CERT_IDENTITY*: CFStringRef

var kSecOIDDOTMAC_CERT_POLICY*: CFStringRef

var kSecOIDDeltaCrlIndicator*: CFStringRef

var kSecOIDDescription*: CFStringRef

var kSecOIDEKU_IPSec*: CFStringRef

var kSecOIDEmailAddress*: CFStringRef

var kSecOIDEmailProtection*: CFStringRef

var kSecOIDExtendedKeyUsage*: CFStringRef

var kSecOIDExtendedKeyUsageAny*: CFStringRef

var kSecOIDExtendedUseCodeSigning*: CFStringRef

var kSecOIDGivenName*: CFStringRef

var kSecOIDHoldInstructionCode*: CFStringRef

var kSecOIDInvalidityDate*: CFStringRef

var kSecOIDIssuerAltName*: CFStringRef

var kSecOIDIssuingDistributionPoint*: CFStringRef

var kSecOIDIssuingDistributionPoints*: CFStringRef

var kSecOIDKERBv5_PKINIT_KP_CLIENT_AUTH*: CFStringRef

var kSecOIDKERBv5_PKINIT_KP_KDC*: CFStringRef

var kSecOIDKeyUsage*: CFStringRef

var kSecOIDLocalityName*: CFStringRef

var kSecOIDMS_NTPrincipalName*: CFStringRef

var kSecOIDMicrosoftSGC*: CFStringRef

var kSecOIDNameConstraints*: CFStringRef

var kSecOIDNetscapeCertSequence*: CFStringRef

var kSecOIDNetscapeCertType*: CFStringRef

var kSecOIDNetscapeSGC*: CFStringRef

var kSecOIDOCSPSigning*: CFStringRef

var kSecOIDOrganizationName*: CFStringRef

var kSecOIDOrganizationalUnitName*: CFStringRef

var kSecOIDPolicyConstraints*: CFStringRef

var kSecOIDPolicyMappings*: CFStringRef

var kSecOIDPrivateKeyUsagePeriod*: CFStringRef

var kSecOIDQC_Statements*: CFStringRef

var kSecOIDSerialNumber*: CFStringRef

var kSecOIDServerAuth*: CFStringRef

var kSecOIDStateProvinceName*: CFStringRef

var kSecOIDStreetAddress*: CFStringRef

var kSecOIDSubjectAltName*: CFStringRef

var kSecOIDSubjectDirectoryAttributes*: CFStringRef

var kSecOIDSubjectEmailAddress*: CFStringRef

var kSecOIDSubjectInfoAccess*: CFStringRef

var kSecOIDSubjectKeyIdentifier*: CFStringRef

var kSecOIDSubjectPicture*: CFStringRef

var kSecOIDSubjectSignatureBitmap*: CFStringRef

var kSecOIDSurname*: CFStringRef

var kSecOIDTimeStamping*: CFStringRef

var kSecOIDTitle*: CFStringRef

var kSecOIDUseExemptions*: CFStringRef

var kSecOIDX509V1CertificateIssuerUniqueId*: CFStringRef

var kSecOIDX509V1CertificateSubjectUniqueId*: CFStringRef

var kSecOIDX509V1IssuerName*: CFStringRef

var kSecOIDX509V1IssuerNameCStruct*: CFStringRef

var kSecOIDX509V1IssuerNameLDAP*: CFStringRef

var kSecOIDX509V1IssuerNameStd*: CFStringRef

var kSecOIDX509V1SerialNumber*: CFStringRef

var kSecOIDX509V1Signature*: CFStringRef

var kSecOIDX509V1SignatureAlgorithm*: CFStringRef

var kSecOIDX509V1SignatureAlgorithmParameters*: CFStringRef

var kSecOIDX509V1SignatureAlgorithmTBS*: CFStringRef

var kSecOIDX509V1SignatureCStruct*: CFStringRef

var kSecOIDX509V1SignatureStruct*: CFStringRef

var kSecOIDX509V1SubjectName*: CFStringRef

var kSecOIDX509V1SubjectNameCStruct*: CFStringRef

var kSecOIDX509V1SubjectNameLDAP*: CFStringRef

var kSecOIDX509V1SubjectNameStd*: CFStringRef

var kSecOIDX509V1SubjectPublicKey*: CFStringRef

var kSecOIDX509V1SubjectPublicKeyAlgorithm*: CFStringRef

var kSecOIDX509V1SubjectPublicKeyAlgorithmParameters*: CFStringRef

var kSecOIDX509V1SubjectPublicKeyCStruct*: CFStringRef

var kSecOIDX509V1ValidityNotAfter*: CFStringRef

var kSecOIDX509V1ValidityNotBefore*: CFStringRef

var kSecOIDX509V1Version*: CFStringRef

var kSecOIDX509V3Certificate*: CFStringRef

var kSecOIDX509V3CertificateCStruct*: CFStringRef

var kSecOIDX509V3CertificateExtensionCStruct*: CFStringRef

var kSecOIDX509V3CertificateExtensionCritical*: CFStringRef

var kSecOIDX509V3CertificateExtensionId*: CFStringRef

var kSecOIDX509V3CertificateExtensionStruct*: CFStringRef

var kSecOIDX509V3CertificateExtensionType*: CFStringRef

var kSecOIDX509V3CertificateExtensionValue*: CFStringRef

var kSecOIDX509V3CertificateExtensionsCStruct*: CFStringRef

var kSecOIDX509V3CertificateExtensionsStruct*: CFStringRef

var kSecOIDX509V3CertificateNumberOfExtensions*: CFStringRef

var kSecOIDX509V3SignedCertificate*: CFStringRef

var kSecOIDX509V3SignedCertificateCStruct*: CFStringRef

var kSecOIDSRVName*: CFStringRef
