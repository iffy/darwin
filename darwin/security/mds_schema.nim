##
##  Copyright (c) 2000-2001,2011,2014 Apple Inc. All Rights Reserved.
##
##  The contents of this file constitute Original Code as defined in and are
##  subject to the Apple Public Source License Version 1.2 (the 'License').
##  You may not use this file except in compliance with the License. Please obtain
##  a copy of the License at http://www.apple.com/publicsource and read it before
##  using this file.
##
##  This Original Code and all software distributed under the License are
##  distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS
##  OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES, INCLUDING WITHOUT
##  LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
##  PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT. Please see the License for the
##  specific language governing rights and limitations under the License.
##
##
##    File:      mds_schema.h
##
##    Contains:  Module Directory Services Schema for CSSM.
##
##    Copyright (c) 1999-2000,2011,2014 Apple Inc. All Rights Reserved.
##

##  Names of the databases supported by MDS.

const
  MDS_OBJECT_DIRECTORY_NAME* = "MDS Object Directory"
  MDS_CDSA_DIRECTORY_NAME* = "MDS CDSA Directory"

##  MDS predefined values for a 16K name space

const
  CSSM_DB_RELATIONID_MDS_START* = (0x40000000)
  CSSM_DB_RELATIONID_MDS_END* = (0x40004000)
  MDS_OBJECT_RECORDTYPE* = (CSSM_DB_RELATIONID_MDS_START)
  MDS_CDSA_SCHEMA_START* = (MDS_OBJECT_RECORDTYPE)
  MDS_CDSADIR_CSSM_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 1)
  MDS_CDSADIR_KRMM_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 2)
  MDS_CDSADIR_EMM_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 3)
  MDS_CDSADIR_COMMON_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 4)
  MDS_CDSADIR_CSP_PRIMARY_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 5)
  MDS_CDSADIR_CSP_CAPABILITY_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 6)
  MDS_CDSADIR_CSP_ENCAPSULATED_PRODUCT_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 7)
  MDS_CDSADIR_CSP_SC_INFO_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 8)
  MDS_CDSADIR_DL_PRIMARY_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 9)
  MDS_CDSADIR_DL_ENCAPSULATED_PRODUCT_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 10)
  MDS_CDSADIR_CL_PRIMARY_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 11)
  MDS_CDSADIR_CL_ENCAPSULATED_PRODUCT_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 12)
  MDS_CDSADIR_TP_PRIMARY_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 13)
  MDS_CDSADIR_TP_OIDS_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 14)
  MDS_CDSADIR_TP_ENCAPSULATED_PRODUCT_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 15)
  MDS_CDSADIR_EMM_PRIMARY_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 16)
  MDS_CDSADIR_AC_PRIMARY_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 17)
  MDS_CDSADIR_KR_PRIMARY_RECORDTYPE* = (MDS_CDSA_SCHEMA_START + 18)
  MDS_CDSADIR_MDS_SCHEMA_RELATIONS* = (MDS_CDSA_SCHEMA_START + 19)
  MDS_CDSADIR_MDS_SCHEMA_ATTRIBUTES* = (MDS_CDSA_SCHEMA_START + 20)
  MDS_CDSADIR_MDS_SCHEMA_INDEXES* = (MDS_CDSA_SCHEMA_START + 21)

##  MDS predefined values for a 16K name space

