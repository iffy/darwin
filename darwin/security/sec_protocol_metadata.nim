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

## !
##  The following diagram shows how clients interact with sec_protocol_options
##  and sec_protocol_metadata when configuring and using network security protocols.
##
##                     +--------+
##                     | Client |
##                     +-+---/ \+
##                       |    |
##         +-------------+    +-------------+
##         | (1) set             (2) get    |
##         | options             metadata   |
##  +-----\ /---------------+  +------------+----------+
##  | sec_protocol_options  |  | sec_protocol_metadata |
##  +-----------------------+  +-----------------------+
##
##  Clients configure security protocols with `sec_protocol_options` instances.
##  And they inspect protocol instances using `sec_protocol_metadata` instances.
##

when not defined(SEC_OBJECT_IMPL):
  ## !
  ##  A `sec_protocol_metadata` instance conatins read-only properties of a connected and configured
  ##  security protocol. Clients use this object to read information about a protocol instance. Properties
  ##  include, for example, the negotiated TLS version, ciphersuite, and peer certificates.
  ##
  SEC_OBJECT_DECL(sec_protocol_metadata)
## !
##  @function sec_protocol_metadata_get_negotiated_protocol
##
##  @abstract
##       Get the application protocol negotiated, e.g., via the TLS ALPN extension.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @return A NULL-terminated string carrying the negotiated protocol.
##

proc sec_protocol_metadata_get_negotiated_protocol*(
    metadata: sec_protocol_metadata_t): cstring
## !
##  @function sec_protocol_metadata_copy_peer_public_key
##
##  @abstract
##       Get the protocol instance peer's public key.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @return A `dispatch_data_t` containing the peer's raw public key.
##

proc sec_protocol_metadata_copy_peer_public_key*(
    metadata: sec_protocol_metadata_t): dispatch_data_t
## !
##  @function sec_protocol_metadata_get_negotiated_tls_protocol_version
##
##  @abstract
##       Get the negotiated TLS version.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @return A `tls_protocol_version_t` value.
##

proc sec_protocol_metadata_get_negotiated_tls_protocol_version*(
    metadata: sec_protocol_metadata_t): tls_protocol_version_t
## !
##  @function sec_protocol_metadata_get_negotiated_protocol_version
##
##  @abstract
##       Get the negotiated TLS version.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @return A SSLProtocol enum of the TLS version.
##

proc sec_protocol_metadata_get_negotiated_protocol_version*(
    metadata: sec_protocol_metadata_t): SSLProtocol
## !
##  @function sec_protocol_metadata_get_negotiated_tls_ciphersuite
##
##  @abstract
##       Get the negotiated TLS ciphersuite.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @return A `tls_ciphersuite_t`.
##

proc sec_protocol_metadata_get_negotiated_tls_ciphersuite*(
    metadata: sec_protocol_metadata_t): tls_ciphersuite_t
## !
##  @function sec_protocol_metadata_get_negotiated_ciphersuite
##
##  @abstract
##       Get the negotiated TLS ciphersuite.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @return A SSLCipherSuite.
##

proc sec_protocol_metadata_get_negotiated_ciphersuite*(
    metadata: sec_protocol_metadata_t): SSLCipherSuite
## !
##  @function sec_protocol_metadata_get_early_data_accepted
##
##  @abstract
##       Determine if early data was accepted by the peer.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @return A bool indicating if early data was accepted.
##

proc sec_protocol_metadata_get_early_data_accepted*(
    metadata: sec_protocol_metadata_t): bool
## !
##  @function sec_protocol_metadata_get_server_name
##
##  @abstract
##       Obtain the server name offered by a client or server during
##       connection establishmet. This is the value commonly carried
##       in the TLS SNI extesion.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @return Returns A NULL-terminated string carrying the server name, or NULL
##       if none was provided.
##

proc sec_protocol_metadata_get_server_name*(metadata: sec_protocol_metadata_t): cstring
## !
##  @function sec_protocol_metadata_peers_are_equal
##
##  @abstract
##       Compare peer information for two `sec_protocol_metadata` instances.
##       This comparison does not include protocol configuration options, e.g., ciphersuites.
##
##  @param metadataA
##       A `sec_protocol_metadata_t` instance.
##
##  @param metadataB
##       A `sec_protocol_metadata_t` instance.
##
##  @return Returns true if both metadata values refer to the same peer, and false otherwise.
##

proc sec_protocol_metadata_peers_are_equal*(metadataA: sec_protocol_metadata_t;
    metadataB: sec_protocol_metadata_t): bool
## !
##  @function sec_protocol_metadata_challenge_parameters_are_equal
##
##  @abstract
##       Compare challenge-relevant information for two `sec_protocol_metadata` instances.
##
##       This comparison includes all information relevant to a challenge request, including:
##       distinguished names, signature algorithms, and supported certificate types.
##       See Section 7.4.4 of RFC5246 for more details.
##
##  @param metadataA
##       A `sec_protocol_metadata_t` instance.
##
##  @param metadataB
##       A `sec_protocol_metadata_t` instance.
##
##  @return Returns true if both metadata values have the same challenge parameters.
##

proc sec_protocol_metadata_challenge_parameters_are_equal*(
    metadataA: sec_protocol_metadata_t; metadataB: sec_protocol_metadata_t): bool
## !
##  @function sec_protocol_metadata_create_secret
##
##  @abstract
##       Export a secret, e.g., a cryptographic key, derived from the protocol metadata using a label string.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @param label_len
##       Length of the KDF label string.
##
##  @param label
##       KDF label string.
##
##  @param exporter_length
##       Length of the secret to be exported.
##
##  @return Returns a dispatch_data_t object carrying the exported secret.
##

proc sec_protocol_metadata_create_secret*(metadata: sec_protocol_metadata_t;
    label_len: csize; label: cstring; exporter_length: csize): dispatch_data_t
## !
##  @function sec_protocol_metadata_create_secret_with_context
##
##  @abstract
##       Export a secret, e.g., a cryptographic key, derived from the protocol metadata using a label and context string.
##
##  @param metadata
##       A `sec_protocol_metadata_t` instance.
##
##  @param label_len
##       Length of the KDF label string.
##
##  @param label
##       KDF label string.
##
##  @param context_len
##       Length of the KDF context string.
##
##  @param context
##       Constant opaque context value
##
##  @param exporter_length
##       Length of the secret to be exported.
##
##  @return Returns a dispatch_data_t object carrying the exported secret.
##

proc sec_protocol_metadata_create_secret_with_context*(
    metadata: sec_protocol_metadata_t; label_len: csize; label: cstring;
    context_len: csize; context: ptr uint8_t; exporter_length: csize): dispatch_data_t