##
##  Copyright (c) 1999-2001,2003-2004,2008,2010,2012 Apple Inc. All Rights Reserved.
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
##  oidsattr.h -- Cert/CRL related OIDs.
##

##
##  Directory name component identifiers.
##

var
  CSSMOID_ObjectClass*: SecAsn1Oid
  CSSMOID_AliasedEntryName*: SecAsn1Oid
  CSSMOID_KnowledgeInformation*: SecAsn1Oid
  CSSMOID_CommonName*: SecAsn1Oid
  CSSMOID_Surname*: SecAsn1Oid
  CSSMOID_SerialNumber*: SecAsn1Oid
  CSSMOID_CountryName*: SecAsn1Oid
  CSSMOID_LocalityName*: SecAsn1Oid
  CSSMOID_StateProvinceName*: SecAsn1Oid
  CSSMOID_CollectiveStateProvinceName*: SecAsn1Oid
  CSSMOID_StreetAddress*: SecAsn1Oid
  CSSMOID_CollectiveStreetAddress*: SecAsn1Oid
  CSSMOID_OrganizationName*: SecAsn1Oid
  CSSMOID_CollectiveOrganizationName*: SecAsn1Oid
  CSSMOID_OrganizationalUnitName*: SecAsn1Oid
  CSSMOID_CollectiveOrganizationalUnitName*: SecAsn1Oid
  CSSMOID_Title*: SecAsn1Oid
  CSSMOID_Description*: SecAsn1Oid
  CSSMOID_SearchGuide*: SecAsn1Oid
  CSSMOID_BusinessCategory*: SecAsn1Oid
  CSSMOID_PostalAddress*: SecAsn1Oid
  CSSMOID_CollectivePostalAddress*: SecAsn1Oid
  CSSMOID_PostalCode*: SecAsn1Oid
  CSSMOID_CollectivePostalCode*: SecAsn1Oid
  CSSMOID_PostOfficeBox*: SecAsn1Oid
  CSSMOID_CollectivePostOfficeBox*: SecAsn1Oid
  CSSMOID_PhysicalDeliveryOfficeName*: SecAsn1Oid
  CSSMOID_CollectivePhysicalDeliveryOfficeName*: SecAsn1Oid
  CSSMOID_TelephoneNumber*: SecAsn1Oid
  CSSMOID_CollectiveTelephoneNumber*: SecAsn1Oid
  CSSMOID_TelexNumber*: SecAsn1Oid
  CSSMOID_CollectiveTelexNumber*: SecAsn1Oid
  CSSMOID_TelexTerminalIdentifier*: SecAsn1Oid
  CSSMOID_CollectiveTelexTerminalIdentifier*: SecAsn1Oid
  CSSMOID_FacsimileTelephoneNumber*: SecAsn1Oid
  CSSMOID_CollectiveFacsimileTelephoneNumber*: SecAsn1Oid
  CSSMOID_X_121Address*: SecAsn1Oid
  CSSMOID_InternationalISDNNumber*: SecAsn1Oid
  CSSMOID_CollectiveInternationalISDNNumber*: SecAsn1Oid
  CSSMOID_RegisteredAddress*: SecAsn1Oid
  CSSMOID_DestinationIndicator*: SecAsn1Oid
  CSSMOID_PreferredDeliveryMethod*: SecAsn1Oid
  CSSMOID_PresentationAddress*: SecAsn1Oid
  CSSMOID_SupportedApplicationContext*: SecAsn1Oid
  CSSMOID_Member*: SecAsn1Oid
  CSSMOID_Owner*: SecAsn1Oid
  CSSMOID_RoleOccupant*: SecAsn1Oid
  CSSMOID_SeeAlso*: SecAsn1Oid
  CSSMOID_UserPassword*: SecAsn1Oid
  CSSMOID_UserCertificate*: SecAsn1Oid
  CSSMOID_CACertificate*: SecAsn1Oid
  CSSMOID_AuthorityRevocationList*: SecAsn1Oid
  CSSMOID_CertificateRevocationList*: SecAsn1Oid
  CSSMOID_CrossCertificatePair*: SecAsn1Oid
  CSSMOID_Name*: SecAsn1Oid
  CSSMOID_GivenName*: SecAsn1Oid
  CSSMOID_Initials*: SecAsn1Oid
  CSSMOID_GenerationQualifier*: SecAsn1Oid
  CSSMOID_UniqueIdentifier*: SecAsn1Oid
  CSSMOID_DNQualifier*: SecAsn1Oid
  CSSMOID_EnhancedSearchGuide*: SecAsn1Oid
  CSSMOID_ProtocolInformation*: SecAsn1Oid
  CSSMOID_DistinguishedName*: SecAsn1Oid
  CSSMOID_UniqueMember*: SecAsn1Oid
  CSSMOID_HouseIdentifier*: SecAsn1Oid

