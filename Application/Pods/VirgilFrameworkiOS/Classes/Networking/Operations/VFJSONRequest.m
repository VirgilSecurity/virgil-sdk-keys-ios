//
//  VFJSONRequest.m
//  VirgilFramework
//
//  Created by Pavel Gorb on 9/11/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VFJSONRequest.h"
#import "NSObject+VFUtils.h"

@implementation VFJSONRequest

#pragma mark - Class logic

- (void)setRequestBodyWithObject:(NSDictionary *)dto useUUID:(NSNumber *)useUUID {
    NSMutableDictionary *candidate = [[NSMutableDictionary alloc] init];
    [candidate addEntriesFromDictionary:dto];
    if ([useUUID boolValue]) {
        candidate[@"request_sign_uuid"] = self.uuid;
    }
    
    if (![NSJSONSerialization isValidJSONObject:candidate]) {
        VFSRDLog(@"Invalid object for JSON serialization of the request body: '%@'", [candidate description]);
        return;
    }
    
    NSError *serializationError = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:candidate options:0 error:&serializationError];
    if (serializationError != nil) {
        VFSRDLog(@"Unable to serialize request body: '%@'", [serializationError localizedDescription]);
        return;
    }
    
    [self setRequestBody:body];
}

#pragma mark - Overrides

- (void)start {
    [self setRequestHeaders:@{ @"Content-Type": @"application/json" }];
    [super start];
}

- (NSObject *)parseResponse {
    // If there is no response body data at all - nothing to parse.
    if (self.responseBody == nil) {
        return nil;
    }
    // If response data exists, but empty - nothing to parse,
    if (self.responseBody.length == 0) {
        // return empty JSON object
        return @{};
    }
    
    NSError *parseError = nil;
    NSObject *candidate = [NSJSONSerialization JSONObjectWithData:self.responseBody options:NSJSONReadingAllowFragments error:&parseError];
    if (parseError != nil) {
        return parseError;
    }
    
    return candidate;
}

@end
