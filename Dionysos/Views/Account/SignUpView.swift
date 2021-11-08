//
//  SignUpView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 30/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var accountViewModel: AccountViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    @State var password2: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    @State var emailBorderColor: ValidationBrokenRuleColors = .none
    @State var passwordBorderColor: ValidationBrokenRuleColors = .none
    @State var password2BorderColor: ValidationBrokenRuleColors = .none
    @State var firstNameBorderColor: ValidationBrokenRuleColors = .none
    @State var lastNameBorderColor: ValidationBrokenRuleColors = .none
    
    @State var alertShouldBePresented: Bool = false
    
    @State var showLoading: Bool = false
    
    @State var didSignUp: Bool = false
    
    var body: some View {
        DispatchQueue.main.async {
            if accountViewModel.errorTitle != nil {
                showLoading = false
                alertShouldBePresented = true
            } else {
                alertShouldBePresented = false
            }
            
            if accountViewModel.didSignUp {
                didSignUp = accountViewModel.didSignUp
                showLoading = false
            }
        }
        
        return ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            Image("SignUp 1")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 10.0) {
                    HStack {
                        Text("Identité")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color("Primary 2"))
                        Spacer()
                    }
                    
                    VStack(spacing: 8.0) {
                        //Prénom
                        VStack(spacing: 0.0) {
                            HStack {
                                Text("Prénom")
                                    .font(.system(size: 17, weight: .regular))
                                Spacer()
                            }
                            
                            HStack(spacing: 8.0) {
                                TextField(" ", text: $firstName)
                                    .padding(8.0)
                                    .foregroundColor(Color(.white))
                                    .frame(height: 34.0)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                                    )
                                    .accentColor(Color(.white))
                                    .textContentType(.givenName)
                                    .keyboardType(.namePhonePad)
                                    .autocapitalization(.words)
                                
                                adaptImage(rule: accountViewModel.validateFirstName(firstName: firstName.trimmingCharacters(in: .whitespaces)))
                            }
                            
                        }
                        
                        //Nom
                        VStack(spacing: 0.0) {
                            HStack {
                                Text("Nom")
                                    .font(.system(size: 17, weight: .regular))
                                Spacer()
                            }
                            
                            HStack(spacing: 8.0) {
                                TextField(" ", text: $lastName)
                                    .padding(8.0)
                                    .foregroundColor(Color(.white))
                                    .frame(height: 34.0)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                                    )
                                    .accentColor(Color(.white))
                                    .textContentType(.givenName)
                                    .keyboardType(.namePhonePad)
                                    .autocapitalization(.words)
                                
                                adaptImage(rule: accountViewModel.validateLastName(lastName: lastName.trimmingCharacters(in: .whitespaces)))
                            }
                        }
                    }
                    
                }
                
                Divider()
                
                VStack(spacing: 10.0) {
                    //Informations de connexion
                    HStack {
                        Text("Informations de connexion")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color("Primary 2"))
                        Spacer()
                    }
                    
                    VStack(spacing: 0.0) {
                        HStack {
                            Text("Adresse e-mail")
                                .font(.system(size: 17, weight: .regular))
                            Spacer()
                        }
                        
                        HStack(spacing: 8.0) {
                            TextField("", text: $email)
                                .padding(8.0)
                                .foregroundColor(Color(.white))
                                .frame(height: 34.0)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                                )
                                .accentColor(Color(.white))
                                .textContentType(.username)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            adaptImage(rule: accountViewModel.validateEmailAddress(emailAddress: email))
                        }
                    }
                    
                    VStack(spacing: 0.0) {
                        //Mot de passe
                        HStack {
                            Text("Mot de passe")
                                .font(.system(size: 17, weight: .regular))
                            Spacer()
                        }
                        HStack(spacing: 8.0) {
                            SecureField("", text: $password)
                                .padding(8.0)
                                .frame(height: 34.0)
                                .foregroundColor(Color(.white))
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                                )
                                .accentColor(Color(.white))
                                .textContentType(.newPassword)
                            adaptImage(rule: accountViewModel.validatePassword(password: password))
                        }
                        //Le mot de passe doit conte...
                        Text("Le mot de passe doit contenir au moins 8 caractères, dont un caractère spécial, une majuscule, une minuscule et un nombre.")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("Primary 3"))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 48.0, maxHeight: nil, alignment: .leading)
                    }
                    
                    VStack(spacing: 0.0) {
                        HStack {
                            //Confirmation du mot de passe
                            Text("Confirmation du mot de passe")
                                .font(.system(size: 17, weight: .regular))
                            Spacer()
                        }
                        
                        HStack(spacing: 8.0) {
                            SecureField("", text: $password2)
                                .padding(8.0)
                                .frame(height: 34.0)
                                .foregroundColor(Color(.white))
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                                )
                                .accentColor(Color(.white))
                                .textContentType(.newPassword)
                            adaptImage(rule: accountViewModel.validatePassword2(password2: password2))
                        }
                    }
                }
            }.padding(.top, 90.0)
            .padding(.horizontal, 30.0)
            
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 14.0) {
                    Text("En cliquant sur “s’inscrire”, vous acceptez les conditions d’utilisation de Dionysos ainsi que la politique de confidentialité.")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("Primary 3"))
                    
                    Button(action: {
                        showLoading = true
                        accountViewModel.signUp(emailAddress: email, firstName: firstName, lastName: lastName, password: password, password2: password2)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("Primary 1"))
                            Text("S'inscrire")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color("Secondary 1"))
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 47.0, maxHeight: 47.0, alignment: .center)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:30, x:0, y:15)
                    
                }
            }
            .padding(.horizontal, 30.0)
            .padding(.bottom, 110.0)
            
            if(showLoading) {
                LottieView(name: "Loading")
                    .frame(width: 120.0, height: 120.0)
                    .offset(y: -80.0)
            }
            
            NavigationLink("", destination: Text("Inscrit"), isActive: $didSignUp)
                .hidden()
        }
        .alert(isPresented: $alertShouldBePresented) {
            Alert(title: Text(accountViewModel.errorTitle ?? "Erreur"), message: Text(accountViewModel.errorMessage ?? "Erreur inconnue. Réessayez dans quelques instants."), dismissButton: .default(Text("D'accord"), action: {
                accountViewModel.emptyErrorMessage()
            }))
        }
        .navigationBarTitle("Inscription", displayMode: .large)
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    private func adaptImage(rule: ValidationBrokenRule) -> Image
    {
        let color = rule.color
        if(color == .Green)
        {
            return Image("Valid")
        }
        else if(color == .Red)
        {
            return Image("Invalid")
        }
        return Image("")
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(AccountViewModel())
    }
}
