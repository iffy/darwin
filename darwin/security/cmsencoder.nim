##
##  Copyright (c) 2006-2018 Apple Inc. All Rights Reserved.
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
##  CMSEncoder.h - encode, sign, and/or encrypt messages in the Cryptographic
## 				  Message Syntax (CMS), per RFC 3852.
##
##  A CMS message can be signed, encrypted, or both. A message can be signed by
##  an arbitrary number of signers; in this module, signers are expressed as
##  SecIdentityRefs. A message can be encrypted for an arbitrary number of
##  recipients; recipients are expressed here as SecCertificateRefs.
##
##  In CMS terminology, this module performs encryption using the EnvelopedData
##  ContentType and signing using the SignedData ContentType.
##
##  If the message is both signed and encrypted, it uses "nested ContentInfos"
##  in CMS terminology; in this implementation, signed & encrypted messages
##  are implemented as an EnvelopedData containing a SignedData.
##

when SEC_OS_OSX:
##
##  Opaque reference to a CMS encoder object.
##  This is a CF object, with standard CF semantics; dispose of it
##  with CFRelease().
##

type
  CMSEncoderRef* = ptr _CMSEncoder

proc CMSEncoderGetTypeID*(): CFTypeID
##
##  Create a CMSEncoder. Result must eventually be freed via CFRelease().
##

proc CMSEncoderCreate*(cmsEncoderOut: ptr CMSEncoderRef): OSStatus
  ##  RETURNED
var kCMSEncoderDigestAlgorithmSHA1*: CFStringRef

var kCMSEncoderDigestAlgorithmSHA256*: CFStringRef

proc CMSEncoderSetSignerAlgorithm*(cmsEncoder: CMSEncoderRef;
                                  digestAlgorithm: CFStringRef): OSStatus
##
##  Specify signers of the CMS message; implies that the message will be signed.
##
##  -- Caller can pass in one signer, as a SecIdentityRef, or an array of
##     signers, as a CFArray of SecIdentityRefs.
##  -- Can be called multiple times.
##  -- If the message is not to be signed, don't call this.
##  -- If this is called, it must be called before the first call to
##     CMSEncoderUpdateContent().
##

proc CMSEncoderAddSigners*(cmsEncoder: CMSEncoderRef; signerOrArray: CFTypeRef): OSStatus
##
##  Obtain an array of signers as specified in CMSEncoderSetSigners().
##  Returns a NULL signers array if CMSEncoderSetSigners() has not been called.
##  Caller must CFRelease the result.
##

proc CMSEncoderCopySigners*(cmsEncoder: CMSEncoderRef; signersOut: ptr CFArrayRef): OSStatus
  ##  RETURNED
##
##  Specify recipients of the message. Implies that the message will
##  be encrypted.
##
##  -- Caller can pass in one recipient, as a SecCertificateRef, or an
##     array of recipients, as a CFArray of SecCertificateRefs.
##  -- Can be called multiple times.
##  -- If the message is not to be encrypted, don't call this.
##  -- If this is called, it must be called before the first call to
##     CMSEncoderUpdateContent().
##

proc CMSEncoderAddRecipients*(cmsEncoder: CMSEncoderRef;
                             recipientOrArray: CFTypeRef): OSStatus
##
##  Obtain an array of recipients as specified in CMSEncoderSetRecipients().
##  Returns a NULL recipients array if CMSEncoderSetRecipients() has not been
##  called.
##  Caller must CFRelease the result.
##

proc CMSEncoderCopyRecipients*(cmsEncoder: CMSEncoderRef;
                              recipientsOut: ptr CFArrayRef): OSStatus
  ##  RETURNED
##
##  A signed message optionally includes the data to be signed. If the message
##  is *not* to include the data to be signed, call this function with a value
##  of TRUE for detachedContent. The default, if this function is not called,
##  is detachedContent=FALSE, i.e., the message contains the data to be signed.
##
##  -- Encrypted messages can not use detached content. (This restriction
##     also applies to messages that are both signed and encrypted.)
##  -- If this is called, it must be called before the first call to
##     CMSEncoderUpdateContent().
##

proc CMSEncoderSetHasDetachedContent*(cmsEncoder: CMSEncoderRef;
                                     detachedContent: Boolean): OSStatus
##
##  Obtain a Boolean indicating whether the current message will have detached
##  content.
##  Returns the value specified in CMSEncoderHasDetachedContent() if that
##  function has been called; else returns the default FALSE.
##

proc CMSEncoderGetHasDetachedContent*(cmsEncoder: CMSEncoderRef;
                                     detachedContentOut: ptr Boolean): OSStatus
  ##  RETURNED
