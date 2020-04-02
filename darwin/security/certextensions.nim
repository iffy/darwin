##
##  Copyright (c) 2000-2009,2011,2012,2014,2016 Apple Inc. All Rights Reserved.
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
##  CertExtensions.h -- X.509 Cert Extensions as C structs
##

when SEC_OS_OSX:
else:
## **
## ** Structs for declaring extension-specific data.
## *
##
##  GeneralName, used in AuthorityKeyID, SubjectAltName, and
##  IssuerAltName.
##
##  For now, we just provide explicit support for the types which are
##  represented as IA5Strings, OIDs, and octet strings. Constructed types
##  such as EDIPartyName and x400Address are not explicitly handled
##  right now and must be encoded and decoded by the caller. (See exception
##  for Name and OtherName, below). In those cases the SecECGeneralName.name.Data / CE_GeneralName.name.Data field
##  represents the BER contents octets; SecCEGeneralName.name.Length / CE_GeneralName.name.Length is the
##  length of the contents; the tag of the field is not needed - the BER
##  encoding uses context-specific implicit tagging. The berEncoded field
##  is set to true / CSSM_TRUE in these case. Simple types have berEncoded = false / CSSM_FALSE.
##
##  In the case of a GeneralName in the form of a Name, we parse the Name
##  into a CSSM_X509_NAME and place a pointer to the CSSM_X509_NAME in the
##  CE_GeneralName.name.Data field. SecCEGeneralName.name.Length / CE_GeneralName.name.Length is set to
##  sizeof(CSSM_X509_NAME). In this case berEncoded is false.
##
##  In the case of a GeneralName in the form of a OtherName, we parse the fields
##  into a CE_OtherName and place a pointer to the SecCEOtherName / CE_OtherName in the
##  SecCEGeneralName.name.Data / CE_GeneralName.name.Data field. SecCEGeneralName.name.Length / CE_GeneralName.name.Length is set to
##  sizeof(SecCEOtherName) / sizeof(CE_OtherName). In this case berEncoded is false.
##
##       GeneralNames ::= SEQUENCE SIZE (1..MAX) OF GeneralName
##
##       GeneralName ::= CHOICE {
##            otherName                       [0]     OtherName
##            rfc822Name                      [1]     IA5String,
##            dNSName                         [2]     IA5String,
##            x400Address                     [3]     ORAddress,
##            directoryName                   [4]     Name,
##            ediPartyName                    [5]     EDIPartyName,
##            uniformResourceIdentifier       [6]     IA5String,
##            iPAddress                       [7]     OCTET STRING,
##            registeredID                    [8]     OBJECT IDENTIFIER}
##
##       OtherName ::= SEQUENCE {
##            type-id    OBJECT IDENTIFIER,
##            value      [0] EXPLICIT ANY DEFINED BY type-id }
##
##       EDIPartyName ::= SEQUENCE {
##            nameAssigner            [0]     DirectoryString OPTIONAL,
##            partyName               [1]     DirectoryString }
##

type
  CE_GeneralNameType* = enum
    GNT_OtherName = 0, GNT_RFC822Name, GNT_DNSName, GNT_X400Address,
    GNT_DirectoryName, GNT_EdiPartyName, GNT_URI, GNT_IPAddress, GNT_RegisteredID


const
  SecCEGeneralNameType* = CE_GeneralNameType

when SEC_OS_OSX:
  type
    CE_OtherName* {.bycopy.} = object
      typeId*: CSSM_OID
      value*: CSSM_DATA        ##  unparsed, BER-encoded

    CE_GeneralName* {.bycopy.} = object
      nameType*: CE_GeneralNameType ##  GNT_RFC822Name, etc.
      berEncoded*: CSSM_BOOL
      name*: CSSM_DATA

    CE_GeneralNames* {.bycopy.} = object
      numNames*: uint32
      generalName*: ptr CE_GeneralName

elif SEC_OS_IPHONE:
  type
    SecCEOtherName* {.bycopy.} = object
      typeId*: DERItem
      value*: DERItem          ##  unparsed, BER-encoded

    SecCEGeneralName* {.bycopy.} = object
      nameType*: SecCEGeneralNameType ##  GNT_RFC822Name, etc.
      berEncoded*: bool
      name*: DERItem

    SecCEGeneralNames* {.bycopy.} = object
      numNames*: uint32_t
      generalName*: ptr SecCEGeneralName