##  PKCS 9

var
  CSSMOID_EmailAddress*: SecAsn1Oid
  CSSMOID_UnstructuredName*: SecAsn1Oid
  CSSMOID_ContentType*: SecAsn1Oid
  CSSMOID_MessageDigest*: SecAsn1Oid
  CSSMOID_SigningTime*: SecAsn1Oid
  CSSMOID_CounterSignature*: SecAsn1Oid
  CSSMOID_ChallengePassword*: SecAsn1Oid
  CSSMOID_UnstructuredAddress*: SecAsn1Oid
  CSSMOID_ExtendedCertificateAttributes*: SecAsn1Oid

var
  CSSMOID_PKCS9_Id_Ct_TSTInfo*: SecAsn1Oid
  CSSMOID_PKCS9_TimeStampToken*: SecAsn1Oid

##  PKIX

var
  CSSMOID_QT_CPS*: SecAsn1Oid
  CSSMOID_QT_UNOTICE*: SecAsn1Oid
  CSSMOID_AD_OCSP*: SecAsn1Oid
  CSSMOID_AD_CA_ISSUERS*: SecAsn1Oid
  CSSMOID_AD_TIME_STAMPING*: SecAsn1Oid
  CSSMOID_AD_CA_REPOSITORY*: SecAsn1Oid
  CSSMOID_PDA_DATE_OF_BIRTH*: SecAsn1Oid
  CSSMOID_PDA_PLACE_OF_BIRTH*: SecAsn1Oid
  CSSMOID_PDA_GENDER*: SecAsn1Oid
  CSSMOID_PDA_COUNTRY_CITIZEN*: SecAsn1Oid
  CSSMOID_PDA_COUNTRY_RESIDENCE*: SecAsn1Oid
  CSSMOID_OID_QCS_SYNTAX_V1*: SecAsn1Oid
  CSSMOID_OID_QCS_SYNTAX_V2*: SecAsn1Oid

##  ETSI

var
  CSSMOID_ETSI_QCS_QC_COMPLIANCE*: SecAsn1Oid
  CSSMOID_ETSI_QCS_QC_LIMIT_VALUE*: SecAsn1Oid
  CSSMOID_ETSI_QCS_QC_RETENTION*: SecAsn1Oid
  CSSMOID_ETSI_QCS_QC_SSCD*: SecAsn1Oid

##  PKCS7