when SEC_OS_OSX:
  ##
  ##  Optionally specify an eContentType OID for the inner EncapsulatedData for
  ##  a signed message. The default eContentType, used if this function is not
  ##  called, is id-data (which is the normal eContentType for applications such
  ##  as SMIME).
  ##
  ##  If this is called, it must be called before the first call to
  ##  CMSEncoderUpdateContent().
  ##
  ##  NOTE: This function is deprecated in Mac OS X 10.7 and later;
  ##  please use CMSEncoderSetEncapsulatedContentTypeOID() instead.
  ##
  proc CMSEncoderSetEncapsulatedContentType*(cmsEncoder: CMSEncoderRef;
      eContentType: ptr CSSM_OID): OSStatus
##
##  Optionally specify an eContentType OID for the inner EncapsulatedData for
##  a signed message. The default eContentTypeOID, used if this function is not
##  called, is id-data (which is the normal eContentType for applications such
##  as SMIME).
##
##  The eContentTypeOID parameter may be specified as a CF string, e.g.:
##  CFSTR("1.2.840.113549.1.7.1")
##
##  If this is called, it must be called before the first call to
##  CMSEncoderUpdateContent().
##

proc CMSEncoderSetEncapsulatedContentTypeOID*(cmsEncoder: CMSEncoderRef;
    eContentTypeOID: CFTypeRef): OSStatus
##
##  Obtain the eContentType OID specified in CMSEncoderSetEncapsulatedContentType().
##  If CMSEncoderSetEncapsulatedContentType() has not been called this returns a
##  NULL pointer.
##  The returned OID's data is in the same format as the data provided to
##  CMSEncoderSetEncapsulatedContentType;, i.e., it's the encoded content of
##  the OID, not including the tag and length bytes.
##

proc CMSEncoderCopyEncapsulatedContentType*(cmsEncoder: CMSEncoderRef;
    eContentTypeOut: ptr CFDataRef): OSStatus
  ##  RETURNED
##
##  Signed CMS messages can contain arbitrary sets of certificates beyond those
##  indicating the identity of the signer(s). This function provides a means of
##  adding these other certs. For normal signed messages it is not necessary to
##  call this; the signer cert(s) and the intermediate certs needed to verify the
##  signer(s) will be included in the message implicitly.
##
##  -- Caller can pass in one cert, as a SecCertificateRef, or an array of certs,
##     as a CFArray of SecCertificateRefs.
##  -- If this is called, it must be called before the first call to
##     CMSEncoderUpdateContent().
##  -- There is a "special case" use of CMS messages which involves neither
##     signing nor encryption, but does include certificates. This is commonly
##     used to transport "bags" of certificates. When constructing such a
##     message, all an application needs to do is to create a CMSEncoderRef,
##     call CMSEncoderAddSupportingCerts() one or more times, and then call
##     CMSEncoderCopyEncodedContent() to get the resulting cert bag. No 'content'
##     need be specified. (This is in fact the primary intended use for
##     this function.)
##

proc CMSEncoderAddSupportingCerts*(cmsEncoder: CMSEncoderRef;
                                  certOrArray: CFTypeRef): OSStatus
##
##  Obtain the SecCertificates provided in CMSEncoderAddSupportingCerts().
##  If CMSEncoderAddSupportingCerts() has not been called this will return a
##  NULL value for *certs.
##  Caller must CFRelease the result.
##

proc CMSEncoderCopySupportingCerts*(cmsEncoder: CMSEncoderRef;
                                   certsOut: ptr CFArrayRef): OSStatus
  ##  RETURNED
##
##  Standard signed attributes, optionally specified in
##  CMSEncoderAddSignedAttributes().
##

type
  CMSSignedAttributes* = uint32_t

const
  kCMSAttrNone* = 0x00000000 ##
                          ##  S/MIME Capabilities - identifies supported signature, encryption, and
                          ##  digest algorithms.
                          ##
  kCMSAttrSmimeCapabilities* = 0x00000001 ##
                                       ##  Indicates that a cert is the preferred cert for S/MIME encryption.
                                       ##
  kCMSAttrSmimeEncryptionKeyPrefs* = 0x00000002 ##
                                             ##  Same as kCMSSmimeEncryptionKeyPrefs, using an attribute OID preferred
                                             ##  by Microsoft.
                                             ##
  kCMSAttrSmimeMSEncryptionKeyPrefs* = 0x00000004 ##
                                               ##  Include the signing time.
                                               ##
  kCMSAttrSigningTime* = 0x00000008 ##
                                 ##  Include the Apple Codesigning Hash Agility.
                                 ##
  kCMSAttrAppleCodesigningHashAgility* = 0x00000010
  kCMSAttrAppleCodesigningHashAgilityV2* = 0x00000020 ##
                                                   ##  Include the expiration time.
                                                   ##
  kCMSAttrAppleExpirationTime* = 0x00000040

##
##  Optionally specify signed attributes. Only meaningful when creating a
##  signed message. If this is called, it must be called before
##  CMSEncoderUpdateContent().
##

proc CMSEncoderAddSignedAttributes*(cmsEncoder: CMSEncoderRef;
                                   signedAttributes: CMSSignedAttributes): OSStatus
##
##  Specification of what certificates to include in a signed message.
##

