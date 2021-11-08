//
//  SignUpViewModel.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 03/09/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import ValidatedPropertyKit
import OAuthSwift
import Prephirences

class AccountViewModel: ObservableObject {
    @Validated(.nonEmpty)
    var firstName: String? = nil
    
    @Validated(.nonEmpty)
    var lastName: String? = nil
    
    @Validated(.nonEmpty && .isEmail)
    var emailAddress: String? = nil
    
    @Validated(.nonEmpty && .regularExpression("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#_?\\-&])[A-Za-z\\d@$!%_*#?&\\-]{8,}$"))
    var password: String? = nil
    
    @Validated(.nonEmpty)
    var password2: String? = nil
    
    @Published var errorTitle: String? = nil
    @Published var errorMessage: String? = nil
    
    @Published var didSignUp = false
    
    @Published var isLoggedIn = false
    
    @Published var account: Account? = nil
    
    init() {
        isLoggedIn = OAuthManager.sharedInstance.isConnected()
    }
    
    func validateFirstName(firstName: String) -> ValidationBrokenRule {
        self.firstName = firstName
        switch _firstName.validatedValue {
        case .success( _):
            return ValidationBrokenRule(message: nil, color: .Green)
        case .failure(let error):
            return ValidationBrokenRule(message: error.failureReason, color: .Red)
        }
    }
    
    func validateLastName(lastName: String) -> ValidationBrokenRule {
        self.lastName = lastName
        switch _lastName.validatedValue {
        case .success( _):
            return ValidationBrokenRule(message: nil, color: .Green)
        case .failure(let error):
            return ValidationBrokenRule(message: error.failureReason, color: .Red)
        }
    }
    
    func validateEmailAddress(emailAddress: String) -> ValidationBrokenRule {
        self.emailAddress = emailAddress
        
        switch _emailAddress.validatedValue {
        case .success( _):
            return ValidationBrokenRule(message: nil, color: .Green)
        case .failure(let error):
            return ValidationBrokenRule(message: error.failureReason, color: .Red)
        }
    }
    
    func validatePassword(password: String) -> ValidationBrokenRule {
        self.password = password
        switch _password.validatedValue {
        case .success( _):
            return ValidationBrokenRule(message: nil, color: .Green)
        case .failure(let error):
            return ValidationBrokenRule(message: error.errorDescription, color: .Red)
        }
    }
    
    func validatePassword2(password2: String) -> ValidationBrokenRule {
        self.password2 = password2
        switch _password.validatedValue {
        case .success( _):
            if password2 != password {
                return ValidationBrokenRule(message: "Les mots de passe ne correspondent pas." , color: .Red)
            } else {
                return ValidationBrokenRule(message: nil, color: .Green)
            }
        case .failure(let error):
            return ValidationBrokenRule(message: error.errorDescription, color: .Red)
        }
    }
    
    func signUp(emailAddress: String, firstName: String, lastName: String, password: String, password2: String) {
        self.emailAddress = emailAddress
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.password2 = password2
        
        if _firstName.isValid, _lastName.isValid, _password.isValid, _emailAddress.isValid, password == password2 {
            let signUp = SignUp(email: emailAddress, firstName: firstName, lastName: lastName, password: password, password2: password2)
            SignUpService.shared.signUp(signUp: signUp, result: { result in
                switch(result) {
                case .success(_):
                    self.didSignUp = true
                case .failure(let error):
                    switch error {
                    case .apiError:
                        self.errorMessage = "Une erreur est survenue. Réessayez plus tard."
                        break
                    case .decodeError:
                        self.errorMessage = "La réponse du serveur est incorrecte. Réessayez plus tard."
                        break
                    case .invalidEndpoint:
                        self.errorMessage = "Erreur du serveur. Réessayez plus tard."
                        break
                    case .invalidResponse:
                        self.errorMessage = "La réponse du serveur est invalide. Réessayez plus tard."
                        break
                    case .noData:
                        self.errorMessage = "Le serveur n'a rien retourné. Réessayez plus tard."
                        break
                    case .notFound:
                        self.errorMessage = "La ressource n'a pas été trouvée. Réessayez plus tard."
                        break
                    case .duplicatedEmail:
                        self.errorMessage = "L'e-mail existe déjà dans la base de données."
                        break
                    case .passwordsNotMatching:
                        self.errorMessage = "Les mots de passe ne correspondent pas."
                        break
                    case .invalidEmail:
                        self.errorMessage = "L'e-mail est incorrect."
                        break
                    case .invalidPassword:
                        self.errorMessage = "Le mot de passe est invalide. Il doit contenir au moins 8 caractères dont un caractère spécial, une majuscule, une minuscule et un nombre."
                        break
                    }
                    self.errorTitle = "Inscription impossible"
                }
            })
        } else {
            var errorMessage_ = ""
            if !_firstName.isValid {
                errorMessage_ = "Le prénom ne peut pas être vide."
            }
            if !_lastName.isValid {
                errorMessage_ += " Le nom ne peut pas être vide."
            }
            if !_emailAddress.isValid {
                errorMessage_ += " L'adresse e-mail est incorrecte."
            }
            if !_password.isValid {
                errorMessage_ += " Le mot de passe n'est pas valide."
            }
            
            if password2 != password {
                errorMessage_ += " Les mots de passe ne correspondent pas."
            }
            
            
            errorTitle = "Inscription impossible"
            errorMessage = errorMessage_.trimmingCharacters(in: .whitespaces)
            
        }
    }
    
    func signIn(username: String, password: String) {
        self.emailAddress = username
        self.password = password
        if !_emailAddress.isValid || !_password.isValid {
            self.errorTitle = "Information incorrecte"
            self.errorMessage = "Adresse e-mail ou mot de passe incorrect."
        } else {
            OAuthManager.sharedInstance.authorize(username: username, password: password, completionHandler: { (result) in
                switch result {
                case .success():
                    self.isLoggedIn = true
                    break
                case .failure(let error):
                    switch error {
                    case .invalidPassword:
                        self.errorMessage = "Les paramètres du serveur ne correspondent pas. Réessayez dans quelques instants."
                    case .apiError:
                        self.errorMessage = "Serveur indisponible. Réessayez dans quelques instants."
                    }
                    self.errorTitle = "Connexion impossible"
                    break
                }
            })
        }
    }
    
    func signOut() {
        OAuthManager.sharedInstance.logOut()
        isLoggedIn = false
        account = nil
    }
    
    func emptyErrorMessage() {
        errorMessage = nil
        errorTitle = nil
    }
    
    func getUserInformations() {
        UserInfoService.shared.getUserInfo { (result) in
            switch result {
            case .success(let account):
                self.account = account
                break
            case .failure(let error):
                switch error {
                case .apiError, .invalidEndpoint:
                    self.errorMessage = "Les paramètres du serveur ne correspondent pas. Réessayez dans quelques instants."
                case .decodeError:
                    self.errorMessage = "Serveur indisponible. Réessayez dans quelques instants."
                case .notFound:
                    self.errorMessage = "Impossible d'accéder à la ressource. Réessayez dans quelques instants."
                case .renewError:
                    self.errorMessage = "Impossible d'accéder à votre compte. Veuillez vous reconnecter."
                    self.isLoggedIn = false
                    self.didSignUp = false
                    OAuthManager.sharedInstance.logOut()
                }
                self.errorTitle = "Connexion impossible"
                break
            }
        }
    }
}
