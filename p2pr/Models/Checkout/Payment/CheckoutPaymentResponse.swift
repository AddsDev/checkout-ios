//
//  CheckoutPaymentResponse.swift
//  p2pr
//
//  Created by Adrian Ruiz on 6/10/23.
//

import Foundation

class CheckoutPaymentResponse: Decodable, Result , Equatable {
    
    static func == (lhs: CheckoutPaymentResponse, rhs: CheckoutPaymentResponse) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    var status: CheckoutStatus
    var requestId: Int?
    var processUrl: String?
    var date: String?
}
