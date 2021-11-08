//
//  SitToTableService.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 19/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import Alamofire

class SitToTableService {
    public static let shared = SitToTableService()
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
    }
    
    public func fetchTableRestaurant(tableId: String, result: @escaping (Result<TableRestaurant, APIServiceError>) -> Void) {
        let tableURL = "\(ServiceAPI.baseURL.rawValue)/\(ServiceAPI.api.rawValue)/\(ServiceAPI.table.rawValue)/\(tableId)/"

        AF.request(tableURL, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: TableRestaurant.self) { response in
                switch response.result {
                case .success(let tableRestaurant):
                    result(.success(tableRestaurant))
                case let .failure(error):
                    if error.isResponseValidationError {
                        if error.responseCode == 404 {
                            result(.failure(.notFound))
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
