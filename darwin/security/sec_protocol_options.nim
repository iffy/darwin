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
  ##  A `sec_protocol_options` instance is a container of options for security protocol instances,
  ##  such as TLS. Protocol options are used to configure security protocols in the network stack.
  ##  For example, clients may set the maximum and minimum allowed TLS versions through protocol
  ##  options.
  ##
  SEC_OBJECT_DECL(sec_protocol_options)
## !
##  @function sec_protocol_options_are_equal
##
##  @abstract
##       Compare two `sec_protocol_options_t` instances.
##
##  @param optionsA
##       A `sec_protocol_options_t` instance.
##
##  @param optionsB
##       A `sec_protocol_options_t` instance.
##
##  @return True if equal, and false otherwise.
##

proc sec_protocol_options_are_equal*(optionsA: sec_protocol_options_t;
                                    optionsB: sec_protocol_options_t): bool
## !
##  @function sec_protocol_options_set_local_identity
##
##  @abstract
##       Set the local identity to be used for this protocol instance.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param identity
##       A `sec_identity_t` instance carrying the private key and certificate.
##

proc sec_protocol_options_set_local_identity*(options: sec_protocol_options_t;
    identity: sec_identity_t)
## !
##  @function sec_protocol_options_append_tls_ciphersuite
##
##  @abstract
##       Append a TLS ciphersuite to the set of enabled ciphersuites.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param ciphersuite
##       A `tls_ciphersuite_t` value.
##

proc sec_protocol_options_append_tls_ciphersuite*(
    options: sec_protocol_options_t; ciphersuite: tls_ciphersuite_t)
## !
##  @function sec_protocol_options_add_tls_ciphersuite
##
##  @abstract
##       Add a TLS ciphersuite to the set of enabled ciphersuites.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param ciphersuite
##       A SSLCipherSuite value.
##

proc sec_protocol_options_add_tls_ciphersuite*(options: sec_protocol_options_t;
    ciphersuite: SSLCipherSuite)
## !
##  @function sec_protocol_options_append_tls_ciphersuite_group
##
##  @abstract
##       Append a TLS ciphersuite group to the set of enabled ciphersuites.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param group
##       A SSLCipherSuiteGroup value.
##

proc sec_protocol_options_append_tls_ciphersuite_group*(
    options: sec_protocol_options_t; group: tls_ciphersuite_group_t)
## !
##  @function sec_protocol_options_add_tls_ciphersuite_group
##
##  @abstract
##       Add a TLS ciphersuite group to the set of enabled ciphersuites.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param group
##       A SSLCipherSuiteGroup value.
##

proc sec_protocol_options_add_tls_ciphersuite_group*(
    options: sec_protocol_options_t; group: SSLCiphersuiteGroup)
## !
##  @function sec_protocol_options_set_tls_min_version
##
##  @abstract
##       Set the minimum support TLS version.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param version
##       A SSLProtocol enum value.
##

proc sec_protocol_options_set_tls_min_version*(options: sec_protocol_options_t;
    version: SSLProtocol)
## !
##  @function sec_protocol_options_set_min_tls_protocol_version
##
##  @abstract
##       Set the minimum support TLS version.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param version
##       A tls_protocol_version_t enum value.
##

proc sec_protocol_options_set_min_tls_protocol_version*(
    options: sec_protocol_options_t; version: tls_protocol_version_t)
## !
##  @function sec_protocol_options_get_default_min_tls_protocol_version
##
##  @abstract
##       Get the system default minimum TLS protocol version.
##
##  @return The default minimum TLS version.
##

proc sec_protocol_options_get_default_min_tls_protocol_version*(): tls_protocol_version_t
## !
##  @function sec_protocol_options_get_default_min_dtls_protocol_version
##
##  @abstract
##       Get the system default minimum DTLS protocol version.
##
##  @return The default minimum DTLS version.
##

proc sec_protocol_options_get_default_min_dtls_protocol_version*(): tls_protocol_version_t
## !
##  @function sec_protocol_options_set_tls_max_version
##
##  @abstract
##       Set the maximum support TLS version.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param version
##       A SSLProtocol enum value.
##

proc sec_protocol_options_set_tls_max_version*(options: sec_protocol_options_t;
    version: SSLProtocol)
## !
##  @function sec_protocol_options_set_max_tls_protocol_version
##
##  @abstract
##       Set the maximum support TLS version.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param version
##       A tls_protocol_version_t enum value.
##

proc sec_protocol_options_set_max_tls_protocol_version*(
    options: sec_protocol_options_t; version: tls_protocol_version_t)
## !
##  @function sec_protocol_options_get_default_max_tls_protocol_version
##
##  @abstract
##       Get the system default maximum TLS protocol version.
##
##  @return The default maximum TLS version.
##

proc sec_protocol_options_get_default_max_tls_protocol_version*(): tls_protocol_version_t
## !
##  @function sec_protocol_options_get_default_max_tls_protocol_version
##
##  @abstract
##       Get the system default maximum DTLS protocol version.
##
##  @return The default maximum DTLS version.
##

proc sec_protocol_options_get_default_max_dtls_protocol_version*(): tls_protocol_version_t
## !
##  @function sec_protocol_options_add_tls_application_protocol
##
##  @abstract
##       Add an application protocol supported by clients of this protocol instance.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param application_protocol
##       A NULL-terminated string defining the application protocol.
##

