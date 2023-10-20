//
//  Detail.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation
import SwiftData

@Model
final class Detail: Identifiable {
    var id: String
    var amount: Double
    var kind: String
    
    init(amount: Double, kind: String) {
        self.id = UUID().uuidString
        self.amount = amount
        self.kind = kind
    }
}
