//
//  AccountView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 25/09/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @Environment(\.presentationMode) var presentation

    @State var email: String = ""
    @State var password: String = ""
    @State var password2: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    @State var isLoading: Bool = true
    @State var alertShouldBePresented = false
    @State var signOutAlertShouldBePresented = false

    var body: some View {
        DispatchQueue.main.async {
            if let account = accountViewModel.account {
                email = account.username
                firstName = account.firstName
                lastName = account.lastName
                
                isLoading = false
            }
            
            if accountViewModel.errorTitle != nil {
                isLoading = false
                alertShouldBePresented = true
            } else {
                alertShouldBePresented = false
            }
        }
        
        
        return ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            Image("Account 1")
                .edgesIgnoringSafeArea(.all)

            
                ScrollView {
                    
                    VStack(spacing: 12.0) {
                        HStack {
                            //Identité
                            Text("Identité")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color("Primary 2"))
                            Spacer()
                        }
                        //Prénom
                        VStack(spacing: 4.0) {
                            HStack {
                                Text("Prénom")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.black)
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
                            }
                            
                            
                        }
                        
                        //Nom
                        VStack(spacing: 4.0) {
                            HStack {
                                //Nom
                                Text("Nom")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            HStack(spacing: 8.0) {
                                TextField("", text: $lastName)
                                    .padding(8.0)
                                    .foregroundColor(.white)
                                    .frame(height: 34.0)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                                    )
                                    .accentColor(.white)
                                    .textContentType(.familyName)
                                    .keyboardType(.namePhonePad)
                            }
                        }
                    }
                    
                    Divider()
                    
                    VStack(spacing: 12.0) {
                        HStack {
                            //Informations de connexion
                            Text("Informations de connexion")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color("Primary 2"))
                            Spacer()
                        }
                        //Adresse e-mail
                        VStack(spacing: 4.0) {
                            HStack {
                                Text("Adresse e-mail")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            TextField("", text: $email)
                                .padding(8.0)
                                .foregroundColor(.white)
                                .frame(height: 34.0)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                                )
                                .accentColor(Color(.white))
                                .textContentType(.username)
                                .keyboardType(.emailAddress)
                        }
                        VStack(spacing: 4.0) {
                            VStack(spacing: 4.0) {
                                HStack {
                                    //Mot de passe
                                    Text("Mot de passe")
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                SecureField("", text: $password)
                                    .padding(8.0)
                                    .textContentType(.password)
                                    .frame(height: 34.0)
                                .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                                    )
                                .accentColor(Color(.white))
                            }
                            
                            VStack(spacing: 4.0) {
                                HStack {
                                    Text("Confirmation du mot de passe")
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                HStack(spacing: 8.0) {
                                    SecureField("", text: $password2)
                                        .padding(8.0)
                                        .frame(height: 34.0)
                                        .foregroundColor(.white)
                                        .background(
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(Color(#colorLiteral(red: 0.30980393290519714, green: 0.30980393290519714, blue: 0.30980393290519714, alpha: 1)))
                                        )
                                        .accentColor(Color(.white))
                                        .textContentType(.newPassword)
                                }
                                Text("Le mot de passe doit contenir au moins 8 caractères, dont un caractère spécial, une majuscule, une minuscule et un nombre.")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(Color("Primary 2"))
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 48.0, maxHeight: nil, alignment: .leading)

                            }
                            
                        }
                    }
                    
                }.padding(.top, 90.0)
                .padding(.horizontal, 30.0)
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 12.0) {
                    Button(action: {}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("Secondary 1"))
                            
                            Text("Mettre à jour mes informations")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color("Primary 1"))
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44.0, maxHeight: 44.0, alignment: .center)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:30, x:0, y:15)

                    
                    Button(action: {
                        signOutAlertShouldBePresented.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("Primary 1"))
                            Text("Se déconnecter")
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


            if(isLoading) {
                LottieView(name: "Loading")
                    .frame(width: 120.0, height: 120.0)
                    .offset(y: -80.0)
            }
            
        }.navigationBarTitle("Mes informations", displayMode: .large)
        .onAppear {
            self.accountViewModel.getUserInformations()
        }
        .alert(isPresented: $alertShouldBePresented) {
            Alert(title: Text(accountViewModel.errorTitle ?? "Erreur"), message: Text(accountViewModel.errorMessage ?? "Erreur inconnue. Réessayez dans quelques instants."), dismissButton: .default(Text("D'accord"), action: {
                accountViewModel.emptyErrorMessage()
            }))
        }
        .alert(isPresented: $signOutAlertShouldBePresented, content: {
            Alert(title: Text("Se déconnecter ?"), message: Text("Vous pourrez vous reconnecter."), primaryButton: .destructive(Text("Se déconnecter"), action: {
                accountViewModel.signOut()
                presentation.wrappedValue.dismiss()
                
            }), secondaryButton: .cancel(Text("Annuler")))
            
        })

        
    }
}

#if DEBUG
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView().environmentObject(AccountViewModel())
    }
}
#endif
