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
##  CMSDecoder.h - decode, decrypt, and/or verify signatures of messages in the
## 				  Cryptographic Message Syntax (CMS), per RFC 3852.
##
##  See CMSEncoder.h for general information about CMS messages.
##

##
##  Opaque reference to a CMS decoder object.
##  This is a CF object, with standard CF semantics; dispose of it
##  with CFRelease().
##

type
  CMSDecoderRef* = ptr _CMSDecoder

proc CMSDecoderGetTypeID*(): CFTypeID
##
##  Status of signature and signer information in a signed message.
##

type
  CMSSignerStatus* = uint32_t

const
  kCMSSignerUnsigned* = 0       ##  message was not signed
  kCMSSignerValid* = 1          ##  message was signed and signature verify OK
  kCMSSignerNeedsDetachedContent* = 2 ##  message was signed but needs detached content
                                   ##    to verify
  kCMSSignerInvalidSignature* = 3 ##  message was signed but had a signature error
  kCMSSignerInvalidCert* = 4 ##  message was signed but an error occurred in verifying
                          ##    the signer's certificate
  kCMSSignerInvalidIndex* = 5   ##  specified signer index out of range

##
##  Create a CMSDecoder. Result must eventually be freed via CFRelease().
##

proc CMSDecoderCreate*(cmsDecoderOut: ptr CMSDecoderRef): OSStatus
  ##  RETURNED
##
##  Feed raw bytes of the message to be decoded into the decoder. Can be called
##  multiple times.
##  Returns errSecUnknownFormat upon detection of improperly formatted CMS
##  message.
##

proc CMSDecoderUpdateMessage*(cmsDecoder: CMSDecoderRef; msgBytes: pointer;
                             msgBytesLen: csize): OSStatus
##
##  Indicate that no more CMSDecoderUpdateMessage() calls are forthcoming;
##  finish decoding the message.
##  Returns errSecUnknownFormat upon detection of improperly formatted CMS
##  message.
##

proc CMSDecoderFinalizeMessage*(cmsDecoder: CMSDecoderRef): OSStatus
##
##  A signed CMS message optionally includes the data which was signed. If the
##  message does not include the signed data, caller specifies the signed data
##  (the "detached content") here.
##
##  This can be called either before or after the actual decoding of the message
##  (via CMSDecoderUpdateMessage() and CMSDecoderFinalizeMessage()); the only
##  restriction is that, if detached content is required, this function must
##  be called befoere successfully ascertaining the signature status via
##  CMSDecoderCopySignerStatus().
##

proc CMSDecoderSetDetachedContent*(cmsDecoder: CMSDecoderRef;
                                  detachedContent: CFDataRef): OSStatus
##
##  Obtain the detached content specified in CMSDecoderSetDetachedContent().
##  Returns a NULL detachedContent if no detached content has been specified.
##  Caller must CFRelease() the result.
##

proc CMSDecoderCopyDetachedContent*(cmsDecoder: CMSDecoderRef;
                                   detachedContentOut: ptr CFDataRef): OSStatus
  ##  RETURNED
when SEC_OS_OSX:
  ##
  ##  This function no longer affects the behavior of the CMS Decoder. Please
  ##  discontinue use.
  ##
  proc CMSDecoderSetSearchKeychain*(cmsDecoder: CMSDecoderRef;
                                   keychainOrArray: CFTypeRef): OSStatus
##
##  Obtain the number of signers of a message. A result of zero indicates that
##  the message was not signed.
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderGetNumSigners*(cmsDecoder: CMSDecoderRef; numSignersOut: ptr csize): OSStatus
  ##  RETURNED
