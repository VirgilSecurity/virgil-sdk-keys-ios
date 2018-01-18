//
//  JwtGenerator.swift
//  VirgilSDK
//
//  Created by Eugen Pivovarov on 1/15/18.
//  Copyright © 2018 VirgilSecurity. All rights reserved.
//

import Foundation
import VirgilCryptoAPI

@objc(VSSJwtGenerator) public class JwtGenerator: NSObject {
    private let apiKey: PrivateKey
    private let apiPublicKeyIdentifier: String
    private let accessTokenSigner: AccessTokenSigner
    private let appId: String
    private let ttl: TimeInterval
    
    @objc public init(apiKey: PrivateKey, apiPublicKeyIdentifier: String, accessTokenSigner: AccessTokenSigner, appId: String, ttl: TimeInterval) {
        self.apiKey = apiKey
        self.apiPublicKeyIdentifier = apiPublicKeyIdentifier
        self.accessTokenSigner = accessTokenSigner
        self.appId = appId
        self.ttl = ttl
        
        super.init()
    }
    
    @objc public func generateToken(identity: String, additionalData: [String: String] = [:]) throws -> Jwt {
        let jwtHeaderContent = JwtHeaderContent(keyIdentifier: self.apiPublicKeyIdentifier)
        let jwtBodyContent   = JwtBodyContent(appId: self.appId, identity: identity, expiresAt: Date() + self.ttl, issuedAt: Date(), additionalData: additionalData)
        
        let jwt = Jwt(headerContent: jwtHeaderContent, bodyContent: jwtBodyContent)
        
        jwt.signatureContent =  try self.accessTokenSigner.generateTokenSignature(of: jwt.snapshotWithoutSignatures(), using: self.apiKey)
        
        return jwt
    }
}

