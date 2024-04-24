//
//  APIManager.swift
//  p2pr
//
//  Created by Adrian Ruiz on 3/10/23.
//

import Foundation
import Combine


final class RequestManager {
    
    private var cancelable: AnyCancellable?
    private static let sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    func request<T: Decodable>(
        from url: String,
        decodeType: T.Type,
        method: HTTPMethod = .get,
        body: Data?,
        completionHandler: @escaping (Result) -> Void
    ) async throws {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Accept-Language": "es_CO"
        ]
        
        let decoder = JSONDecoder()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        decoder.allowsJSON5 = true
            
        cancelable = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: Self.sessionProcessingQueue)
            .map({
                printDebug("\(String(data: $0.data, encoding: String.Encoding.utf8) ?? "Data could not be printed")")
                return $0.data
            })
            .decode(type: decodeType.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { (subscriberCompletion) in
                switch subscriberCompletion {
                case .failure(let error):
                    print(error)
                    completionHandler(ResultError(error: .decodingError("Error retrieving the data", 422)))
                case .finished: break
                }
            }, receiveValue: { (data) in
                completionHandler(data as! Result)
            })
    }
    
    func cancel() {
        cancelable?.cancel()
    }
}