const
  CSSM_DB_ATTRIBUTE_MDS_START* = (0x40000000)
  CSSM_DB_ATTRIBUTE_MDS_END* = (0x40004000)
  MDS_CDSAATTR_MODULE_ID* = (CSSM_DB_ATTRIBUTE_MDS_START + 1)
  MDS_CDSAATTR_MANIFEST* = (CSSM_DB_ATTRIBUTE_MDS_START + 2)
  MDS_CDSAATTR_MODULE_NAME* = (CSSM_DB_ATTRIBUTE_MDS_START + 3)
  MDS_CDSAATTR_PATH* = (CSSM_DB_ATTRIBUTE_MDS_START + 4)
  MDS_CDSAATTR_CDSAVERSION* = (CSSM_DB_ATTRIBUTE_MDS_START + 5)
  MDS_CDSAATTR_VENDOR* = (CSSM_DB_ATTRIBUTE_MDS_START + 6)
  MDS_CDSAATTR_DESC* = (CSSM_DB_ATTRIBUTE_MDS_START + 8)
  MDS_CDSAATTR_INTERFACE_GUID* = (CSSM_DB_ATTRIBUTE_MDS_START + 9)
  MDS_CDSAATTR_POLICY_STMT* = (CSSM_DB_ATTRIBUTE_MDS_START + 10)
  MDS_CDSAATTR_EMMSPECVERSION* = (CSSM_DB_ATTRIBUTE_MDS_START + 11)
  MDS_CDSAATTR_EMM_VERSION* = (CSSM_DB_ATTRIBUTE_MDS_START + 12)
  MDS_CDSAATTR_EMM_VENDOR* = (CSSM_DB_ATTRIBUTE_MDS_START + 13)
  MDS_CDSAATTR_EMM_TYPE* = (CSSM_DB_ATTRIBUTE_MDS_START + 14)
  MDS_CDSAATTR_SSID* = (CSSM_DB_ATTRIBUTE_MDS_START + 15)
  MDS_CDSAATTR_SERVICE_TYPE* = (CSSM_DB_ATTRIBUTE_MDS_START + 16)
  MDS_CDSAATTR_NATIVE_SERVICES* = (CSSM_DB_ATTRIBUTE_MDS_START + 17)
  MDS_CDSAATTR_DYNAMIC_FLAG* = (CSSM_DB_ATTRIBUTE_MDS_START + 18)
  MDS_CDSAATTR_MULTITHREAD_FLAG* = (CSSM_DB_ATTRIBUTE_MDS_START + 19)
  MDS_CDSAATTR_SERVICE_MASK* = (CSSM_DB_ATTRIBUTE_MDS_START + 20)
  MDS_CDSAATTR_CSP_TYPE* = (CSSM_DB_ATTRIBUTE_MDS_START + 21)
  MDS_CDSAATTR_CSP_FLAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 22)
  MDS_CDSAATTR_CSP_CUSTOMFLAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 23)
  MDS_CDSAATTR_USEE_TAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 24)
  MDS_CDSAATTR_CONTEXT_TYPE* = (CSSM_DB_ATTRIBUTE_MDS_START + 25)
  MDS_CDSAATTR_ALG_TYPE* = (CSSM_DB_ATTRIBUTE_MDS_START + 26)
  MDS_CDSAATTR_GROUP_ID* = (CSSM_DB_ATTRIBUTE_MDS_START + 27)
  MDS_CDSAATTR_ATTRIBUTE_TYPE* = (CSSM_DB_ATTRIBUTE_MDS_START + 28)
  MDS_CDSAATTR_ATTRIBUTE_VALUE* = (CSSM_DB_ATTRIBUTE_MDS_START + 29)
  MDS_CDSAATTR_PRODUCT_DESC* = (CSSM_DB_ATTRIBUTE_MDS_START + 30)
  MDS_CDSAATTR_PRODUCT_VENDOR* = (CSSM_DB_ATTRIBUTE_MDS_START + 31)
  MDS_CDSAATTR_PRODUCT_VERSION* = (CSSM_DB_ATTRIBUTE_MDS_START + 32)
  MDS_CDSAATTR_PRODUCT_FLAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 33)
  MDS_CDSAATTR_PRODUCT_CUSTOMFLAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 34)
  MDS_CDSAATTR_STANDARD_DESC* = (CSSM_DB_ATTRIBUTE_MDS_START + 35)
  MDS_CDSAATTR_STANDARD_VERSION* = (CSSM_DB_ATTRIBUTE_MDS_START + 36)
  MDS_CDSAATTR_READER_DESC* = (CSSM_DB_ATTRIBUTE_MDS_START + 37)
  MDS_CDSAATTR_READER_VENDOR* = (CSSM_DB_ATTRIBUTE_MDS_START + 38)
  MDS_CDSAATTR_READER_VERSION* = (CSSM_DB_ATTRIBUTE_MDS_START + 39)
  MDS_CDSAATTR_READER_FWVERSION* = (CSSM_DB_ATTRIBUTE_MDS_START + 40)
  MDS_CDSAATTR_READER_FLAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 41)
  MDS_CDSAATTR_READER_CUSTOMFLAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 42)
  MDS_CDSAATTR_READER_SERIALNUMBER* = (CSSM_DB_ATTRIBUTE_MDS_START + 43)
  MDS_CDSAATTR_SC_DESC* = (CSSM_DB_ATTRIBUTE_MDS_START + 44)
  MDS_CDSAATTR_SC_VENDOR* = (CSSM_DB_ATTRIBUTE_MDS_START + 45)
  MDS_CDSAATTR_SC_VERSION* = (CSSM_DB_ATTRIBUTE_MDS_START + 46)
  MDS_CDSAATTR_SC_FWVERSION* = (CSSM_DB_ATTRIBUTE_MDS_START + 47)
  MDS_CDSAATTR_SC_FLAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 48)
  MDS_CDSAATTR_SC_CUSTOMFLAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 49)
  MDS_CDSAATTR_SC_SERIALNUMBER* = (CSSM_DB_ATTRIBUTE_MDS_START + 50)
  MDS_CDSAATTR_DL_TYPE* = (CSSM_DB_ATTRIBUTE_MDS_START + 51)
  MDS_CDSAATTR_QUERY_LIMITS* = (CSSM_DB_ATTRIBUTE_MDS_START + 52)
  MDS_CDSAATTR_CONJUNCTIVE_OPS* = (CSSM_DB_ATTRIBUTE_MDS_START + 53)
  MDS_CDSAATTR_RELATIONAL_OPS* = (CSSM_DB_ATTRIBUTE_MDS_START + 54)
  MDS_CDSAATTR_PROTOCOL* = (CSSM_DB_ATTRIBUTE_MDS_START + 55)
  MDS_CDSAATTR_CERT_TYPEFORMAT* = (CSSM_DB_ATTRIBUTE_MDS_START + 56)
  MDS_CDSAATTR_CRL_TYPEFORMAT* = (CSSM_DB_ATTRIBUTE_MDS_START + 57)
  MDS_CDSAATTR_CERT_FIELDNAMES* = (CSSM_DB_ATTRIBUTE_MDS_START + 58)
  MDS_CDSAATTR_BUNDLE_TYPEFORMAT* = (CSSM_DB_ATTRIBUTE_MDS_START + 59)
  MDS_CDSAATTR_CERT_CLASSNAME* = (CSSM_DB_ATTRIBUTE_MDS_START + 60)
  MDS_CDSAATTR_ROOTCERT* = (CSSM_DB_ATTRIBUTE_MDS_START + 61)
  MDS_CDSAATTR_ROOTCERT_TYPEFORMAT* = (CSSM_DB_ATTRIBUTE_MDS_START + 62)
  MDS_CDSAATTR_VALUE* = (CSSM_DB_ATTRIBUTE_MDS_START + 63)
  MDS_CDSAATTR_REQCREDENTIALS* = (CSSM_DB_ATTRIBUTE_MDS_START + 64)
  MDS_CDSAATTR_SAMPLETYPES* = (CSSM_DB_ATTRIBUTE_MDS_START + 65)
  MDS_CDSAATTR_ACLSUBJECTTYPES* = (CSSM_DB_ATTRIBUTE_MDS_START + 66)
  MDS_CDSAATTR_AUTHTAGS* = (CSSM_DB_ATTRIBUTE_MDS_START + 67)
  MDS_CDSAATTR_USEETAG* = (CSSM_DB_ATTRIBUTE_MDS_START + 68)
  MDS_CDSAATTR_RETRIEVALMODE* = (CSSM_DB_ATTRIBUTE_MDS_START + 69)
  MDS_CDSAATTR_OID* = (CSSM_DB_ATTRIBUTE_MDS_START + 70)
  MDS_CDSAATTR_XLATIONTYPEFORMAT* = (CSSM_DB_ATTRIBUTE_MDS_START + 71)
  MDS_CDSAATTR_DEFAULT_TEMPLATE_TYPE* = (CSSM_DB_ATTRIBUTE_MDS_START + 72)
  MDS_CDSAATTR_TEMPLATE_FIELD_NAMES* = (CSSM_DB_ATTRIBUTE_MDS_START + 73)
  MDS_CDSAATTR_AUTHORITY_REQUEST_TYPE* = (CSSM_DB_ATTRIBUTE_MDS_START + 74)

