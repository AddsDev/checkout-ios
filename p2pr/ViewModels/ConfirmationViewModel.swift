//
//  HomeViewModel.swift
//  p2pr
//
//  Created by Adrian Ruiz on 4/10/23.
//

import Foundation
import UIKit
import AppTrackingTransparency
import AdSupport

enum TrackingPersmissionStatus: String {
    case authorized
    case denied
    case notDetermined
    case unknown
}


class ConfirmationViewModel: ObservableObject {
    private var repository: CheckoutRepository = CheckoutPaymentRepository(baseUrl: ProcessInfo.processInfo.environment[ENVIRONMENT_CHECKOUT]!)
    @Published private(set) var response: CheckoutPaymentResponse? = nil
    @Published private(set) var error: String? = nil
    var trackingModelStatus: TrackingPersmissionStatus = .notDetermined
    var trackingManagerStatus: ATTrackingManager.AuthorizationStatus {
       return ATTrackingManager.trackingAuthorizationStatus
    }
    
    init() {
        updateCurrentStatus()
    }
    
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
    
    func shouldShowAppTrackingDialog() -> Bool {
        let status = ATTrackingManager.trackingAuthorizationStatus
        guard status != .notDetermined else {
           return true
        }
        return false
    }
    
    func isAuthorized() -> Bool {
        return trackingManagerStatus == .authorized
    }
    
    func requestAppTrackingPermission(_ completion: @escaping (ATTrackingManager.AuthorizationStatus) -> Void) {
        ATTrackingManager.requestTrackingAuthorization(completionHandler: completion)
    }
    
    
    func updateCurrentStatus()  {
        let status = ATTrackingManager.trackingAuthorizationStatus
        switch status {
        case .authorized:
            // racking authorization dialog was shown and we are authorized
            printDebug("Tracking - Authorized")
            trackingModelStatus = .authorized
        case .denied:
            // Tracking authorization dialog was shown and permission is denied
            printDebug("Tracking - Denied")
            trackingModelStatus = .denied
        case .notDetermined:
            // Tracking authorization dialog has not been shown
            printDebug("Tracking - Not Determined")
            trackingModelStatus = .notDetermined
        case .restricted:
            printDebug("Tracking - Restricted")
            trackingModelStatus = .denied
        @unknown default:
            printDebug("Tracking - Unknown")
            trackingModelStatus = .unknown
        }
    }
}
