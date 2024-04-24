//
//  Logger.swift
//  p2pr
//
//  Created by Adrian Ruiz on 23/04/24.
//

import Foundation

func printDebug(_ string: String) {
    #if DEBUG
        print("--------------")
        print(string)
    #endif
}