##  Meta-data names for the MDS Object directory relation

const
  MDS_OBJECT_NUM_RELATIONS* = (1)
  MDS_OBJECT_NUM_ATTRIBUTES* = (4)

##  Defined constant for # of relations in the CDSA directory

const
  MDS_CDSADIR_NUM_RELATIONS* = (19)

##  Meta-data names for the MDS CSSM relation

const
  MDS_CDSADIR_CSSM_NUM_ATTRIBUTES* = (4)

##  Meta-data names for the MDS EMM relation

const
  MDS_CDSADIR_EMM_NUM_ATTRIBUTES* = (11)

##  Meta-data names for the MDS Common relation

const
  MDS_CDSADIR_COMMON_NUM_ATTRIBUTES* = (9)

##  Meta-data names for the MDS CSP Primary relation

const
  MDS_CDSADIR_CSP_PRIMARY_NUM_ATTRIBUTES* = (13)

##  Meta-data names for the MDS CSP Capabilities relation

const
  MDS_CDSADIR_CSP_CAPABILITY_NUM_ATTRIBUTES* = (9)

##  Meta-data names for the MDS CSP Encapsulated Product relation

const
  MDS_CDSADIR_CSP_ENCAPSULATED_PRODUCT_NUM_ATTRIBUTES* = (16)

