//
//  ReceiptViewModel.swift
//  p2pr
//
//  Created by Adrian Ruiz on 10/10/23.
//

import Foundation
import UIKit

class ReceiptViewModel: ObservableObject {
    private var repository: CheckoutRepository = CheckoutPaymentRepository(baseUrl: ProcessInfo.processInfo.environment[ENVIRONMENT_CHECKOUT]!)
    
    @Published private(set) var response: CheckoutInformationResponse? = nil
    @Published private(set) var error: String? = nil
    
    @MainActor
    func getSession(requestId: Int) async {
        self.response = nil
        await repository.searchSession(sessionId: requestId) { (result) in
            
            if let error = result as? ResultError {
                switch error.error  {
                case .decodingError(let error, _):
                    self.error = error
                case .networkError(let error, _):
                    self.error = error
                }
                return
            }
            
            if let data = result as? CheckoutInformationResponse {
                self.response = data
            }
        }
    }
}
