//
//  ResultExtension.swift
//  p2pr
//
//  Created by Adrian Ruiz on 3/10/23.
//

import Foundation

struct ResultError: Result {
    enum ErrorKind {
        case networkError(String, Int)
        case decodingError(String, Int)
    }
    
    let error: ErrorKind
}

