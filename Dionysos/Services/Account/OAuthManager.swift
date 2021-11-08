//
//  OAuthToken.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 07/09/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import Prephirences
import OAuthSwift

class OAuthManager {
    static let sharedInstance = OAuthManager()
    var oauthSwift: OAuth2Swift?
        
    let credentialKey = "Credentials"
    
    var keychain = KeychainPreferences.sharedInstance
    
    public enum APIServiceError: Error {
        case apiError
        case invalidPassword
    }
    
    init() {
        oauthSwift = OAuth2Swift(consumerKey: ServiceAPI.consumerKey.rawValue, consumerSecret: ServiceAPI.consumerSecret.rawValue, authorizeUrl: "\(ServiceAPI.baseURL.rawValue)/\(ServiceAPI.oauth.rawValue)/authorize", accessTokenUrl: "\(ServiceAPI.baseURL.rawValue)/\(ServiceAPI.oauth.rawValue)/token/", responseType: "token")
        if let credential = keychain.unarchiveObject(forKey: credentialKey) as? OAuthSwiftCredential
        {
            oauthSwift?.client.credential.oauthToken = credential.oauthToken
            oauthSwift?.client.credential.oauthRefreshToken = credential.oauthRefreshToken
            oauthSwift?.client.credential.oauthTokenExpiresAt = credential.oauthTokenExpiresAt
        }
    }
    
    func isConnected() -> Bool {
        return oauthSwift?.client.credential.oauthToken != ""
    }
    
    func authorize(username: String, password: String, completionHandler:  @escaping (Result<Void, APIServiceError>) -> Void) {
        if let oauth = oauthSwift {
            oauth.authorize(username: username, password: password, scope: "read write", completionHandler: { (result) in
                switch result {
                case .success((let credential, _, _)):
                    // each element
                    let tokenExpiresAt = Date(timeIntervalSinceNow: TimeInterval(36000))
                    credential.oauthTokenExpiresAt = tokenExpiresAt
                    self.keychain[self.credentialKey, .archive] = credential
                    self.keychain.set(objectToArchive: credential, forKey: self.credentialKey)
                    
                    self.oauthSwift?.client.credential.oauthToken = credential.oauthToken
                    self.oauthSwift?.client.credential.oauthRefreshToken = credential.oauthRefreshToken
                    
                    self.oauthSwift?.client.credential.oauthTokenExpiresAt = credential.oauthTokenExpiresAt
                    
                    completionHandler(.success(Void()))
                case .failure(let error):
                    switch error {
                    case .missingToken:
                        completionHandler(.failure(.invalidPassword))
                    default:
                        completionHandler(.failure(.apiError))
                    }
                }
            })
        }
    }
    
    func renewToken(completionHandler: @escaping (Result<OAuthSwift.TokenSuccess, OAuthSwiftError>) -> Void) {
        guard let oAuthSwift = oauthSwift else {
            completionHandler(.failure(.retain))
            return
        }
        oAuthSwift.renewAccessToken(withRefreshToken: oAuthSwift.client.credential.oauthRefreshToken) { (result) in
            switch result {
            case .success(let token):
                self.keychain[self.credentialKey, .archive] = token.credential
                self.keychain.set(objectToArchive: token.credential, forKey: self.credentialKey)
                
                self.oauthSwift?.client.credential.oauthToken = token.credential.oauthToken
                self.oauthSwift?.client.credential.oauthRefreshToken = token.credential.oauthRefreshToken
                
                self.oauthSwift?.client.credential.oauthTokenExpiresAt = token.credential.oauthTokenExpiresAt
                
                completionHandler(.success(token))

            case .failure(let error):
                completionHandler(.failure(error))

            }
        }
    }
    
    func logOut() {
        self.oauthSwift = OAuth2Swift(consumerKey: ServiceAPI.consumerKey.rawValue, consumerSecret: ServiceAPI.consumerSecret.rawValue, authorizeUrl: "\(ServiceAPI.baseURL.rawValue)/\(ServiceAPI.oauth.rawValue)/authorize", accessTokenUrl: "\(ServiceAPI.baseURL.rawValue)/\(ServiceAPI.oauth.rawValue)/token/", responseType: "token")
        self.keychain[self.credentialKey, .archive] = nil

    }
}
