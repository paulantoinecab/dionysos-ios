//
//  ConnectionView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 30/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @Environment(\.presentationMode) var presentation

    @State var email: String = ""
    @State var password: String = ""
    
    @State var showLoading: Bool = false
    @State var didLogIn: Bool = false
    @State var alertShouldBePresented: Bool = false
    
    var body: some View {
        DispatchQueue.main.async {
            if accountViewModel.errorTitle != nil {
                showLoading = false
                alertShouldBePresented = true
            } else {
                alertShouldBePresented = false
            }
            
            if accountViewModel.isLoggedIn {
                didLogIn = accountViewModel.isLoggedIn
                showLoading = false
            }
        }
        
        return ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    Image("LogIn 1")
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.all)

            
            VStack(spacing: 32.0) {
                VStack(alignment: .center, spacing: 10.0) {
                    HStack {
                        //Informations de connexion
                        Text("Informations de connexion").font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color("Primary 2"))
                        Spacer()
                    }
                    
                    VStack(spacing: 4.0) {
                        HStack {
                            Text("Adresse e-mail")
                                .font(.system(size: 17, weight: .regular))
                            Spacer()
                        }
                        TextField("", text: $email)
                            .padding(8.0)
                            .foregroundColor(.white)
                            .accentColor(Color(.white))
                            .frame(height: 34.0)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                            )
                            .textContentType(.username)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    VStack(spacing: 4.0) {
                        HStack {
                            Text("Mot de passe")
                                .font(.system(size: 17, weight: .regular))
                            Spacer()
                        }
                        
                        SecureField("", text: $password)
                            .padding(8.0)
                            .textContentType(.password)
                            .frame(height: 34.0)
                            .foregroundColor(Color(.white))
                            .accentColor(Color(.white))
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                            )
                    }
                }
                
                //                    SignInWithApple()
                //                        .frame(height: 44.0)
                //                        .padding(.horizontal, 37.0)
                //                        .onTapGesture(perform: showAppleLogin)
                
                Spacer()
                VStack(alignment: .center, spacing: 12.0) {
                    NavigationLink(
                        destination: SignUpView().environmentObject(accountViewModel)
                    ) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("Secondary 1"))
                            
                            Text("S’inscrire")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color("Primary 1"))
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44.0, maxHeight: 44.0, alignment: .center)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:30, x:0, y:15)

                    
                    Button(action: {
                        showLoading = true
                        accountViewModel.signIn(username: email, password: password)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("Primary 1"))
                            Text("Se connecter")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color("Secondary 1"))
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 47.0, maxHeight: 47.0, alignment: .center)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:30, x:0, y:15)

                    

                }.padding(.bottom, 35.0)
                
            }.padding(.horizontal, 30.0)
            
            if showLoading {
                LottieView(name: "Loading")
                    .frame(width: 120.0, height: 120.0)
                    .offset(y: -80.0)
            }
            
            NavigationLink("", destination: AccountView().environmentObject(accountViewModel), isActive: $didLogIn)
                .hidden()
            
        }
        .alert(isPresented: $alertShouldBePresented) {
            Alert(title: Text(accountViewModel.errorTitle ?? "Erreur"), message: Text(accountViewModel.errorMessage ?? "Erreur inconnue. Réessayez dans quelques instants."), dismissButton: .default(Text("D'accord"), action: {
                accountViewModel.emptyErrorMessage()
            }))
        }
        .navigationBarTitle("Connexion")
        .onTapGesture {
            self.endEditing()
        }
    }
    
    //    private func showAppleLogin() {
    //        // 1
    //        let request = ASAuthorizationAppleIDProvider().createRequest()
    //
    //        // 2
    //        request.requestedScopes = [.fullName, .email]
    //
    //        // 3
    //        let controller = ASAuthorizationController(authorizationRequests: [request])
    //
    //    }
    
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AccountViewModel())
    }
}
