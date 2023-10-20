//
//  UIExtension.swift
//  p2pr
//
//  Created by Adrian Ruiz on 10/10/23.
//

import Foundation


extension Date {
    
    func toString(format: String = DATE_UTC_FORMAT, timeZone: String = TIME_ZONE) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: timeZone)
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
    
}

extension String {
    func toDate(format: String = DATE_UTC_FORMAT_RESPONSE) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let newDate = formatter.date(from: self) {
            return newDate
        } else {
            return Date()
        }
    }
}
