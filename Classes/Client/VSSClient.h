//
//  VKKeysClient.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSSModelCommons.h"
#import "VSSClientProtocol.h"

#ifdef DEBUG
#define USE_SERVICE_CLIENT_DEBUG 1
#endif

/// Debugging macro
#if USE_SERVICE_CLIENT_DEBUG
#  define VSSCLDLog(...) NSLog(__VA_ARGS__)
# else
#  define VSSCLDLog(...) /* nothing to log */
#endif

#import "VSSServiceConfig.h"

extern NSString * __nonnull const kVSSClientErrorDomain;

/**
 * The Virgil Service Client handles all the interactions with the Virgil Services.
 */
@interface VSSClient : NSObject <VSSClient>

/**
 * String token which might be required by the service.
 */
@property (nonatomic, copy, readonly) NSString * __nonnull token;

/**
 * Service configuration object, which contains the information about the service URLs and/or service identifiers.
 */
@property (nonatomic, copy, readonly) VSSServiceConfig * __nonnull serviceConfig;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 * Creates instance of VSSClient particular class.
 *
 * @param token NSString containing application token received from https://developer.virgilsecurity.com/dashboard/
 * @param serviceConfig Object containing the service configuration. When nil - the default Virgil Service configuration will be used.
 *
 * @return Instance of the Virgil client.
 */
- (instancetype __nonnull)initWithApplicationToken:(NSString * __nonnull)token serviceConfig:(VSSServiceConfig * __nullable)serviceConfig NS_DESIGNATED_INITIALIZER;

/**
 * Convenient constructor.
 * Creates instance of VSSClient particular class.
 * Call to this method is a shortcut for the initWithApplicationToken:serviceConfig: when serviceConfig is nil.
 *
 * @param token NSString containing application token received from https://developer.virgilsecurity.com/dashboard/
 *
 * @return Instance of the Virgil client.
 */
- (instancetype __nonnull)initWithApplicationToken:(NSString * __nonnull)token;

@end