##
##  Obtain the status of a CMS message's signature. A CMS message can
##  be signed my multiple signers; this function returns the status
##  associated with signer 'n' as indicated by the signerIndex parameter.
##
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##
##  Note that signature and certificate verification of a decoded message
##  does *not* occur until this routine is called.
##
##  All returned values are optional - pass NULL if you don't need a
##  particular parameter.
##
##  Note that errors like "bad signature" and "bad cert" do NOT cause this
##  routine to return a nonzero error status itself; such errors are reported
##  in the various out parameters, listed below.
##
##  Inputs:
##  -------
##  cmsDecoder       : a CMSDecoder which has successfully performed a
##                     CMSDecoderFinalizeMessage().
##  signerIndex      : indicates which of 'n' signers is being examined.
##                     Range is 0...(numSigners-1).
##  policyOrArray    : Either a SecPolicyRef or a CFArray of them.
##                     These policies are used to verify the signer's certificate.
##  evaluateSecTrust : When TRUE, causes the SecTrust oebject created for the
##                     evaluation of the signer cert to actually be evaluated
##                     via SecTrustEvaluate(). When FALSE, the caller performs
##                     the SecTrustEvaluate() operation on the SecTrust object
##                     returned via the secTrust out parameter.
##                     NOTE: it is hazardous and not recommended to pass in FALSE
##                     for the evaluateSecTrust parameter as well as NULL for the
##                     secTrust out parameter, since no evaluation of the signer
##                     cert can occur in that situation.
##
##  Outputs:
##  --------
## 	signerStatusOut			-- An enum indicating the overall status.
## 		kCMSSignerUnsigned         : message was not signed.
## 		kCMSSignerValid            : both signature and signer certificate verified OK.
## 		kCMSSignerNeedsDetachedContent : a call to CMSDecoderSetDetachedContent()
## 							         is required to ascertain the signature status.
## 		kCMSSignerInvalidSignature : bad signature.
## 		kCMSSignerInvalidCert      : an error occurred verifying the signer's certificate.
## 							         Further information available via the secTrust and
## 							         certVerifyResultCode parameters. This will never be
## 								     returned if evaluateSecTrust is FALSE.
## 		kCMSSignerInvalidIndex     : specified signerIndex is larger than the number of
## 								     signers (minus 1).
##
## 	secTrustOut				-- The SecTrust object used to verify the signer's
## 							   certificate. Caller must CFRelease this.
## 	certVerifyResultCodeOut	-- The result of the certificate verification. If
## 							   the evaluateSecTrust argument is set to FALSE on
## 							   input, this out parameter is undefined on return.
##
##  The certVerifyResultCode value can indicate a large number of errors; some of
##  the most common and interesting errors are:
##
##  CSSMERR_TP_INVALID_ANCHOR_CERT : The cert was verified back to a
## 		self-signed (root) cert which was present in the message, but
## 		that root cert is not a known, trusted root cert.
##  CSSMERR_TP_NOT_TRUSTED: The cert could not be verified back to
## 		a root cert.
##  CSSMERR_TP_VERIFICATION_FAILURE: A root cert was found which does
##    	not self-verify.
##  CSSMERR_TP_VERIFY_ACTION_FAILED: Indicates a failure of the requested
## 		policy action.
##  CSSMERR_TP_INVALID_CERTIFICATE: Indicates a bad leaf cert.
##  CSSMERR_TP_CERT_EXPIRED: A cert in the chain was expired at the time of
## 		verification.
##  CSSMERR_TP_CERT_NOT_VALID_YET: A cert in the chain was not yet valie at
## 		the time of	verification.
##

proc CMSDecoderCopySignerStatus*(cmsDecoder: CMSDecoderRef; signerIndex: csize;
                                policyOrArray: CFTypeRef;
                                evaluateSecTrust: Boolean;
                                signerStatusOut: ptr CMSSignerStatus;
                                secTrustOut: ptr SecTrustRef;
                                certVerifyResultCodeOut: ptr OSStatus): OSStatus
  ##  optional; RETURNED
  ##  optional; RETURNED
  ##  optional; RETURNED
##
##  Obtain the email address of signer 'signerIndex' of a CMS message, if
##  present.
##
##  Returns errSecParam if the CMS message was not signed or if signerIndex
##  is greater than the number of signers of the message minus one.
##
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderCopySignerEmailAddress*(cmsDecoder: CMSDecoderRef;
                                      signerIndex: csize;
                                      signerEmailAddressOut: ptr CFStringRef): OSStatus
  ##  RETURNED
##
##  Obtain the certificate of signer 'signerIndex' of a CMS message, if
##  present.
##
##  Returns errSecParam if the CMS message was not signed or if signerIndex
##  is greater than the number of signers of the message minus one.
##
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderCopySignerCert*(cmsDecoder: CMSDecoderRef; signerIndex: csize;
                              signerCertOut: ptr SecCertificateRef): OSStatus
  ##  RETURNED
