##
##  Copyright (c) 2001-2002,2004,2011-2012,2014 Apple Inc. All Rights Reserved.
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
##   AuthorizationPlugin.h
##   AuthorizationPlugin -- APIs for implementing authorization plugins.
##

## !
## 	@header AuthorizationPlugin
## 	
## 	The AuthorizationPlugin API allows the creation of plugins that can participate
## 	in authorization decisions.  Using the AuthorizationDB API the system can be configured
## 	to use these plugins.  Plugins are loaded into a separate process, the pluginhost, to
## 	isolate the process of authorization from the client.  There are two types of pluginhosts.
## 	One runs as an anonymous user and can be used to communicate with the user, for example
## 	to ask for a password.  Another one runs with root privileges to perform privileged
## 	operations that may be required.
##
##     A typical use is to implement additional policies that cannot be expressed in the
##     authorization configuration.
##
##     Plugins implement a handshake function called AuthorizationPluginCreate with which
##     their interface (AuthorizationPluginInterface) and the engine's interface
##     (AuthorizationCallbacks) are exchanged.  Plugins are asked to create
##     Mechanisms, which are the basic element as authorizations are performed.
##
##     Mechanisms are invoked when it is time for them to make a decision.  A decision is
##     made by setting a single result (AuthorizationResult).  Mechanisms in the
##     authorization can communicate auxiliary information by setting and/or getting hints
##     and setting and/or getting context data.  Hints are advisory and don't need to be
##     looked at, nor are they preserved as part of the authorization result. Context data
##     becomes part of the result of the authorization.
##
##     Context data is tagged with a flag that describes whether the information is returned
##     to the authorization client upon request (AuthorizationCopyInfo() in Authorization.h)
##     or whether it's private to the mechanisms making a decision.
##
##
## !
## 	@typedef AuthorizationValue
##     Auxiliary data is passed between the engine and the mechanism as AuthorizationValues
##

type
  AuthorizationValue* {.bycopy.} = object
    length*: csize
    data*: pointer


## !
##     @typedef AuthorizationValueVector
##     A vector of AuthorizationValues.  Used to communicate arguments passed from the
##     configuration file <code>authorization(5)</code>.
##

type
  AuthorizationValueVector* {.bycopy.} = object
    count*: UInt32
    values*: ptr AuthorizationValue


## !
##     @typedef
##     Data produced as context during the authorization evaluation is tagged.
##     If data is set to be extractable (kAuthorizationContextFlagExtractable), it will be possible for the client of authorization to obtain the value of this attribute using AuthorizationCopyInfo().
##     If data is marked as volatile (kAuthorizationContextFlagVolatile), this value will not be remembered in the AuthorizationRef.
##     Sticky data (kAuthorizationContextFlagSticky) persists through a failed or interrupted evaluation. It can be used to propagate an error condition from a downstream plugin to an upstream one. It is not remembered in the AuthorizationRef.
##

type
  AuthorizationContextFlags* = UInt32

const
  kAuthorizationContextFlagExtractable* = (1 shl 0)
  kAuthorizationContextFlagVolatile* = (1 shl 1)
  kAuthorizationContextFlagSticky* = (1 shl 2)

## !
## 	@typedef AuthorizationMechanismId
##     The mechanism id specified in the configuration is passed to the plugin to create the appropriate mechanism.
##

type
  AuthorizationMechanismId* = AuthorizationString

## !
##     @typedef AuthorizationPluginId
## 	Not used by plugin writers.  Loaded plugins are identified by their name.
##

type
  AuthorizationPluginId* = AuthorizationString

## !
## 	@typedef AuthorizationPluginRef
## 	Handle passed back by the plugin writer when creating a plugin.  Any pluginhost will only instantiate one instance.  The handle is used when creating mechanisms.
##

type
  AuthorizationPluginRef* = pointer

## !
## 	@typedef AuthorizationMechanismRef
## 	Handle passed back by the plugin writer when creating an an instance of a mechanism in a plugin.  One instance will be created for any authorization.
##

type
  AuthorizationMechanismRef* = pointer

## !
## 	@typedef AuthorizationEngineRef
## 	Handle passed from the engine to an instance of a mechanism in a plugin (corresponds to a particular AuthorizationMechanismRef).
##

type
  AuthorizationEngineRef* = ptr __OpaqueAuthorizationEngine

## !
## 	@typedef AuthorizationSessionId
## 	A unique value for an AuthorizationSession being evaluated, provided by the authorization engine.
##     A session is represented by a top level call to an Authorization API.
##

type
  AuthorizationSessionId* = pointer

