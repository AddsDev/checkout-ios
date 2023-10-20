//
//  Session.swift
//  p2pr
//
//  Created by Adrian Ruiz on 6/10/23.
//

import Foundation
import SwiftData

@Model
final class History: Identifiable {
    var sessionId: Int
    var status: String
    var redirectionUrl: String
    var detail: String
    var buyer: String
    var date: String?
    
    init(sessionId: Int, status: String, redirectionUrl: String, detail: String, buyer: String, date: String?) {
        self.sessionId = sessionId
        self.status = status
        self.redirectionUrl = redirectionUrl
        self.date = date
        self.detail = detail
        self.buyer = buyer
    }
}