##
##  id-ce-authorityKeyIdentifier OBJECT IDENTIFIER ::=  { id-ce 35 }
##
##    AuthorityKeyIdentifier ::= SEQUENCE {
##      keyIdentifier             [0] KeyIdentifier           OPTIONAL,
##      authorityCertIssuer       [1] GeneralNames            OPTIONAL,
##      authorityCertSerialNumber [2] CertificateSerialNumber OPTIONAL  }
##
##    KeyIdentifier ::= OCTET STRING
##
##  CSSM OID = CSSMOID_AuthorityKeyIdentifier
##

when SEC_OS_OSX:
  type
    CE_AuthorityKeyID* {.bycopy.} = object
      keyIdentifierPresent*: CSSM_BOOL
      keyIdentifier*: CSSM_DATA
      generalNamesPresent*: CSSM_BOOL
      generalNames*: ptr CE_GeneralNames
      serialNumberPresent*: CSSM_BOOL
      serialNumber*: CSSM_DATA

elif SEC_OS_IPHONE:
  type
    SecCEAuthorityKeyID* {.bycopy.} = object
      keyIdentifierPresent*: bool
      keyIdentifier*: DERItem
      generalNamesPresent*: bool
      generalNames*: ptr SecCEGeneralNames
      serialNumberPresent*: bool
      serialNumber*: DERItem

##
##  id-ce-subjectKeyIdentifier OBJECT IDENTIFIER ::=  { id-ce 14 }
##    SubjectKeyIdentifier ::= KeyIdentifier
##
##  CSSM OID = CSSMOID_SubjectKeyIdentifier
##

when SEC_OS_OSX:
  type
    CE_SubjectKeyID* = CSSM_DATA
elif SEC_OS_IPHONE:
  type
    SecCESubjectKeyID* = DERItem
##
##  id-ce-keyUsage OBJECT IDENTIFIER ::=  { id-ce 15 }
##
##      KeyUsage ::= BIT STRING {
##           digitalSignature        (0),
##           nonRepudiation          (1),
##           keyEncipherment         (2),
##           dataEncipherment        (3),
##           keyAgreement            (4),
##           keyCertSign             (5),
##           cRLSign                 (6),
##           encipherOnly            (7),
##           decipherOnly            (8) }
##
##  CSSM OID = CSSMOID_KeyUsage
##
##

when SEC_OS_OSX:
  type
    CE_KeyUsage* = uint16
elif SEC_OS_IPHONE:
  type
    SecCEKeyUsage* = uint16_t
when SEC_OS_OSX:
  const
    CE_KU_DigitalSignature* = 0x00008000
    CE_KU_NonRepudiation* = 0x00004000
    CE_KU_KeyEncipherment* = 0x00002000
    CE_KU_DataEncipherment* = 0x00001000
    CE_KU_KeyAgreement* = 0x00000800
    CE_KU_KeyCertSign* = 0x00000400
    CE_KU_CRLSign* = 0x00000200
    CE_KU_EncipherOnly* = 0x00000100
    CE_KU_DecipherOnly* = 0x00000080
else:
  const
    SecCEKU_DigitalSignature* = 0x00008000
    SecCEKU_NonRepudiation* = 0x00004000
    SecCEKU_KeyEncipherment* = 0x00002000
    SecCEKU_DataEncipherment* = 0x00001000
    SecCEKU_KeyAgreement* = 0x00000800
    SecCEKU_KeyCertSign* = 0x00000400
    SecCEKU_CRLSign* = 0x00000200
    SecCEKU_EncipherOnly* = 0x00000100
    SecCEKU_DecipherOnly* = 0x00000080
##
##   id-ce-cRLReason OBJECT IDENTIFIER ::= { id-ce 21 }
##
##    -- reasonCode ::= { CRLReason }
##
##    CRLReason ::= ENUMERATED {
##   	unspecified             (0),
##       keyCompromise           (1),
##      	cACompromise            (2),
##     	affiliationChanged      (3),
##    	superseded              (4),
##   	cessationOfOperation    (5),
##  		certificateHold         (6),
## 		removeFromCRL           (8) }
##
##  CSSM OID = CSSMOID_CrlReason
##
##

when SEC_OS_OSX:
  type
    CE_CrlReason* = uint32
elif SEC_OS_IPHONE:
  type
    SecCECrlReason* = uint32_t
