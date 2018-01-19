//
//  JwtGeneratorAccessTokenProvider.swift
//  VirgilSDK
//
//  Created by Eugen Pivovarov on 1/15/18.
//  Copyright © 2018 VirgilSecurity. All rights reserved.
//

import Foundation

@objc(VSSGeneratorJwtProvider) public class GeneratorJwtProvider: NSObject, AccessTokenProvider {
    private let jwtGenerator: JwtGenerator
    private let identity: String
    private let additionalData: [String : String]
    
    @objc public init(jwtGenerator: JwtGenerator, identity: String, additionalData: [String : String] = [:]) {
        self.identity = identity
        self.additionalData = additionalData
        self.jwtGenerator = jwtGenerator
        
        super.init()
    }
    
    @objc public func getToken(forceReload: Bool) throws -> AccessToken {
        return try self.jwtGenerator.generateToken(identity: self.identity, additionalData: self.additionalData)
    }
}