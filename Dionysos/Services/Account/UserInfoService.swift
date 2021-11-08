//
//  UserinfoService.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 25/09/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import Alamofire
import OAuthSwift

class UserInfoService {
    public static let shared = UserInfoService()
    
    private init() {}
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()
    
    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case decodeError
        case notFound
        case renewError
    }
    
    public func getUserInfo(completionHandler: @escaping (Result<Account, APIServiceError>) -> Void) {
        let userInfoURL = "\(ServiceAPI.baseURL.rawValue)/\(ServiceAPI.api.rawValue)/\(ServiceAPI.account.rawValue)/\(ServiceAPI.userInfo.rawValue)"
        guard let oAuthSwift = OAuthManager.sharedInstance.oauthSwift else {
            completionHandler(.failure(.apiError))
            return
        }
        let interceptor = oAuthSwift.requestInterceptor
        OAuthManager.sharedInstance.renewToken { (renewTokenResult) in
            switch(renewTokenResult) {
            case .success(_):
                AF.request(userInfoURL, method: .get, headers: ["Authorization": "Bearer \(oAuthSwift.client.credential.oauthToken)"], interceptor: interceptor)
                    .validate(statusCode: 200..<300)
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: Account.self) { response in
                        switch response.result {
                        case .success(let account):
                            completionHandler(.success(account))
                        case let .failure(error):
                            if error.isResponseValidationError {
                                if error.responseCode == 404 {
                                    completionHandler(.failure(.notFound))
                                } else if error.responseCode == 400 {
                                    completionHandler(.failure(.apiError))
                                }
                                else {
                                    completionHandler(.failure(.decodeError))
                                }
                            } else {
                                completionHandler(.failure(.invalidEndpoint))
                            }
                        }
                    }
                break
            case .failure(let error):
                print(error)
                completionHandler(.failure(.renewError))
                break
            }
        }


    }
}