when SEC_OS_OSX:
  const
    CE_CR_Unspecified* = 0
    CE_CR_KeyCompromise* = 1
    CE_CR_CACompromise* = 2
    CE_CR_AffiliationChanged* = 3
    CE_CR_Superseded* = 4
    CE_CR_CessationOfOperation* = 5
    CE_CR_CertificateHold* = 6
    CE_CR_RemoveFromCRL* = 8
elif SEC_OS_IPHONE:
  const
    SecCECR_Unspecified* = 0
    SecCECR_KeyCompromise* = 1
    SecCECR_CACompromise* = 2
    SecCECR_AffiliationChanged* = 3
    SecCECR_Superseded* = 4
    SecCECR_CessationOfOperation* = 5
    SecCECR_CertificateHold* = 6
    SecCECR_RemoveFromCRL* = 8
##
##  id-ce-subjectAltName OBJECT IDENTIFIER ::=  { id-ce 17 }
##
##       SubjectAltName ::= GeneralNames
##
##  CSSM OID = CSSMOID_SubjectAltName
##
##  GeneralNames defined above.
##
##
##   id-ce-extKeyUsage OBJECT IDENTIFIER ::= {id-ce 37}
##
##    ExtKeyUsageSyntax ::= SEQUENCE SIZE (1..MAX) OF KeyPurposeId*
##
##   KeyPurposeId ::= OBJECT IDENTIFIER
##
##  CSSM OID = CSSMOID_ExtendedKeyUsage
##

when SEC_OS_OSX:
  type
    CE_ExtendedKeyUsage* {.bycopy.} = object
      numPurposes*: uint32
      purposes*: CSSM_OID_PTR  ##  in Intel pre-encoded format

elif SEC_OS_IPHONE:
  type
    SecCEExtendedKeyUsage* {.bycopy.} = object
      numPurposes*: uint32_t
      purposes*: ptr DERItem    ##  in Intel pre-encoded format

##
##  id-ce-basicConstraints OBJECT IDENTIFIER ::=  { id-ce 19 }
##
##  BasicConstraints ::= SEQUENCE {
##        cA                      BOOLEAN DEFAULT FALSE,
##        pathLenConstraint       INTEGER (0..MAX) OPTIONAL }
##
##  CSSM OID = CSSMOID_BasicConstraints
##

when SEC_OS_OSX:
  type
    CE_BasicConstraints* {.bycopy.} = object
      cA*: CSSM_BOOL
      pathLenConstraintPresent*: CSSM_BOOL
      pathLenConstraint*: uint32

elif SEC_OS_IPHONE:
  type
    SecCEBasicConstraints* {.bycopy.} = object
      present*: bool
      critical*: bool
      isCA*: bool
      pathLenConstraintPresent*: bool
      pathLenConstraint*: uint32_t

    SecCEPolicyConstraints* {.bycopy.} = object
      present*: bool
      critical*: bool
      requireExplicitPolicyPresent*: bool
      requireExplicitPolicy*: uint32_t
      inhibitPolicyMappingPresent*: bool
      inhibitPolicyMapping*: uint32_t

##
##  id-ce-certificatePolicies OBJECT IDENTIFIER ::=  { id-ce 32 }
##
##    certificatePolicies ::= SEQUENCE SIZE (1..MAX) OF PolicyInformation
##
##    PolicyInformation ::= SEQUENCE {
##         policyIdentifier   CertPolicyId,
##         policyQualifiers   SEQUENCE SIZE (1..MAX) OF
##                                 PolicyQualifierInfo OPTIONAL }
##
##    CertPolicyId ::= OBJECT IDENTIFIER
##
##    PolicyQualifierInfo ::= SEQUENCE {
##         policyQualifierId  PolicyQualifierId,
##         qualifier          ANY DEFINED BY policyQualifierId }
##
##    -- policyQualifierIds for Internet policy qualifiers
##
##    id-qt          OBJECT IDENTIFIER ::=  { id-pkix 2 }
##    id-qt-cps      OBJECT IDENTIFIER ::=  { id-qt 1 }
##    id-qt-unotice  OBJECT IDENTIFIER ::=  { id-qt 2 }
##
##    PolicyQualifierId ::=
##         OBJECT IDENTIFIER ( id-qt-cps | id-qt-unotice )
##
##    Qualifier ::= CHOICE {
##         cPSuri           CPSuri,
##         userNotice       UserNotice }
##
##    CPSuri ::= IA5String
##
##    UserNotice ::= SEQUENCE {
##         noticeRef        NoticeReference OPTIONAL,
##         explicitText     DisplayText OPTIONAL}
##
##    NoticeReference ::= SEQUENCE {
##         organization     DisplayText,
##         noticeNumbers    SEQUENCE OF INTEGER }
##
##    DisplayText ::= CHOICE {
##         visibleString    VisibleString  (SIZE (1..200)),
##         bmpString        BMPString      (SIZE (1..200)),
##         utf8String       UTF8String     (SIZE (1..200)) }
##
##   CSSM OID = CSSMOID_CertificatePolicies
##
##  We only support down to the level of Qualifier, and then only the CPSuri
##  choice. UserNotice is transmitted to and from this library as a raw
##  CSSM_DATA containing the BER-encoded UserNotice sequence.
##

