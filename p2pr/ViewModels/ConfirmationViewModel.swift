//
//  HomeViewModel.swift
//  p2pr
//
//  Created by Adrian Ruiz on 4/10/23.
//

import Foundation
import UIKit

class ConfirmationViewModel: ObservableObject {
    private var repository: CheckoutRepository = CheckoutPaymentRepository(baseUrl: ProcessInfo.processInfo.environment[ENVIRONMENT_CHECKOUT]!)
    @Published private(set) var response: CheckoutPaymentResponse? = nil
    @Published private(set) var error: String? = nil
    
    func createSession(package: WelcomePackage, buyer: Buyer) async {
        await repository.createSession(package: package, buyer: buyer, ipAddress: UIDevice().gepIP()) { (result) in
            
            if let error = result as? ResultError {
                switch error.error  {
                case .decodingError(let error, _):
                    self.error = error
                case .networkError(let error, _):
                    self.error = error
                }
                return
            }
            
            if let data = result as? CheckoutPaymentResponse {
                self.response = data
            }
        }
    }
}
