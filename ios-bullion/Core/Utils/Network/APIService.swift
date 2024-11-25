//
//  APIService.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case unableToGenerateRequest
    case invalidEndpoint
    case parsingError
    case serverError(statusCode: Int, message: String? = nil)
    
    var description: String {
        switch self {
        case .unableToGenerateRequest:
            return "Network Error! Unable to generate request"
        case .invalidEndpoint:
            return "Network Error! Invalid network adress"
        case .parsingError:
            return "Parsing Error! Error occured when parsing data"
        case .serverError(let code, let message):
            if let message {
                return message
            } else {
                return "Network Error! Error Occured with status code \(code)"
            }
        }
    }
}

struct APIService {
    static func makeRequest<T: Codable>(for endpoint: Endpoint) -> AnyPublisher<T, Error> {
        guard let request = endpoint.generateURLRequest() else {
            return Fail(error: NetworkError.unableToGenerateRequest).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetworkError.invalidEndpoint
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    if let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: output.data) {
                        throw NetworkError.serverError(statusCode: httpResponse.statusCode, message: errorResponse.errMessage)
                    } else {
                        throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                    }
                }
                
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    print("Decoding error: \(decodingError)")
                    return NetworkError.parsingError
                }
                return error
            }
            .eraseToAnyPublisher()
    }
}