type
  CMSCertificateChainMode* = uint32_t

const
  kCMSCertificateNone* = 0      ##  don't include any certificates
  kCMSCertificateSignerOnly* = 1 ##  only include signer certificate(s)
  kCMSCertificateChain* = 2     ##  signer certificate chain up to but not
                         ##    including root certiticate
  kCMSCertificateChainWithRoot* = 3 ##  signer certificate chain including root
  kCMSCertificateChainWithRootOrFail* = 4 ##  signer certificate chain including root
                                       ##  and if chain not terminated by a self-signed cert,
                                       ##  fail to create CMS

##
##  Optionally specify which certificates, if any, to include in a
##  signed CMS message. The default, if this is not called, is
##  kCMSCertificateChain, in which case the signer cert plus all CA
##  certs needed to verify the signer cert, except for the root
##  cert, are included.
##  If this is called, it must be called before
##  CMSEncoderUpdateContent().
##

proc CMSEncoderSetCertificateChainMode*(cmsEncoder: CMSEncoderRef;
                                       chainMode: CMSCertificateChainMode): OSStatus
##
##  Obtain indication of which signer certs are to be included
##  in a signed CMS message.
##

proc CMSEncoderGetCertificateChainMode*(cmsEncoder: CMSEncoderRef; chainModeOut: ptr CMSCertificateChainMode): OSStatus
##
##  Feed content bytes into the encoder.
##  Can be called multiple times.
##  No 'setter' routines can be called after this function has been called.
##

proc CMSEncoderUpdateContent*(cmsEncoder: CMSEncoderRef; content: pointer;
                             contentLen: csize): OSStatus
##
##  Finish encoding the message and obtain the encoded result.
##  Caller must CFRelease the result.
##

proc CMSEncoderCopyEncodedContent*(cmsEncoder: CMSEncoderRef;
                                  encodedContentOut: ptr CFDataRef): OSStatus
  ##  RETURNED
when TARGET_OS_OSX:
  ##
  ##  High-level, one-shot encoder function.
  ##
  ##  Inputs (all except for content optional, though at least one
  ##          of {signers, recipients} must be non-NULL)
  ##  ------------------------------------------------------------
  ##  signers          : signer identities. Either a SecIdentityRef, or a
  ##                     CFArray of them.
  ##  recipients       : recipient certificates. Either a SecCertificateRef,
  ##                     or a CFArray of them.
  ##  eContentType     : contentType for inner EncapsulatedData.
  ##  detachedContent  : when true, do not include the signed data in the message.
  ##  signedAttributes : Specifies which standard signed attributes are to be
  ##                     included in the message.
  ##  content          : raw content to be signed and/or encrypted.
  ##
  ##  Output
  ##  ------
  ##  encodedContent   : the result of the encoding.
  ##
  ##  NOTE: This function is deprecated in Mac OS X 10.7 and later;
  ##  please use CMSEncodeContent() instead.
  ##
  proc CMSEncode*(signers: CFTypeRef; recipients: CFTypeRef;
                 eContentType: ptr CSSM_OID; detachedContent: Boolean;
                 signedAttributes: CMSSignedAttributes; content: pointer;
                 contentLen: csize; encodedContentOut: ptr CFDataRef): OSStatus
    ##  RETURNED
##
##  High-level, one-shot encoder function.
##
##  Inputs (all except for content optional, though at least one
##          of {signers, recipients} must be non-NULL)
##  ------------------------------------------------------------
##  signers          : signer identities. Either a SecIdentityRef, or a
##                     CFArray of them.
##  recipients       : recipient certificates. Either a SecCertificateRef,
##                     or a CFArray of them.
##  eContentTypeOID  : contentType OID for inner EncapsulatedData, e.g.:
##                     CFSTR("1.2.840.113549.1.7.1")
##  detachedContent  : when true, do not include the signed data in the message.
##  signedAttributes : Specifies which standard signed attributes are to be
##                     included in the message.
##  content          : raw content to be signed and/or encrypted.
##
##  Output
##  ------
##  encodedContent   : the result of the encoding.
##

proc CMSEncodeContent*(signers: CFTypeRef; recipients: CFTypeRef;
                      eContentTypeOID: CFTypeRef; detachedContent: Boolean;
                      signedAttributes: CMSSignedAttributes; content: pointer;
                      contentLen: csize; encodedContentOut: ptr CFDataRef): OSStatus
  ##  RETURNED
proc CMSEncoderCopySignerTimestamp*(cmsEncoder: CMSEncoderRef; signerIndex: csize;
                                   timestamp: ptr CFAbsoluteTime): OSStatus
  ##  usually 0
  ##  RETURNED
proc CMSEncoderCopySignerTimestampWithPolicy*(cmsEncoder: CMSEncoderRef;
    timeStampPolicy: CFTypeRef; signerIndex: csize; timestamp: ptr CFAbsoluteTime): OSStatus
  ##  usually 0
  ##  RETURNED