//
//  CheckouRepository.swift
//  p2pr
//
//  Created by Adrian Ruiz on 6/10/23.
//

import Foundation

protocol CheckoutRepository {
    func createSession(package: WelcomePackage, buyer: Buyer, ipAddress: String, handler: @escaping (Result) -> Void) async
    func searchSession(sessionId: Int, handler: @escaping (Result) -> Void) async
}

class CheckoutPaymentRepository: CheckoutRepository {
    var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func createSession(package: WelcomePackage, buyer: Buyer, ipAddress: String, handler: @escaping (Result) -> Void) async {
        do {
            let paymentRequest:CheckoutPaymentRequest = .init(package: package, buyer: buyer, ipAddress: ipAddress)
            let body = try JSONEncoder().encode(paymentRequest)
            
            try await RequestManager().request(
                from: baseUrl + "/api/session",
                decodeType: CheckoutPaymentResponse.self,
                method: .post,
                body: body,
                completionHandler: handler
            )
        } catch _ {
            handler(ResultError(error: .networkError("Error connecting to server", 500)))
        }
    }
    
    func searchSession(sessionId: Int, handler: @escaping (Result) -> Void) async {
        do {
            
            let body = try JSONEncoder().encode(CheckoutInformationRequest())
            
            try await RequestManager().request(
                from: baseUrl + "/api/session/\(sessionId)",
                decodeType: CheckoutInformationResponse.self,
                method: .post,
                body: body,
                completionHandler: handler
            )
        } catch _ {
            handler(ResultError(error: .networkError("Error connecting to server", 500)))
        }
    }
}

