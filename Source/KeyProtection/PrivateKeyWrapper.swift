//
// Copyright (C) 2015-2019 Virgil Security Inc.
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     (1) Redistributions of source code must retain the above copyright
//     notice, this list of conditions and the following disclaimer.
//
//     (2) Redistributions in binary form must reproduce the above copyright
//     notice, this list of conditions and the following disclaimer in
//     the documentation and/or other materials provided with the
//     distribution.
//
//     (3) Neither the name of the copyright holder nor the names of its
//     contributors may be used to endorse or promote products derived from
//     this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR ''AS IS'' AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
// IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//
// Lead Maintainer: Virgil Security Inc. <support@virgilsecurity.com>
//

import Foundation
import VirgilCrypto

// swiftlint:disable force_unwrapping

/// Class that wraps either plain private key or biometrically protected key
public class PrivateKeyWrapper {
    private enum WrappedKey {
        case plain(VirgilPrivateKey)
    #if os(iOS)
        case protected(ProtectedKey)
    #endif
    }

    /// Key type
    public let type: PrivateKeyWrapperType
    private let wrappedKey: WrappedKey
    private var publicKey: VirgilPublicKey?
    private let crypto: VirgilCrypto?

    /// Init
    /// - Parameters:
    ///   - privateKey: plain private key
    ///   - crypto: VirgilCrypto
    public init(privateKey: VirgilPrivateKey, crypto: VirgilCrypto) {
        self.wrappedKey = .plain(privateKey)
        self.publicKey = nil
        self.crypto = crypto
        self.type = .plainKey
    }

    /// Init
    /// - Parameter keyPair: Plain keypair
    public init(keyPair: VirgilKeyPair) {
        self.wrappedKey = .plain(keyPair.privateKey)
        self.publicKey = keyPair.publicKey
        self.crypto = nil
        self.type = .plainKey
    }

#if os(iOS)
    /// Init
    /// - Parameters:
    ///   - protectedKey: Protected key
    ///   - crypto: VirgilCrypto
    public init(protectedKey: ProtectedKey, crypto: VirgilCrypto) {
        self.wrappedKey = .protected(protectedKey)
        self.publicKey = nil
        self.crypto = crypto
        self.type = .biometricKey
    }

    /// Init
    /// - Parameters:
    ///   - protectedKey: protected key
    ///   - publicKey: public key
    ///   - crypto: VirgilCrypto
    public init(protectedKey: ProtectedKey, publicKey: VirgilPublicKey, crypto: VirgilCrypto) {
        self.wrappedKey = .protected(protectedKey)
        self.publicKey = publicKey
        self.crypto = crypto
        self.type = .biometricKey
    }
#endif

    /// Returns key pair
    public func getKeyPair() throws -> VirgilKeyPair {
        switch self.wrappedKey {
        case .plain(let privateKey):
            if let publicKey = self.publicKey {
                return VirgilKeyPair(privateKey: privateKey, publicKey: publicKey)
            }
            else {
                let publicKey = try self.crypto!.extractPublicKey(from: privateKey)
                self.publicKey = publicKey
                return VirgilKeyPair(privateKey: privateKey, publicKey: publicKey)
            }
    #if os(iOS)
        case .protected(let protectedKey):
            let keychainEntry = try protectedKey.getKeychainEntry()
            let keyPair = try crypto!.importPrivateKey(from: keychainEntry.data)
            self.publicKey = keyPair.publicKey
            return keyPair
    #endif
        }
    }

    /// Returns private key
    public func getPrivateKey() throws -> VirgilPrivateKey {
        switch self.wrappedKey {
        case .plain(let privateKey):
            return privateKey
    #if os(iOS)
        case .protected:
            return try self.getKeyPair().privateKey
    #endif
        }
    }

    /// Returns public key
    public func getPublicKey() throws -> VirgilPublicKey {
        if let publicKey = self.publicKey {
            return publicKey
        }

        return try self.getKeyPair().publicKey
    }
}

// swiftlint:enable force_unwrapping