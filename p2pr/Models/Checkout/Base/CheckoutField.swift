//
//  CheckoutField.swift
//  p2pr
//
//  Created by Adrian Ruiz on 5/10/23.
//

import Foundation

struct CheckoutField: Codable {
    var displayOn: String
    var keyword: String
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case displayOn, keyword, value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.displayOn = try container.decode(String.self, forKey: .displayOn)
        self.keyword = try container.decode(String.self, forKey: .keyword)
        do {
            self.value = try container.decode(String.self, forKey: .value)
        } catch _ {
            self.value = try String(container.decode(Int.self, forKey: .value))
        }

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(displayOn, forKey: .displayOn)
        try container.encode(keyword, forKey: .keyword)
        try container.encode(value, forKey: .value)
    }
}
