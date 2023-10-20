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
    private var checkoutUrl: URL
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        self.checkoutUrl = URL(string: baseUrl + "/api/session")!
    }
    
    //MARK - setup validation response
    func createSession(package: WelcomePackage, buyer: Buyer, ipAddress: String, handler: @escaping (Result) -> Void) async {
        do {
            let paymentRequest:CheckoutPaymentRequest = .init(package: package, buyer: buyer, ipAddress: ipAddress)
            let body = try JSONEncoder().encode(paymentRequest)
            
            try await RequestManager().request(
                from: checkoutUrl,
                decodeType: CheckoutPaymentResponse.self,
                method: .post,
                body: body,
                completionHandler: handler
            )
        } catch _ {
            handler(ResultError(error: .networkError("Error connecting to server", 500)))
        }
    }
    
    //MARK - setup validation response
    func searchSession(sessionId: Int, handler: @escaping (Result) -> Void) async {
        do {
            var url = URLComponents(url: checkoutUrl, resolvingAgainstBaseURL: true)
            url?.path = "/api/session/\(sessionId)"
            
            let body = try JSONEncoder().encode(CheckoutInformationRequest())
            
            try await RequestManager().request(
                from: url!.url!,
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

