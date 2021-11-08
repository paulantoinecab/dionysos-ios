//
//  SignUpService.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 04/09/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import Alamofire

class SignUpService {
    public static let shared = SignUpService()
    private init() {}
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()
    
    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
        case notFound
        case duplicatedEmail
        case passwordsNotMatching
        case invalidEmail
        case invalidPassword
    }
    
    public func signUp(signUp: SignUp, result: @escaping (Result<ServerMessage, APIServiceError>) -> Void) {
        let createAccountURL = "\(ServiceAPI.baseURL.rawValue)/\(ServiceAPI.api.rawValue)/\(ServiceAPI.account.rawValue)/\(ServiceAPI.signUp.rawValue)"
        AF.request(createAccountURL, method: .post, parameters: signUp.dictionary, encoding: URLEncoding.httpBody)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: ServerMessage.self) { response in
                switch response.result {
                case .success(let message):
                    result(.success(message))
                    break
                case let .failure(error):
                    if error.isResponseValidationError {
                        if error.responseCode == 404 {
                            result(.failure(.notFound))
                        } else if error.responseCode == 400 {
                            if let data = response.data, let value = try? self.jsonDecoder.decode(ServerMessage.self, from: data) {
                                switch value.error {
                                case "duplicatedEmail":
                                    result(.failure(.duplicatedEmail))
                                    break
                                case "passwordsNotMatching":
                                    result(.failure(.passwordsNotMatching))
                                    break
                                case "invalidPassword":
                                    result(.failure(.invalidPassword))
                                    break
                                case "invalidEmail":
                                    result(.failure(.invalidEmail))
                                    break
                                default:
                                    result(.failure(.invalidResponse))
                                    break
                                }
                            }
                            else {
                                result(.failure(.decodeError))
                            }
                        } else {
                            result(.failure(.invalidEndpoint))
                        }
                    } else if error.isResponseSerializationError {
                        result(.failure(.decodeError))
                    } else {
                        result(.failure(.apiError))
                    }
                }
        }
    }
}