##
##  Determine whether a CMS message was encrypted. Returns TRUE if so, FALSE if not.
##  Note that if the message was encrypted, and the decoding succeeded, (i.e.,
##  CMSDecoderFinalizeMessage() returned errSecSuccess), then the message was successfully
##  decrypted.
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderIsContentEncrypted*(cmsDecoder: CMSDecoderRef;
                                  isEncryptedOut: ptr Boolean): OSStatus
##
##  Obtain the eContentType OID for a SignedData's EncapsulatedContentType, if
##  present. If the message was not signed this will return NULL.
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##  The returned OID's data is in the same format as a CSSM_OID; i.e., it's
##  the encoded content of the OID, not including the tag and length bytes.
##

proc CMSDecoderCopyEncapsulatedContentType*(cmsDecoder: CMSDecoderRef;
    eContentTypeOut: ptr CFDataRef): OSStatus
  ##  RETURNED
##
##  Obtain an array of all of the certificates in a message. Elements of the
##  returned array are SecCertificateRefs. The caller must CFRelease the returned
##  array. If a message does not contain any certificates (which is the case for
##  a message which is encrypted but not signed), the returned *certs value
##  is NULL. The function will return errSecSuccess in this case.
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderCopyAllCerts*(cmsDecoder: CMSDecoderRef; certsOut: ptr CFArrayRef): OSStatus
  ##  RETURNED
##
##  Obtain the actual message content (payload), if any. If the message was
##  signed with detached content this will return NULL.
##  Caller must CFRelease the result.
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderCopyContent*(cmsDecoder: CMSDecoderRef; contentOut: ptr CFDataRef): OSStatus
  ##  RETURNED
##
##  Obtain the signing time of signer 'signerIndex' of a CMS message, if
##  present. This is an unauthenticate time, although it is part of the
##  signed attributes of the message.
##
##  Returns errSecParam if the CMS message was not signed or if signerIndex
##  is greater than the number of signers of the message minus one.
##
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderCopySignerSigningTime*(cmsDecoder: CMSDecoderRef;
                                     signerIndex: csize;
                                     signingTime: ptr CFAbsoluteTime): OSStatus
  ##  RETURNED
##
##  Obtain the timestamp of signer 'signerIndex' of a CMS message, if
##  present. This timestamp is an authenticated timestamp provided by
##  a timestamping authority.
##
##  Returns errSecParam if the CMS message was not signed or if signerIndex
##  is greater than the number of signers of the message minus one.
##
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderCopySignerTimestamp*(cmsDecoder: CMSDecoderRef; signerIndex: csize;
                                   timestamp: ptr CFAbsoluteTime): OSStatus
  ##  RETURNED
##
##  Obtain the timestamp of signer 'signerIndex' of a CMS message, if
##  present. This timestamp is an authenticated timestamp provided by
##  a timestamping authority. Use the policy provided as a parameter
##
##  Returns errSecParam if the CMS message was not signed or if signerIndex
##  is greater than the number of signers of the message minus one.
##
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderCopySignerTimestampWithPolicy*(cmsDecoder: CMSDecoderRef;
    timeStampPolicy: CFTypeRef; signerIndex: csize; timestamp: ptr CFAbsoluteTime): OSStatus
  ##  usually 0
  ##  RETURNED
##
##  Obtain an array of the certificates in a timestamp response. Elements of the
##  returned array are SecCertificateRefs. The caller must CFRelease the returned
##  array. This timestamp is an authenticated timestamp provided by
##  a timestamping authority.
##
##  Returns errSecParam if the CMS message was not signed or if signerIndex
##  is greater than the number of signers of the message minus one. It returns
##  errSecItemNotFound if no certificates were found.
##
##  This cannot be called until after CMSDecoderFinalizeMessage() is called.
##

proc CMSDecoderCopySignerTimestampCertificates*(cmsDecoder: CMSDecoderRef;
    signerIndex: csize; certificateRefs: ptr CFArrayRef): OSStatus
  ##  usually 0
  ##  RETURNED