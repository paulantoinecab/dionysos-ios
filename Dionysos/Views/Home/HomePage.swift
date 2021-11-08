//
//  HomePage.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 10/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State private var selection: Page? = nil
    
    enum Page {
        case order
        case account
        case login
    }
    
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        // this only applies to big titles
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(named: "Primary 1") ?? .black
        ]
        // this only applies to small titles
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(named: "Primary 1") ?? .black
        ]
        
        //In the following two lines you make sure that you apply the style for good
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(named: "Primary 1")

    }
    
    var body: some View {
        return NavigationView {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    HStack {
                        Image("Home 2")
                        Spacer()
                    }
                }.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    HStack  {
                        Spacer()
                        Image("Home 1")
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 40, x: 0.0, y: 20.0)
                    
                    }
                }.edgesIgnoringSafeArea(.all)
                
                NavigationLink(
                    destination: LoginView().environmentObject(accountViewModel), tag: .login, selection: $selection
                ) { EmptyView() }
                NavigationLink(
                    destination: AccountView().environmentObject(accountViewModel), tag: .account, selection: $selection
                )  { EmptyView() }
                VStack(spacing: 16.0) {
                    //Bienvenue sur Dionysos, l’...
                    Text("Bienvenue sur Dionysos, l’application de tous les restaurants et bars ! Toutes vos commandes sur place simplifées, et en un seul endroit.\nSécurité, rapidité et confiance garanties.")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                    
                    
                    //Pour commencer, sélectionn...
                    Text("Pour commencer, sélectionnez votre situation :")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color("Primary 2"))
                    
                    
                    HStack(spacing: 18.0) {
                        
                        NavigationLink(
                            destination: ScannerView().environmentObject(accountViewModel)) {
                            
                            VStack(alignment: .center, spacing: 12.0) {
                                Image("QRCodeLogo")
                                    .resizable()
                                    .colorMultiply(Color("Primary 1"))
                                    .frame(width: 64.0, height: 64.0)
                                //Scanner le QR Code
                                Text("Scanner\nle QR Code")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundColor(Color("Primary 2"))
                                    .multilineTextAlignment(.center)
                                
                            }
                            
                            .frame(width: 158, height: 158)
                            .background(RoundedRectangle(cornerRadius: 12)
                                            .fill(Color("Secondary 1"))
                                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 20, x: 0.0, y: 10.0)

                            )
                        }
                        Button(action: {
                            selection = accountViewModel.isLoggedIn ? .account : .login
                        }){
                            VStack {
                                Image("AvatarIcon")
                                    .resizable()
                                    .colorMultiply(Color("Primary 1"))
                                    .frame(width: 64.0, height: 64.0)
                                //Mes informations
                                Text("Mes informations").font(.system(size: 18, weight: .regular)).foregroundColor(Color("Primary 2")).tracking(0.05)
                            }                            .frame(width: 158, height: 158)
                            .background(                            RoundedRectangle(cornerRadius: 12)
                                                                        .fill(Color("Secondary 1"))
                                                                        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 20, x: 0.0, y: 10.0)

                            )
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 18.0)
                .navigationBarTitle("Dionysos")
                .preferredColorScheme(.light)
            }
        }
    }
    
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(AccountViewModel())
    }
}