when SEC_OS_IPHONE:
  when 0:
    type
      SecCEPolicyQualifierInfo* {.bycopy.} = object
        policyQualifierId*: DERItem ##  CSSMOID_QT_CPS, CSSMOID_QT_UNOTICE
        qualifier*: DERItem    ##  CSSMOID_QT_CPS: IA5String contents

  type
    SecCEPolicyInformation* {.bycopy.} = object
      policyIdentifier*: DERItem
      policyQualifiers*: DERItem

    SecCECertificatePolicies* {.bycopy.} = object
      present*: bool
      critical*: bool
      numPolicies*: csize      ##  size of *policies;
      policies*: ptr SecCEPolicyInformation

    SecCEPolicyMapping* {.bycopy.} = object
      issuerDomainPolicy*: DERItem
      subjectDomainPolicy*: DERItem

  ##
  ##    PolicyMappings ::= SEQUENCE SIZE (1..MAX) OF SEQUENCE {
  ##         issuerDomainPolicy      CertPolicyId,
  ##         subjectDomainPolicy     CertPolicyId }
  ##
  type
    SecCEPolicyMappings* {.bycopy.} = object
      present*: bool
      critical*: bool
      numMappings*: csize      ##  size of *mappings;
      mappings*: ptr SecCEPolicyMapping

  ##
  ##      InhibitAnyPolicy ::= SkipCerts
  ##      SkipCerts ::= INTEGER (0..MAX)
  ##
  type
    SecCEInhibitAnyPolicy* {.bycopy.} = object
      present*: bool
      critical*: bool
      skipCerts*: uint32_t

