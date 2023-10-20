//
//  CheckoutInformationRequest.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutInformationRequest: Codable {
    var auth: CheckoutAuth
    
    enum CodingKeys: String, CodingKey {
        case auth
    }
    
    init() {
        self.auth = .init(login: ProcessInfo.processInfo.environment[LOGIN_CHECKOUT]!, secretKey: ProcessInfo.processInfo.environment[SECRET_KEY_CHECKOUT]!)
    }
}