## !
##     @enum AuthorizationResult
## 	Possible values for SetResult() in AuthorizationCallbacks.
##
##     @constant kAuthorizationResultAllow the operation succeeded and authorization should be granted as far as this mechanism is concerned.
##     @constant kAuthorizationResultDeny the operation succeeded but authorization should be denied as far as this mechanism is concerned.
##     @constant kAuthorizationResultUndefined the operation failed for some reason and should not be retried for this session.
##     @constant kAuthorizationResultUserCanceled the user has requested that the evaluation be terminated.
##

type
  AuthorizationResult* = UInt32

const
  kAuthorizationResultAllow* = 0
  kAuthorizationResultDeny* = 1
  kAuthorizationResultUndefined* = 2
  kAuthorizationResultUserCanceled* = 3

## !
##     @enum
##     Version of the interface (AuthorizationPluginInterface) implemented by the plugin.
##     The value is matched to the definition in this file.
##

const
  kAuthorizationPluginInterfaceVersion* = 0

## !
##     @enum
##     Version of the callback structure (AuthorizationCallbacks) passed to the plugin.
##     The value is matched to the definition in this file.  The engine may provide a newer
##     interface.
##

const
  kAuthorizationCallbacksVersion* = 4

## !
##     @struct
##     Callback API provided by the AuthorizationEngine.
##
##     @field version      Engine callback version.
##     @field SetResult    Set a result after a call to AuthorizationSessionInvoke.
##     @field RequestInterrupt Request authorization engine to interrupt all mechamisms invoked after this mechamism has called SessionSetResult and then call AuthorizationSessionInvoke again.
##     @field DidDeactivate    Respond to the Deactivate request.
##     @field GetContextValue  Read value from context.  AuthorizationValue does not own data.
##     @field SetContextValue  Write value to context.  AuthorizationValue and data are copied.
##     @field GetHintValue     Read value from hints. AuthorizationValue does not own data.
##     @field SetHintValue     Write value to hints.  AuthorizationValue and data are copied.
##     @field GetArguments     Read arguments passed.  AuthorizationValueVector does not own data.
##     @field GetSessionId     Read SessionId.
##     @field GetLAContext     Returns LAContext which will have LACredentialCTKPIN credential set if PIN is available otherwise context without credentials is returned. LAContext can be used for operations with Tokens which would normally require PIN. Caller owns returned context and is responsible for release.
##     @field GetTokenIdentities   Returns array of identities. Caller owns returned array and is reponsible for release.
##     @field GetTKTokenWatcher    Returns TKTokenWatcher object. Caller owns returned context and is responsible for release.
##     @field RemoveContextValue   Removes value from context.
##     @field RemoveHintValue      Removes value from hints.
##
##

type
  AuthorizationCallbacks* {.bycopy.} = object
    version*: UInt32           ##  Engine callback version.
    ##  Set a result after a call to AuthorizationSessionInvoke.
    SetResult*: proc (inEngine: AuthorizationEngineRef;
                    inResult: AuthorizationResult): OSStatus ##  Request authorization engine to interrupt all mechamisms invoked after
                                                          ##         this mechamism has called SessionSetResult and then call
                                                          ##         AuthorizationSessionInvoke again.
    RequestInterrupt*: proc (inEngine: AuthorizationEngineRef): OSStatus ##  Respond to the Deactivate request.
    DidDeactivate*: proc (inEngine: AuthorizationEngineRef): OSStatus ##  Read value from context.  AuthorizationValue does not own data.
    GetContextValue*: proc (inEngine: AuthorizationEngineRef;
                          inKey: AuthorizationString;
                          outContextFlags: ptr AuthorizationContextFlags;
                          outValue: ptr ptr AuthorizationValue): OSStatus ##  Write value to context.  AuthorizationValue and data are copied.
    SetContextValue*: proc (inEngine: AuthorizationEngineRef;
                          inKey: AuthorizationString;
                          inContextFlags: AuthorizationContextFlags;
                          inValue: ptr AuthorizationValue): OSStatus ##  Read value from hints. AuthorizationValue does not own data.
    GetHintValue*: proc (inEngine: AuthorizationEngineRef;
                       inKey: AuthorizationString;
                       outValue: ptr ptr AuthorizationValue): OSStatus ##  Write value to hints.  AuthorizationValue and data are copied.
    SetHintValue*: proc (inEngine: AuthorizationEngineRef;
                       inKey: AuthorizationString; inValue: ptr AuthorizationValue): OSStatus ##  Read arguments passed.  AuthorizationValueVector does not own data.
    GetArguments*: proc (inEngine: AuthorizationEngineRef;
                       outArguments: ptr ptr AuthorizationValueVector): OSStatus ##  Read SessionId.
    GetSessionId*: proc (inEngine: AuthorizationEngineRef;
                       outSessionId: ptr AuthorizationSessionId): OSStatus ##  Read value from hints. AuthorizationValue does not own data.
    GetImmutableHintValue*: proc (inEngine: AuthorizationEngineRef;
                                inKey: AuthorizationString;
                                outValue: ptr ptr AuthorizationValue): OSStatus ##
                                                                           ## 	 Available only on systems with callback version 2 or higher
                                                                           ## 	 Constructs LAContext object based od actual user credentials,
                                                                           ## 	 userful for kSecUseAuthenticationContext for SecItem calls.
                                                                           ##      Caller is responsible for outValue release
    GetLAContext*: proc (inEngine: AuthorizationEngineRef; outValue: ptr CFTypeRef): OSStatus ##
                                                                                      ## 	 Available only on systems with callback version 2 or higher
                                                                                      ## 	 Returns array of available identities available on tokens. Each array item consists of two
                                                                                      ##      elements. The first one is SecIdentityRef and the second one is textual description of that identity
                                                                                      ## 	 context parameter may contain CFTypeRef returned by GetLAContext.
                                                                                      ##      Caller is responsible for outValue release
    GetTokenIdentities*: proc (inEngine: AuthorizationEngineRef; context: CFTypeRef;
                             outValue: ptr CFArrayRef): OSStatus ##
                                                             ##      Available only on systems with callback version 3 or higher
                                                             ##      Constructs TKTokenWatcher object.
                                                             ##      Caller is responsible for outValue release
    GetTKTokenWatcher*: proc (inEngine: AuthorizationEngineRef;
                            outValue: ptr CFTypeRef): OSStatus ##  Remove value from hints.
    RemoveHintValue*: proc (inEngine: AuthorizationEngineRef;
                          inKey: AuthorizationString): OSStatus ##  Write value to context.
    RemoveContextValue*: proc (inEngine: AuthorizationEngineRef;
                             inKey: AuthorizationString): OSStatus


