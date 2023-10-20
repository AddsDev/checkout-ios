//
//  CheckoutAuth.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation
import CryptoKit

class CheckoutAuth: Codable {
    var login: String
    private(set) var nonce: String
    private(set) var seed: String
    private(set) var tranKey: String
    
    enum CodingKeys: String, CodingKey {
        case login, nonce, seed, tranKey
    }
    
    init(login: String, secretKey: String) {
        self.login = login
        self.seed = ""
        self.nonce = ""
        self.tranKey = ""
        self.generateAuth(secretKey: secretKey)
    }
    
    private func generateAuth(secretKey: String) {
        let rawNonce = UInt64.random(in: 0..<1000000)
        self.seed = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: .withInternetDateTime)
        let hashedData = SHA256.hash(data: "\(rawNonce)\(self.seed)\(secretKey)".data(using: .utf8)!)
        self.tranKey = Data(hashedData).base64EncodedString()
        self.nonce = Data(String(rawNonce).utf8).base64EncodedString()
    }
    
}
