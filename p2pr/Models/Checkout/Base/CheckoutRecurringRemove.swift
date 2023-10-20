//
//  CheckoutRecurringRemove.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutRecurringRemove: Codable {
    var interval: Int
    var maxPeriods: Int
    var nextPayment: String
    var notificationUrl: String
    var periodicity: String
    
    enum CodingKeys: String, CodingKey {
        case interval, maxPeriods, nextPayment, notificationUrl, periodicity
    }
}