## !
##     @struct
##     Interface that must be implemented by each plugin.
##
##     @field version  Must be set to kAuthorizationPluginInterfaceVersion
##     @field PluginDestroy    Plugin should clean up and release any resources it is holding.
##     @field MechanismCreate  The plugin should create a mechanism named mechanismId.  The mechanism needs to use the AuthorizationEngineRef for the callbacks and pass back a   AuthorizationMechanismRef for itself.  MechanismDestroy will be called when it is no longer needed.
##     @field MechanismInvoke  Invoke an instance of a mechanism.  It should call SetResult during or after returning from this function.
##     @field MechanismDeactivate  Mechanism should respond with a DidDeactivate as soon as possible
##     @field MechanismDestroy Mechanism should clean up and release any resources it is holding
##

type
  AuthorizationPluginInterface* {.bycopy.} = object
    version*: UInt32           ##  Must be set to kAuthorizationPluginInterfaceVersion.
    ##  Notify a plugin that it is about to be unloaded so it get a chance to clean up and release any resources it is holding.
    PluginDestroy*: proc (inPlugin: AuthorizationPluginRef): OSStatus ##  The plugin should create a mechanism named mechanismId.  The mechanism needs to use the
                                                                 ##         AuthorizationEngineRef for the callbacks and pass back an AuthorizationMechanismRef for
                                                                 ##         itself.  MechanismDestroy will be called when it is no longer needed.
    MechanismCreate*: proc (inPlugin: AuthorizationPluginRef;
                          inEngine: AuthorizationEngineRef;
                          mechanismId: AuthorizationMechanismId;
                          outMechanism: ptr AuthorizationMechanismRef): OSStatus ##  Invoke an instance of a mechanism.  It should call SetResult during or after returning from this function.
    MechanismInvoke*: proc (inMechanism: AuthorizationMechanismRef): OSStatus ##  Mechanism should respond with a DidDeactivate as soon as possible.
    MechanismDeactivate*: proc (inMechanism: AuthorizationMechanismRef): OSStatus ##  Mechanism should clean up and release any resources it is holding.
    MechanismDestroy*: proc (inMechanism: AuthorizationMechanismRef): OSStatus


## !
##     @function AuthorizationPluginCreate
##
##     Initialize a plugin after it gets loaded.  This is the main entry point to a plugin.  This function will only be called once.
##     After all Mechanism instances have been destroyed outPluginInterface->PluginDestroy will be called.
##
##     @param callbacks (input) A pointer to an AuthorizationCallbacks which contains the callbacks implemented by the AuthorizationEngine.
##     @param outPlugin (output) On successful completion should contain a valid AuthorizationPluginRef.  This will be passed in to any subsequent calls the engine makes to  outPluginInterface->MechanismCreate and outPluginInterface->PluginDestroy.
##     @param outPluginInterface (output) On successful completion should contain a pointer to a AuthorizationPluginInterface that will stay valid until outPluginInterface->PluginDestroy is called.

proc AuthorizationPluginCreate*(callbacks: ptr AuthorizationCallbacks;
                               outPlugin: ptr AuthorizationPluginRef;
    outPluginInterface: ptr ptr AuthorizationPluginInterface): OSStatus