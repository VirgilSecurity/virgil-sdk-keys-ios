//
//  VSSCardsError.m
//  VirgilKeysSDK
//
//  Created by Pavel Gorb on 9/12/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSCardsError.h"

/// HTTP 500. Server error status is returned on internal application errors
const NSInteger kVSSCardsInternalError                               = 10000;

/// HTTP 401. Authorization errors
const NSInteger kVSSCardsTokenMissingOrInvalidError                  = 20300;
const NSInteger kVSSCardsAuthenticatorError                          = 20301;
const NSInteger kVSSCardsAccessTokenValidationError                  = 20302;
const NSInteger kVSSCardsApplicationNotFoundError                    = 20303;
const NSInteger kVSSCardsRequestSignMissingOrInvalid                 = 20400;
const NSInteger kVSSCardsRequestSignHeaderMissingError               = 20401;

/// HTTP 403. Forbidden
const NSInteger kVSSCardsCardNotAvailableError                       = 20500;

/// HTTP 400. Request error status is returned on request data validation errors
const NSInteger kVSSCardsJSONError                                   = 30000;
const NSInteger kVSSCardsDataInconsistencyEror                       = 30010;
const NSInteger kVSSCardsGlobalCardIdentityTypeError                 = 30100;
const NSInteger kVSSCardsCardScopeError                              = 30101;
const NSInteger kVSSCardsCardIdValidationFailedError                 = 30102;
const NSInteger kVSSCardsCardDataTooBigError                         = 30103;
const NSInteger kVSSCardsCardInfoParameterEmptyError                 = 30104;
const NSInteger kVSSCardsCardInfoParameterTooBigError                = 30105;
const NSInteger kVSSCardsCardDataParameterError                      = 30106;
const NSInteger kVSSCardsCSRParameterMissingOrInvalidError           = 30107;
const NSInteger kVSSCardsIdentitiesError                             = 30111;
const NSInteger kVSSCardsIdentityTypeError                           = 30113;
const NSInteger kVSSCardsSegregatedIdentityError                     = 30114;
const NSInteger kVSSCardsIdentityEmailError                          = 30115;
const NSInteger kVSSCardsIdentityApplicationError                    = 30116;
const NSInteger kVSSCardsPublicKeyLengthError                        = 30117;
const NSInteger kVSSCardsPublicKeyFormatError                        = 30118;
const NSInteger kVSSCardsCardDataParameterKVError                    = 30119;
const NSInteger kVSSCardsCardDataParameterStrError                   = 30120;

const NSInteger kVSSCardsDataTooBigError                             = 30121;
const NSInteger kVSSCardsValidationTokenError                        = 30122;
const NSInteger kVSSCardsCSRSignsMissingOrInvalidError               = 30123;
const NSInteger kVSSCardsCSRIdIrrelevantError                        = 30126;
const NSInteger kVSSCardsCSRInvalidForVirgilCardPublicKeyError       = 30127;
const NSInteger kVSSCardsCSRDigestMissingOrInvalidError              = 30128;
const NSInteger kVSSCardsCardIdMismatchError                         = 30131;
const NSInteger kVSSCardsCardDataKeysError                           = 30134;
const NSInteger kVSSCardsTokenObjectError                            = 30135;
const NSInteger kVSSCardsCSRSignForIdentityServiceError              = 30136;
const NSInteger kVSSCardsGlobalCardUnconfirmedError                  = 30137;
const NSInteger kVSSCardsDuplicateFingerprintError                   = 30138;
const NSInteger kVSSCardsRevocationReasonMissingOrInvalidError       = 30139;

@implementation VSSCardsError

