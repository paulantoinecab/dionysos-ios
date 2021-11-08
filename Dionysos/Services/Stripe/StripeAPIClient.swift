//
//  StripeAPIClient.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 04/10/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import Stripe
import OAuthSwift
import Alamofire

class StripeAPIClient: NSObject, STPCustomerEphemeralKeyProvider {
    static let shared = StripeAPIClient()
    
    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case decodeError
        case notFound
        case renewError
    }

    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let ephemeralKeyUrl = "\(ServiceAPI.baseURL.rawValue)/\(ServiceAPI.api.rawValue)/\(ServiceAPI.stripe.rawValue)/\(ServiceAPI.ephemeralKey.rawValue)"
        guard let oAuthSwift = OAuthManager.sharedInstance.oauthSwift else {
            completion(nil, nil)
            return
        }
        let interceptor = oAuthSwift.requestInterceptor
        OAuthManager.sharedInstance.renewToken { (renewTokenResult) in
            switch(renewTokenResult) {
            case .success(_):
                AF.request(ephemeralKeyUrl, method: .get, parameters: ["API_VERSION": apiVersion], headers: ["Authorization": "Bearer \(oAuthSwift.client.credential.oauthToken)"], interceptor: interceptor)
                    .validate(statusCode: 200..<300)
                    .responseJSON { response in
                        switch response.result {
                        case .success(let json):
                            print("success")
                            completion(json as! [String : Any], nil)
                        case let .failure(error):
                            if error.isResponseValidationError {
                                if error.responseCode == 404 {
                                    completion(nil, error)
                                } else if error.responseCode == 400 {
                                    completion(nil, error)
                                }
                                else {
                                    completion(nil, error)
                                }
                            } else {
                                completion(nil, error)
                            }
                        }
                    }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    func createPaymentIntent(order: Order, completionHandler:  @escaping (Result<StripeClientSecret, APIServiceError>) -> Void) {
        let placeOrderUrl = "\(ServiceAPI.baseURL.rawValue)/\(ServiceAPI.api.rawValue)/\(ServiceAPI.order.rawValue)/\(ServiceAPI.placeOrder.rawValue)"
        
        guard let oAuthSwift = OAuthManager.sharedInstance.oauthSwift else {
            completionHandler(.failure(.apiError))
            return
        }
        
        let interceptor = oAuthSwift.requestInterceptor
        OAuthManager.sharedInstance.renewToken { (renewTokenResult) in
            switch(renewTokenResult) {
            case .success(_):
                AF.request(placeOrderUrl, method: .post, parameters: order, encoder: JSONParameterEncoder.default, headers: ["Authorization": "Bearer \(oAuthSwift.client.credential.oauthToken)"], interceptor: interceptor)
                    .validate(statusCode: 200..<300)
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: StripeClientSecret.self) { response in
                        switch response.result {
                        case .success(let clientSecret):
                            completionHandler(.success(clientSecret))
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
