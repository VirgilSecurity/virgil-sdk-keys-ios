//
//  Jwt.swift
//  VirgilSDK
//
//  Created by Eugen Pivovarov on 1/9/18.
//  Copyright © 2018 VirgilSecurity. All rights reserved.
//

import Foundation

/// Class implementing `AccessToken` in terms of Virgil JWT
@objc(VSSJwt) public final class Jwt: NSObject, AccessToken {
    @objc(VSSJwtError) public enum JwtError: Int, Error {
        case incorrectNumberOfJwtComponents = 1
        case utf8StrIsInvalid = 2
    }
    
    /// Represents JWT Header content
    @objc public let headerContent: JwtHeaderContent
    /// Represents JWT Body content
    @objc public let bodyContent: JwtBodyContent
    /// Signature data
    @objc public let signatureContent: JwtSignatureContent

    /// Initializes `Jwt` with provided header, body and signature content
    ///
    /// - Parameters:
    ///   - headerContent: header of `Jwt`
    ///   - bodyContent: body of `Jwt`
    ///   - signatureContent: Data with signature content
    @objc public init(headerContent: JwtHeaderContent, bodyContent: JwtBodyContent, signatureContent: JwtSignatureContent) throws {
        self.headerContent = headerContent
        self.bodyContent = bodyContent
        self.signatureContent = signatureContent

        super.init()
    }

    /// Initializes `Jwt` from its string representation
    ///
    /// - Parameter stringRepresentation: must be equal to
    ///   base64UrlEncode(JWT Header) + "." + base64UrlEncode(JWT Body) + "." + base64UrlEncode(Jwt Signature)
    @objc public init(stringRepresentation: String) throws {
        let array = stringRepresentation.components(separatedBy: ".")

        guard array.count == 3 else {
            throw JwtError.incorrectNumberOfJwtComponents
        }
        
        let headerBase64Url = array[0]
        let bodyBase64Url = array[1]
        let signatureBase64Url = array[2]

        self.headerContent = try JwtHeaderContent(base64UrlEncoded: headerBase64Url)
        self.bodyContent = try JwtBodyContent(base64UrlEncoded: bodyBase64Url)
        self.signatureContent = try JwtSignatureContent(base64UrlEncoded: signatureBase64Url)

        super.init()
    }
    
    @objc public func dataToSign() throws -> Data {
        return try Jwt.dataToSign(headerContent: self.headerContent, bodyContent: self.bodyContent)
    }
    
    @objc public static func dataToSign(headerContent: JwtHeaderContent, bodyContent: JwtBodyContent) throws -> Data {
        guard let data = "\(headerContent.stringRepresentation).\(bodyContent.stringRepresentation)".data(using: .utf8) else {
            throw JwtError.utf8StrIsInvalid
        }
        
        return data
    }

    /// Provides string representation of token
    ///
    /// - Returns: string representation of token
    @objc public func stringRepresentation() -> String {
        return "\(self.headerContent.stringRepresentation).\(self.bodyContent.stringRepresentation).\(self.signatureContent.stringRepresentation)"
    }

    /// Extracts identity
    ///
    /// - Returns: identity
    @objc public func identity() -> String {
        return self.bodyContent.identity
    }

    /// Returns whether or not token is expired
    ///
    /// - Returns: true if token is expired, false otherwise
    @objc public func isExpired() -> Bool {
        return Date() >= self.bodyContent.expiresAt
    }
}