var
  CSSMOID_PKCS7_Data*: SecAsn1Oid
  CSSMOID_PKCS7_SignedData*: SecAsn1Oid
  CSSMOID_PKCS7_EnvelopedData*: SecAsn1Oid
  CSSMOID_PKCS7_SignedAndEnvelopedData*: SecAsn1Oid
  CSSMOID_PKCS7_DigestedData*: SecAsn1Oid
  CSSMOID_PKCS7_EncryptedData*: SecAsn1Oid
  CSSMOID_PKCS7_DataWithAttributes*: SecAsn1Oid
  CSSMOID_PKCS7_EncryptedPrivateKeyInfo*: SecAsn1Oid ##  PKCS8
  CSSMOID_PKCS9_FriendlyName*: SecAsn1Oid
  CSSMOID_PKCS9_LocalKeyId*: SecAsn1Oid
  CSSMOID_PKCS9_CertTypes*: SecAsn1Oid
  CSSMOID_PKCS9_CrlTypes*: SecAsn1Oid
  CSSMOID_PKCS9_X509Certificate*: SecAsn1Oid
  CSSMOID_PKCS9_SdsiCertificate*: SecAsn1Oid
  CSSMOID_PKCS9_X509Crl*: SecAsn1Oid ##  PKCS12
  CSSMOID_PKCS12_keyBag*: SecAsn1Oid
  CSSMOID_PKCS12_shroudedKeyBag*: SecAsn1Oid
  CSSMOID_PKCS12_certBag*: SecAsn1Oid
  CSSMOID_PKCS12_crlBag*: SecAsn1Oid
  CSSMOID_PKCS12_secretBag*: SecAsn1Oid
  CSSMOID_PKCS12_safeContentsBag*: SecAsn1Oid ##  RFC 2798 (LDAP)
  CSSMOID_UserID*: SecAsn1Oid  ##  RFC 1275 (X.500)
  CSSMOID_DomainComponent*: SecAsn1Oid ##  Kerberos PKINIT CMS ContentInfo types
  CSSMOID_KERBv5_PKINIT_AUTH_DATA*: SecAsn1Oid
  CSSMOID_KERBv5_PKINIT_DH_KEY_DATA*: SecAsn1Oid
  CSSMOID_KERBv5_PKINIT_RKEY_DATA*: SecAsn1Oid

##  Elliptic Curve OIDs from X9.62 and Certicom SEC 2

var
  CSSMOID_X9_62*: SecAsn1Oid
  CSSMOID_X9_62_FieldType*: SecAsn1Oid
  CSSMOID_X9_62_PubKeyType*: SecAsn1Oid
  CSSMOID_X9_62_EllCurve*: SecAsn1Oid
  CSSMOID_X9_62_C_TwoCurve*: SecAsn1Oid
  CSSMOID_X9_62_PrimeCurve*: SecAsn1Oid
  CSSMOID_X9_62_SigType*: SecAsn1Oid
  CSSMOID_secp192r1*: SecAsn1Oid
  CSSMOID_secp256r1*: SecAsn1Oid
  CSSMOID_Certicom*: SecAsn1Oid
  CSSMOID_CerticomEllCurve*: SecAsn1Oid
  CSSMOID_secp112r1*: SecAsn1Oid
  CSSMOID_secp112r2*: SecAsn1Oid
  CSSMOID_secp128r1*: SecAsn1Oid
  CSSMOID_secp128r2*: SecAsn1Oid
  CSSMOID_secp160k1*: SecAsn1Oid
  CSSMOID_secp160r1*: SecAsn1Oid
  CSSMOID_secp160r2*: SecAsn1Oid
  CSSMOID_secp192k1*: SecAsn1Oid
  CSSMOID_secp224k1*: SecAsn1Oid
  CSSMOID_secp224r1*: SecAsn1Oid
  CSSMOID_secp256k1*: SecAsn1Oid
  CSSMOID_secp384r1*: SecAsn1Oid
  CSSMOID_secp521r1*: SecAsn1Oid
  CSSMOID_sect113r1*: SecAsn1Oid
  CSSMOID_sect113r2*: SecAsn1Oid
  CSSMOID_sect131r1*: SecAsn1Oid
  CSSMOID_sect131r2*: SecAsn1Oid
  CSSMOID_sect163k1*: SecAsn1Oid
  CSSMOID_sect163r1*: SecAsn1Oid
  CSSMOID_sect163r2*: SecAsn1Oid
  CSSMOID_sect193r1*: SecAsn1Oid
  CSSMOID_sect193r2*: SecAsn1Oid
  CSSMOID_sect233k1*: SecAsn1Oid
  CSSMOID_sect233r1*: SecAsn1Oid
  CSSMOID_sect239k1*: SecAsn1Oid
  CSSMOID_sect283k1*: SecAsn1Oid
  CSSMOID_sect283r1*: SecAsn1Oid
  CSSMOID_sect409k1*: SecAsn1Oid
  CSSMOID_sect409r1*: SecAsn1Oid
  CSSMOID_sect571k1*: SecAsn1Oid
  CSSMOID_sect571r1*: SecAsn1Oid