elif SEC_OS_OSX:
  type
    CE_PolicyQualifierInfo* {.bycopy.} = object
      policyQualifierId*: CSSM_OID ##  CSSMOID_QT_CPS, CSSMOID_QT_UNOTICE
      qualifier*: CSSM_DATA    ##  CSSMOID_QT_CPS: IA5String contents
                          ##  CSSMOID_QT_UNOTICE : Sequence contents

    CE_PolicyInformation* {.bycopy.} = object
      certPolicyId*: CSSM_OID
      numPolicyQualifiers*: uint32 ##  size of *policyQualifiers;
      policyQualifiers*: ptr CE_PolicyQualifierInfo

    CE_CertPolicies* {.bycopy.} = object
      numPolicies*: uint32     ##  size of *policies;
      policies*: ptr CE_PolicyInformation

  ##
  ##  netscape-cert-type, a bit string.
  ##
  ##  CSSM OID = CSSMOID_NetscapeCertType
  ##
  ##  Bit fields defined in oidsattr.h: CE_NCT_SSL_Client, etc.
  ##
  type
    CE_NetscapeCertType* = uint16
  ##
  ##  CRLDistributionPoints.
  ##
  ##    id-ce-cRLDistributionPoints OBJECT IDENTIFIER ::=  { id-ce 31 }
  ##
  ##    cRLDistributionPoints ::= {
  ##         CRLDistPointsSyntax }
  ##
  ##    CRLDistPointsSyntax ::= SEQUENCE SIZE (1..MAX) OF DistributionPoint
  ##
  ##    NOTE: RFC 2459 claims that the tag for the optional DistributionPointName
  ##    is IMPLICIT as shown here, but in practice it is EXPLICIT. It has to be -
  ##    because the underlying type also uses an implicit tag for distinguish
  ##    between CHOICEs.
  ##
  ##    DistributionPoint ::= SEQUENCE {
  ##         distributionPoint       [0]     DistributionPointName OPTIONAL,
  ##         reasons                 [1]     ReasonFlags OPTIONAL,
  ##         cRLIssuer               [2]     GeneralNames OPTIONAL }
  ##
  ##    DistributionPointName ::= CHOICE {
  ##         fullName                [0]     GeneralNames,
  ##         nameRelativeToCRLIssuer [1]     RelativeDistinguishedName }
  ##
  ##    ReasonFlags ::= BIT STRING {
  ##         unused                  (0),
  ##         keyCompromise           (1),
  ##         cACompromise            (2),
  ##         affiliationChanged      (3),
  ##         superseded              (4),
  ##         cessationOfOperation    (5),
  ##         certificateHold         (6) }
  ##
  ##  CSSM OID = CSSMOID_CrlDistributionPoints
  ##
  ##
  ##  Note that this looks similar to CE_CrlReason, but that's an enum and this
  ##  is an OR-able bit string.
  ##
  type
    CE_CrlDistReasonFlags* = uint8
  const
    CE_CD_Unspecified* = 0x00000080
    CE_CD_KeyCompromise* = 0x00000040
    CE_CD_CACompromise* = 0x00000020
    CE_CD_AffiliationChanged* = 0x00000010
    CE_CD_Superseded* = 0x00000008
    CE_CD_CessationOfOperation* = 0x00000004
    CE_CD_CertificateHold* = 0x00000002
  type
    INNER_C_UNION_certextensions_538* {.bycopy.} = object {.union.}
      fullName*: ptr CE_GeneralNames
      rdn*: CSSM_X509_RDN_PTR

  type
    CE_CrlDistributionPointNameType* = enum
      CE_CDNT_FullName, CE_CDNT_NameRelativeToCrlIssuer
    CE_DistributionPointName* {.bycopy.} = object
      nameType*: CE_CrlDistributionPointNameType
      dpn*: INNER_C_UNION_certextensions_538

  ##
  ##  The top-level CRLDistributionPoint.
  ##  All fields are optional; NULL pointers indicate absence.
  ##
  type
    CE_CRLDistributionPoint* {.bycopy.} = object
      distPointName*: ptr CE_DistributionPointName
      reasonsPresent*: CSSM_BOOL
      reasons*: CE_CrlDistReasonFlags
      crlIssuer*: ptr CE_GeneralNames

    CE_CRLDistPointsSyntax* {.bycopy.} = object
      numDistPoints*: uint32
      distPoints*: ptr CE_CRLDistributionPoint

  ##
  ##  Authority Information Access and Subject Information Access.
  ##
  ##  CSSM OID = CSSMOID_AuthorityInfoAccess
  ##  CSSM OID = CSSMOID_SubjectInfoAccess
  ##
  ##  SubjAuthInfoAccessSyntax  ::=
  ## 		SEQUENCE SIZE (1..MAX) OF AccessDescription
  ##
  ##  AccessDescription  ::=  SEQUENCE {
  ## 		accessMethod          OBJECT IDENTIFIER,
  ## 		accessLocation        GeneralName  }
  ##
  type
    CE_AccessDescription* {.bycopy.} = object
      accessMethod*: CSSM_OID
      accessLocation*: CE_GeneralName

    CE_AuthorityInfoAccess* {.bycopy.} = object
      numAccessDescriptions*: uint32
      accessDescriptions*: ptr CE_AccessDescription

  ##
  ##  Qualified Certificate Statement support, per RFC 3739.
  ##
  ##  First, NameRegistrationAuthorities, a component of
  ##  SemanticsInformation; it's the same as a GeneralNames -
  ##  a sequence of GeneralName.
  ##
  type
    CE_NameRegistrationAuthorities* = CE_GeneralNames
  ##
  ##  SemanticsInformation, identified as the qcType field
  ##  of a CE_QC_Statement for statementId value id-qcs-pkixQCSyntax-v2.
  ##  Both fields optional; at least one must be present.
  ##
  type
    CE_SemanticsInformation* {.bycopy.} = object
      semanticsIdentifier*: ptr CSSM_OID
      nameRegistrationAuthorities*: ptr CE_NameRegistrationAuthorities

  ##
  ##  One Qualified Certificate Statement.
  ##  The statementId OID is required; zero or one of {semanticsInfo,
  ##  otherInfo} can be valid, depending on the value of statementId.
  ##  For statementId id-qcs-pkixQCSyntax-v2 (CSSMOID_OID_QCS_SYNTAX_V2),
  ##  the semanticsInfo field may be present; otherwise, DER-encoded
  ##  information may be present in otherInfo. Both semanticsInfo and
  ##  otherInfo are optional.
  ##
  type
    CE_QC_Statement* {.bycopy.} = object
      statementId*: CSSM_OID
      semanticsInfo*: ptr CE_SemanticsInformation
      otherInfo*: ptr CSSM_DATA

  ##
  ##  The top-level Qualified Certificate Statements extension.
  ##
  type
    CE_QC_Statements* {.bycopy.} = object
      numQCStatements*: uint32
      qcStatements*: ptr CE_QC_Statement

  ## ** CRL extensions **
  ##
  ##  cRLNumber, an integer.
  ##
  ##  CSSM OID = CSSMOID_CrlNumber
  ##
  type
    CE_CrlNumber* = uint32
  ##
  ##  deltaCRLIndicator, an integer.
  ##
  ##  CSSM OID = CSSMOID_DeltaCrlIndicator
  ##
  type
    CE_DeltaCrl* = uint32
  ##
  ##  IssuingDistributionPoint
  ##
  ##  id-ce-issuingDistributionPoint OBJECT IDENTIFIER ::= { id-ce 28 }
  ##
  ##  issuingDistributionPoint ::= SEQUENCE {
  ##       distributionPoint       [0] DistributionPointName OPTIONAL,
  ## 		onlyContainsUserCerts   [1] BOOLEAN DEFAULT FALSE,
  ##       onlyContainsCACerts     [2] BOOLEAN DEFAULT FALSE,
  ##       onlySomeReasons         [3] ReasonFlags OPTIONAL,
  ##       indirectCRL             [4] BOOLEAN DEFAULT FALSE }
  ##
  ##  CSSM OID = CSSMOID_IssuingDistributionPoint
  ##
  type
    CE_IssuingDistributionPoint* {.bycopy.} = object
      distPointName*: ptr CE_DistributionPointName ##  optional
      onlyUserCertsPresent*: CSSM_BOOL
      onlyUserCerts*: CSSM_BOOL
      onlyCACertsPresent*: CSSM_BOOL
      onlyCACerts*: CSSM_BOOL
      onlySomeReasonsPresent*: CSSM_BOOL
      onlySomeReasons*: CE_CrlDistReasonFlags
      indirectCrlPresent*: CSSM_BOOL
      indirectCrl*: CSSM_BOOL

  ##
  ##  NameConstraints
  ##
  ##  id-ce-nameConstraints OBJECT IDENTIFIER ::=  { id-ce 30 }
  ##
  ##      NameConstraints ::= SEQUENCE {
  ##           permittedSubtrees       [0]     GeneralSubtrees OPTIONAL,
  ##           excludedSubtrees        [1]     GeneralSubtrees OPTIONAL }
  ##
  ##      GeneralSubtrees ::= SEQUENCE SIZE (1..MAX) OF GeneralSubtree
  ##
  ##      GeneralSubtree ::= SEQUENCE {
  ##           base                    GeneralName,
  ##           minimum         [0]     BaseDistance DEFAULT 0,
  ##           maximum         [1]     BaseDistance OPTIONAL }
  ##
  ##      BaseDistance ::= INTEGER (0..MAX)
  ##
  type
    CE_GeneralSubtree* {.bycopy.} = object
      base*: ptr CE_GeneralNames
      minimum*: uint32         ##  default=0
      maximumPresent*: CSSM_BOOL
      maximum*: uint32         ##  optional

    CE_GeneralSubtrees* {.bycopy.} = object
      numSubtrees*: uint32
      subtrees*: ptr CE_GeneralSubtree

    CE_NameConstraints* {.bycopy.} = object
      permitted*: ptr CE_GeneralSubtrees ##  optional
      excluded*: ptr CE_GeneralSubtrees ##  optional

  ##
  ##  PolicyMappings
  ##
  ##  id-ce-policyMappings OBJECT IDENTIFIER ::=  { id-ce 33 }
  ##
  ##      PolicyMappings ::= SEQUENCE SIZE (1..MAX) OF SEQUENCE {
  ##           issuerDomainPolicy      CertPolicyId,
  ##           subjectDomainPolicy     CertPolicyId }
  ##
  ##  Note that both issuer and subject policy OIDs are required,
  ##  and are stored by value in this structure.
  ##
  type
    CE_PolicyMapping* {.bycopy.} = object
      issuerDomainPolicy*: CSSM_OID
      subjectDomainPolicy*: CSSM_OID

    CE_PolicyMappings* {.bycopy.} = object
      numPolicyMappings*: uint32
      policyMappings*: ptr CE_PolicyMapping

  ##
  ##  PolicyConstraints
  ##
  ##  id-ce-policyConstraints OBJECT IDENTIFIER ::=  { id-ce 36 }
  ##
  ##      PolicyConstraints ::= SEQUENCE {
  ##           requireExplicitPolicy   [0]     SkipCerts OPTIONAL,
  ##           inhibitPolicyMapping    [1]     SkipCerts OPTIONAL }
  ##
  ##       SkipCerts ::= INTEGER (0..MAX)
  ##
  type
    CE_PolicyConstraints* {.bycopy.} = object
      requireExplicitPolicyPresent*: CSSM_BOOL
      requireExplicitPolicy*: uint32 ##  optional
      inhibitPolicyMappingPresent*: CSSM_BOOL
      inhibitPolicyMapping*: uint32 ##  optional

  ##
  ##  InhibitAnyPolicy, an integer.
  ##
  ##  CSSM OID = CSSMOID_InhibitAnyPolicy
  ##
  type
    CE_InhibitAnyPolicy* = uint32
  ##
  ##  An enumerated list identifying one of the above per-extension
  ##  structs.
  ##
  type
    CE_DataType* = enum
      DT_AuthorityKeyID,      ##  CE_AuthorityKeyID
      DT_SubjectKeyID,        ##  CE_SubjectKeyID
      DT_KeyUsage,            ##  CE_KeyUsage
      DT_SubjectAltName,      ##  implies CE_GeneralName
      DT_IssuerAltName,       ##  implies CE_GeneralName
      DT_ExtendedKeyUsage,    ##  CE_ExtendedKeyUsage
      DT_BasicConstraints,    ##  CE_BasicConstraints
      DT_CertPolicies,        ##  CE_CertPolicies
      DT_NetscapeCertType,    ##  CE_NetscapeCertType
      DT_CrlNumber,           ##  CE_CrlNumber
      DT_DeltaCrl,            ##  CE_DeltaCrl
      DT_CrlReason,           ##  CE_CrlReason
      DT_CrlDistributionPoints, ##  CE_CRLDistPointsSyntax
      DT_IssuingDistributionPoint, ##  CE_IssuingDistributionPoint
      DT_AuthorityInfoAccess, ##  CE_AuthorityInfoAccess
      DT_Other,               ##  unknown, raw data as a CSSM_DATA
      DT_QC_Statements,       ##  CE_QC_Statements
      DT_NameConstraints,     ##  CE_NameConstraints
      DT_PolicyMappings,      ##  CE_PolicyMappings
      DT_PolicyConstraints,   ##  CE_PolicyConstraints
      DT_InhibitAnyPolicy     ##  CE_InhibitAnyPolicy
  ##
  ##  One unified representation of all the cert and CRL extensions we know about.
  ##
  type
    CE_Data* {.bycopy.} = object {.union.}
      authorityKeyID*: CE_AuthorityKeyID
      subjectKeyID*: CE_SubjectKeyID
      keyUsage*: CE_KeyUsage
      subjectAltName*: CE_GeneralNames
      issuerAltName*: CE_GeneralNames
      extendedKeyUsage*: CE_ExtendedKeyUsage
      basicConstraints*: CE_BasicConstraints
      certPolicies*: CE_CertPolicies
      netscapeCertType*: CE_NetscapeCertType
      crlNumber*: CE_CrlNumber
      deltaCrl*: CE_DeltaCrl
      crlReason*: CE_CrlReason
      crlDistPoints*: CE_CRLDistPointsSyntax
      issuingDistPoint*: CE_IssuingDistributionPoint
      authorityInfoAccess*: CE_AuthorityInfoAccess
      qualifiedCertStatements*: CE_QC_Statements
      nameConstraints*: CE_NameConstraints
      policyMappings*: CE_PolicyMappings
      policyConstraints*: CE_PolicyConstraints
      inhibitAnyPolicy*: CE_InhibitAnyPolicy
      rawData*: CSSM_DATA      ##  unknown, not decoded

    CE_DataAndType* {.bycopy.} = object
      `type`*: CE_DataType
      extension*: CE_Data
      critical*: CSSM_BOOL

when SEC_OS_OSX: