//
//  Item.swift
//  p2pr
//
//  Created by Adrian Ruiz on 28/09/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
