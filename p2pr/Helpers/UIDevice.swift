//
//  UIDevice.swift
//  p2pr
//
//  Created by Adrian Ruiz on 6/10/23.
//

import UIKit
import Foundation

extension UIDevice {
    func gepIP() -> String {
        var address = ""
        var addrList : UnsafeMutablePointer<ifaddrs>?
            guard
                getifaddrs(&addrList) == 0,
                let firstAddr = addrList
            else { return address }
            defer { freeifaddrs(addrList) }
            for cursor in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                if let addr = cursor.pointee.ifa_addr,
                    getnameinfo(addr, socklen_t(addr.pointee.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0,
                    hostname[0] != 0
                {
                    address = String(cString: hostname)
                    break
                }
            }
        printDebug(address)
        return address
    }
}