##  Meta-data names for the MDS CSP SmartcardInfo relation

const
  MDS_CDSADIR_CSP_SC_INFO_NUM_ATTRIBUTES* = (9)

##  Meta-data names for the MDS DL Primary relation

const
  MDS_CDSADIR_DL_PRIMARY_NUM_ATTRIBUTES* = (13)

##  Meta-data names for the MDS DL Encapsulated Product relation

const
  MDS_CDSADIR_DL_ENCAPSULATED_PRODUCT_NUM_ATTRIBUTES* = (10)

##  Meta-data names for the MDS CL Primary relation

const
  MDS_CDSADIR_CL_PRIMARY_NUM_ATTRIBUTES* = (13)

##  Meta-data names for the MDS CL Encapsulated Product relation

const
  MDS_CDSADIR_CL_ENCAPSULATED_PRODUCT_NUM_ATTRIBUTES* = (8)

##  Meta-data names for the MDS TP Primary relation

const
  MDS_CDSADIR_TP_PRIMARY_NUM_ATTRIBUTES* = (10)

##  Meta-data names for the MDS TP Policy-OIDS relation

const
  MDS_CDSADIR_TP_OIDS_NUM_ATTRIBUTES* = (4)

##  Meta-data names for the MDS TP Encapsulated Product relation

const
  MDS_CDSADIR_TP_ENCAPSULATED_PRODUCT_NUM_ATTRIBUTES* = (14)

##  Meta-data names for MDS EMM Service Provider Primary relation

const
  MDS_CDSADIR_EMM_PRIMARY_NUM_ATTRIBUTES* = (9)

##  Meta-data names for MDS AC Primary relation

const
  MDS_CDSADIR_AC_PRIMARY_NUM_ATTRIBUTES* = (6)

##  Meta-data names for MDS Schema relation

const
  MDS_CDSADIR_SCHEMA_RELATONS_NUM_ATTRIBUTES* = (2)
  MDS_CDSADIR_SCHEMA_ATTRIBUTES_NUM_ATTRIBUTES* = (6)
  MDS_CDSADIR_SCHEMA_INDEXES_NUM_ATTRIBUTES* = (5)