proc sec_protocol_options_add_tls_application_protocol*(
    options: sec_protocol_options_t; application_protocol: cstring)
## !
##  @function sec_protocol_options_set_tls_server_name
##
##  @abstract
##       Set the server (domain) name to be used in the TLS SNI. This will override
##       the server name obtained from the endpoint.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param server_name
##       A NULL-terminated string carrying the server (domain) name.
##

proc sec_protocol_options_set_tls_server_name*(options: sec_protocol_options_t;
    server_name: cstring)
## !
##  @function sec_protocol_options_set_tls_diffie_hellman_parameters
##
##  @abstract
##       Set the supported Diffie-Hellman parameters.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param params
##       A dispatch_data_t containing legacy Diffie-Hellman parameters.
##

proc sec_protocol_options_set_tls_diffie_hellman_parameters*(
    options: sec_protocol_options_t; params: dispatch_data_t)
## !
##  @function sec_protocol_options_add_pre_shared_key
##
##  @abstract
##       Add a pre-shared key (PSK) and its identity to the options.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param psk
##       A dispatch_data_t containing a PSK blob.
##
##  @param psk_identity
##       A dispatch_data_t containing a PSK identity blob.
##

proc sec_protocol_options_add_pre_shared_key*(options: sec_protocol_options_t;
    psk: dispatch_data_t; psk_identity: dispatch_data_t)
## !
##  @function sec_protocol_options_set_tls_pre_shared_key_identity_hint
##
##  @abstract
##       Set the PSK identity hint to use by servers when negotiating a PSK ciphersuite.
##       See https://tools.ietf.org/html/rfc4279 for more details.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param psk_identity_hint
##       A dispatch_data_t containing a PSK identity hint.
##

proc sec_protocol_options_set_tls_pre_shared_key_identity_hint*(
    options: sec_protocol_options_t; psk_identity_hint: dispatch_data_t)
## !
##  @function sec_protocol_options_set_tls_tickets_enabled
##
##  @abstract
##       Enable or disable TLS session ticket support.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param tickets_enabled
##       Flag to enable or disable TLS session ticket support.
##

proc sec_protocol_options_set_tls_tickets_enabled*(
    options: sec_protocol_options_t; tickets_enabled: bool)
## !
##  @function sec_protocol_options_set_tls_is_fallback_attempt
##
##  @abstract
##       Signal if this is a TLS fallback attempt.
##
##       A fallback attempt is one following a previously failed TLS connection
##       due to version or parameter incompatibility, e.g., when speaking to a server
##       that does not support a client-offered ciphersuite.
##
##       Clients MUST NOT enable fallback for fresh connections.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param is_fallback_attempt
##       Set a flag indicating that this is a TLS fallback attempt.
##

proc sec_protocol_options_set_tls_is_fallback_attempt*(
    options: sec_protocol_options_t; is_fallback_attempt: bool)
## !
##  @function sec_protocol_options_set_tls_resumption_enabled
##
##  @abstract
##       Enable or disable TLS session resumption.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param resumption_enabled
##       Flag to enable or disable TLS session resumption.
##

proc sec_protocol_options_set_tls_resumption_enabled*(
    options: sec_protocol_options_t; resumption_enabled: bool)
## !
##  @function sec_protocol_options_set_tls_false_start_enabled
##
##  @abstract
##       Enable or disable TLS False Start.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param false_start_enabled
##       Flag to enable or disable TLS False Start.
##

proc sec_protocol_options_set_tls_false_start_enabled*(
    options: sec_protocol_options_t; false_start_enabled: bool)
## !
##  @function nw_protocol_options_set_tls_ocsp_enabled
##
##  @abstract
##       Enable or disable OCSP support.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param ocsp_enabled
##       Flag to enable or disable OCSP support.
##

proc sec_protocol_options_set_tls_ocsp_enabled*(options: sec_protocol_options_t;
    ocsp_enabled: bool)
## !
##  @function sec_protocol_options_set_tls_sct_enabled
##
##  @abstract
##       Enable or disable SCT (signed certificate timestamp) support.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param sct_enabled
##       Flag to enable or disable SCT support.
##

proc sec_protocol_options_set_tls_sct_enabled*(options: sec_protocol_options_t;
    sct_enabled: bool)
## !
##  @function sec_protocol_options_set_tls_renegotiation_enabled
##
##  @abstract
##       Enable or disable TLS (1.2 and prior) session renegotiation. This defaults to `true`.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param renegotiation_enabled
##       Flag to enable or disable TLS (1.2 and prior) session renegotiation.
##

proc sec_protocol_options_set_tls_renegotiation_enabled*(
    options: sec_protocol_options_t; renegotiation_enabled: bool)
## !
##  @function sec_protocol_options_set_peer_authentication_required
##
##  @abstract
##       Enable or disable peer authentication. Clients default to true, whereas servers default to false.
##
##  @param options
##       A `sec_protocol_options_t` instance.
##
##  @param peer_authentication_required
##       Flag to enable or disable mandatory peer authentication.
##

proc sec_protocol_options_set_peer_authentication_required*(
    options: sec_protocol_options_t; peer_authentication_required: bool)