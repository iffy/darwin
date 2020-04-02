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
##    File:      mds.h
##
##    Contains:  Module Directory Services Data Types and API.
##
##    Copyright (c) 1999-2000,2011,2014 Apple Inc. All Rights Reserved.
##

type
  MDS_HANDLE* = CSSM_DL_HANDLE
  MDS_DB_HANDLE* = CSSM_DL_DB_HANDLE
  MDS_FUNCS* {.bycopy.} = object
    DbOpen*: proc (MdsHandle: MDS_HANDLE; DbName: cstring;
                 DbLocation: ptr CSSM_NET_ADDRESS;
                 AccessRequest: CSSM_DB_ACCESS_TYPE;
                 AccessCred: ptr CSSM_ACCESS_CREDENTIALS; OpenParameters: pointer;
                 hMds: ptr CSSM_DB_HANDLE): CSSM_RETURN
    DbClose*: proc (MdsDbHandle: MDS_DB_HANDLE): CSSM_RETURN
    GetDbNames*: proc (MdsHandle: MDS_HANDLE; NameList: ptr CSSM_NAME_LIST_PTR): CSSM_RETURN
    GetDbNameFromHandle*: proc (MdsDbHandle: MDS_DB_HANDLE; DbName: cstringArray): CSSM_RETURN
    FreeNameList*: proc (MdsHandle: MDS_HANDLE; NameList: CSSM_NAME_LIST_PTR): CSSM_RETURN
    DataInsert*: proc (MdsDbHandle: MDS_DB_HANDLE; RecordType: CSSM_DB_RECORDTYPE;
                     Attributes: ptr CSSM_DB_RECORD_ATTRIBUTE_DATA;
                     Data: ptr CSSM_DATA; UniqueId: ptr CSSM_DB_UNIQUE_RECORD_PTR): CSSM_RETURN
    DataDelete*: proc (MdsDbHandle: MDS_DB_HANDLE;
                     UniqueRecordIdentifier: ptr CSSM_DB_UNIQUE_RECORD): CSSM_RETURN
    DataModify*: proc (MdsDbHandle: MDS_DB_HANDLE; RecordType: CSSM_DB_RECORDTYPE;
                     UniqueRecordIdentifier: CSSM_DB_UNIQUE_RECORD_PTR;
                     AttributesToBeModified: ptr CSSM_DB_RECORD_ATTRIBUTE_DATA;
                     DataToBeModified: ptr CSSM_DATA;
                     ModifyMode: CSSM_DB_MODIFY_MODE): CSSM_RETURN
    DataGetFirst*: proc (MdsDbHandle: MDS_DB_HANDLE; Query: ptr CSSM_QUERY;
                       ResultsHandle: CSSM_HANDLE_PTR;
                       Attributes: CSSM_DB_RECORD_ATTRIBUTE_DATA_PTR;
                       Data: CSSM_DATA_PTR;
                       UniqueId: ptr CSSM_DB_UNIQUE_RECORD_PTR): CSSM_RETURN
    DataGetNext*: proc (MdsDbHandle: MDS_DB_HANDLE; ResultsHandle: CSSM_HANDLE;
                      Attributes: CSSM_DB_RECORD_ATTRIBUTE_DATA_PTR;
                      Data: CSSM_DATA_PTR; UniqueId: ptr CSSM_DB_UNIQUE_RECORD_PTR): CSSM_RETURN
    DataAbortQuery*: proc (MdsDbHandle: MDS_DB_HANDLE; ResultsHandle: CSSM_HANDLE): CSSM_RETURN
    DataGetFromUniqueRecordId*: proc (MdsDbHandle: MDS_DB_HANDLE;
                                    UniqueRecord: ptr CSSM_DB_UNIQUE_RECORD;
        Attributes: CSSM_DB_RECORD_ATTRIBUTE_DATA_PTR; Data: CSSM_DATA_PTR): CSSM_RETURN
    FreeUniqueRecord*: proc (MdsDbHandle: MDS_DB_HANDLE;
                           UniqueRecord: CSSM_DB_UNIQUE_RECORD_PTR): CSSM_RETURN
    CreateRelation*: proc (MdsDbHandle: MDS_DB_HANDLE;
                         RelationID: CSSM_DB_RECORDTYPE; RelationName: cstring;
                         NumberOfAttributes: uint32;
                         pAttributeInfo: ptr CSSM_DB_SCHEMA_ATTRIBUTE_INFO;
                         NumberOfIndexes: uint32;
                         pIndexInfo: ptr CSSM_DB_SCHEMA_INDEX_INFO): CSSM_RETURN
    DestroyRelation*: proc (MdsDbHandle: MDS_DB_HANDLE;
                          RelationID: CSSM_DB_RECORDTYPE): CSSM_RETURN

  MDS_FUNCS_PTR* = ptr MDS_FUNCS

##  MDS Context APIs

proc MDS_Initialize*(pCallerGuid: ptr CSSM_GUID;
                    pMemoryFunctions: ptr CSSM_MEMORY_FUNCS;
                    pDlFunctions: MDS_FUNCS_PTR; hMds: ptr MDS_HANDLE): CSSM_RETURN
proc MDS_Terminate*(MdsHandle: MDS_HANDLE): CSSM_RETURN
proc MDS_Install*(MdsHandle: MDS_HANDLE): CSSM_RETURN
proc MDS_Uninstall*(MdsHandle: MDS_HANDLE): CSSM_RETURN