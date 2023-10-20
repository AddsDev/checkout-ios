//
//  CheckoutPaymentRequest.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutPaymentRequest: Codable, Equatable {
    static func == (lhs: CheckoutPaymentRequest, rhs: CheckoutPaymentRequest) -> Bool {
        return lhs.auth?.seed == rhs.auth?.seed
    }
    
    var auth: CheckoutAuth?
    var buyer: CheckoutBuyer?
    var cancelUrl: String?
    var captureAddress:Bool? = false
    var expiration: String
    var fields: [CheckoutField]?
    var locale: String
    var noBuyerFill: Bool? = false
    var payment: CheckoutPayment?
    var returnUrl: String
    var ipAddress: String
    var skipResult: Bool? = false
    var userAgent = USER_AGENT
    
    enum CodingKeys: String, CodingKey {
        case auth, buyer, cancelUrl, captureAddress, expiration, fields, locale, noBuyerFill, payment, returnUrl, ipAddress, skipResult, userAgent
    }

    init(package: WelcomePackage, buyer: Buyer, ipAddress: String) {
        self.auth = .init(login: ProcessInfo.processInfo.environment[LOGIN_CHECKOUT]!, secretKey: ProcessInfo.processInfo.environment[SECRET_KEY_CHECKOUT]!)
        self.buyer = .init(buyer: buyer)
        self.cancelUrl = CANCEL_URL
        self.expiration = Calendar.autoupdatingCurrent.date(byAdding: .day, value: 1, to: Date())!.toString()
        self.fields = nil
        self.locale = "es_CO"
        self.payment = .init(package: package, buyer: buyer)
        self.returnUrl = RETURN_URL
        self.ipAddress = ipAddress
    }
}