- (NSString *)message {
    NSString *message = nil;
    
    switch (self.code) {
        case kVSSCardsInternalError: message = @"Internal application error. You know, shit happens, so do internal server errors. Just take a deep breath and try harder."; break;
        
        /// HTTP 401. Authorization errors
        case kVSSCardsTokenMissingOrInvalidError: message = @"The Virgil access token or token header was not specified or is invalid"; break;
        case kVSSCardsAuthenticatorError: message = @"The Virgil authenticator service responded with an error"; break;
        case kVSSCardsAccessTokenValidationError: message = @"The Virgil access token validation has failed on the Virgil Authenticator service"; break;
        case kVSSCardsApplicationNotFoundError: message = @"The application was not found for the access token"; break;
        case kVSSCardsRequestSignMissingOrInvalid: message = @"Request sign is invalid or missing"; break;
        case kVSSCardsRequestSignHeaderMissingError: message = @"Request sign header is missing"; break;
        
        /// HTTP 401. Authorization errors
        case kVSSCardsCardNotAvailableError: message = @"The Virgil Card is not available in this application"; break;
        
        /// HTTP 400. Request error status is returned on request data validation errors
        case kVSSCardsJSONError: message = @"JSON specified as a request is invalid"; break;
        case kVSSCardsDataInconsistencyEror: message = @"A data inconsistency error"; break;
        case kVSSCardsGlobalCardIdentityTypeError: message = @"Global Virgil Card identity type is invalid, because it can be only an 'email'"; break;
        case kVSSCardsCardScopeError: message = @"Virgil Card scope must be either 'global' or 'application'"; break;
        case kVSSCardsCardIdValidationFailedError: message = @"Virgil Card id validation failed"; break;
        case kVSSCardsCardDataTooBigError: message = @"Virgil Card data parameter cannot contain more than 16 entries"; break;
        case kVSSCardsCardInfoParameterEmptyError: message = @"Virgil Card info parameter cannot be empty if specified and must contain 'device' and/or 'device_name' key"; break;
        case kVSSCardsCardInfoParameterTooBigError: message = @"Virgil Card info parameters length validation failed. The length cannot exceed 256 characters"; break;
        case kVSSCardsCardDataParameterError: message = @"Virgil Card data parameter must be an associative array (https://en.wikipedia.org/wiki/Associative_array)"; break;
        case kVSSCardsCSRParameterMissingOrInvalidError: message = @"A CSR parameter (content_snapshot) parameter is missing or is incorrect"; break;
        case kVSSCardsIdentitiesError: message = @"Virgil Card identities passed to search endpoint must be a list of non-empty strings"; break;
        case kVSSCardsIdentityTypeError: message = @"Virgil Card identity type is invalid"; break;
        case kVSSCardsSegregatedIdentityError: message = @"Segregated Virgil Card custom identity value must be a not empty string"; break;
        case kVSSCardsIdentityEmailError: message = @"Virgil Card identity email is invalid"; break;
        case kVSSCardsIdentityApplicationError: message = @"Virgil Card identity application is invalid"; break;
        case kVSSCardsPublicKeyLengthError: message = @"Public key length is invalid. It goes from 16 to 2048 bytes"; break;
        case kVSSCardsPublicKeyFormatError: message = @"Public key must be base64-encoded string"; break;
        case kVSSCardsCardDataParameterKVError: message = @"Virgil Card data parameter must be a key/value list of strings"; break;
        case kVSSCardsCardDataParameterStrError: message = @"Virgil Card data parameters must be strings"; break;
        case kVSSCardsDataTooBigError: message = @"Virgil Card custom data entry value length validation failed. It mustn't exceed 256 characters"; break;
        case kVSSCardsValidationTokenError: message = @"Identity validation token is invalid"; break;
        case kVSSCardsCSRSignsMissingOrInvalidError: message = @"SCR signs list parameter is missing or is invalid"; break;
        case kVSSCardsCSRIdIrrelevantError: message = @"SCR sign item signer card id is irrelevant and doesn't match Virgil Card id or Application Id"; break;
        case kVSSCardsCSRInvalidForVirgilCardPublicKeyError: message = @"SCR sign item signed digest is invalid for the Virgil Card public key"; break;
        case kVSSCardsCSRDigestMissingOrInvalidError: message = @"SCR sign item signed digest is invalid or missing for the application"; break;
        case kVSSCardsCardIdMismatchError: message = @"Virgil Card id specified in the request body must match with the one passed in the URL"; break;
        case kVSSCardsCardDataKeysError: message = @"Virgil Card data parameters key must be alphanumerical"; break;
        case kVSSCardsTokenObjectError: message = @"Virgil Card validation token must be an object with value parameter"; break;
        case kVSSCardsCSRSignForIdentityServiceError: message = @"SCR sign item signed digest is invalid for the virgil identity service"; break;
        case kVSSCardsGlobalCardUnconfirmedError: message = @"Global Virigl Card cannot be created unconfirmed (which means that Virgil Identity service sign is mandatory)"; break;
        case kVSSCardsDuplicateFingerprintError: message = @"Virigl Card with the same fingerprint exists already"; break;
        case kVSSCardsRevocationReasonMissingOrInvalidError: message = @"Virigl Card revocation reason isn't specified or is invalid"; break;
    }

    return message;
}

@end