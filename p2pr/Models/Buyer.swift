//
//  Buyer.swift
//  p2pr
//
//  Created by Adrian Ruiz on 6/10/23.
//

import Foundation
import SwiftData

@Model
final class Buyer: Identifiable {
    var document: String
    var documentType: String
    var email: String
    var mobile: String
    var name: String
    var surname: String
    var city: String
    var country: String
    var phone: String
    var postalCode: String
    var state: String
    var street: String
    
    init(document: String, documentType: String, email: String, mobile: String, name: String, surname: String, city: String, country: String, phone: String, postalCode: String, state: String, street: String) {
        self.document = document
        self.documentType = documentType
        self.email = email
        self.mobile = mobile
        self.name = name
        self.surname = surname
        self.city = city
        self.country = country
        self.phone = phone
        self.postalCode = postalCode
        self.state = state
        self.street = street
    }
    
    func address() -> String {
        return "\(street), \(city) - \(state), \(country) [\(postalCode)]"
    }
    
    func fullName() -> String {
        return "\(name) \(surname)"
    }
    
    func fullDocument() -> String {
        return "\(documentType) \(document)"
    }
}

extension Buyer {
    static var options: [Buyer] = [
        .init(document: "123456789", documentType: "CC", email: "comprador1@yopmail.com", mobile: "+57 3101234567", name: "Juan", surname: "Perez", city: "Bogotá", country: "Colombia", phone: "1234567", postalCode: "110111", state: "Cundinamarca", street: "Calle 123"),
        .init(document: "987654321", documentType: "CC", email: "comprador2@yopmail.com", mobile: "+57 3209876543", name: "Maria", surname: "Gomez", city: "Medellín", country: "Colombia", phone: "7654321", postalCode: "050101", state: "Antioquia", street: "Carrera 456"),
        .init(document: "567890123", documentType: "CC", email: "comprador3@yopmail.com", mobile: "+57 3005678901", name: "Carlos", surname: "Lopez", city: "Cali", country: "Colombia", phone: "2345678", postalCode: "760202", state: "Valle del Cauca", street: "Avenida 789"),
        .init(document: "234567890", documentType: "CC", email: "comprador4@yopmail.com", mobile: "+57 3102345678", name: "Luisa", surname: "Ramirez", city: "Barranquilla", country: "Colombia", phone: "3456789", postalCode: "080303", state: "Atlántico", street: "Calle 456")
    ]
}
