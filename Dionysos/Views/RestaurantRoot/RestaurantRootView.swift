//
//  RestaurantRootView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 10/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI
import Foundation

enum Page {
    case order
    case account
    case login
    case home
}

struct RestaurantRootView: View {
    @ObservedObject var orderViewModel: OrderViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    @State var selection: Page? = nil
    @State var alertShouldBePresented: Bool = false
    
    init(orderViewModel: OrderViewModel) {
        self.orderViewModel = orderViewModel
    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination: AccountView()
                            .environmentObject(accountViewModel),
                           tag: .account, selection: $selection) { EmptyView() }
            
            NavigationLink(destination: LoginView()
                            .environmentObject(accountViewModel),
                           tag: .login, selection: $selection) { EmptyView()
            }
            
            NavigationLink(destination: HomePage()
                            .environmentObject(accountViewModel)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true),
                           tag: .home, selection: $selection) { EmptyView()
            }
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 12.0) {
                VStack(spacing: 8.0) {
                    RestaurantHeader(orderViewModel: orderViewModel)

                    HStack(spacing: 14.0) {
                        Button(action: {
                            self.alertShouldBePresented.toggle()
                        }, label: {
                            Image("LogOutIcon")
                                .resizable()
                                .frame(width: 40.0, height: 40.0)
                                .colorMultiply(Color("Primary 2"))

                        })
                        OrderIconButton()
                            .environmentObject(orderViewModel)
                            .environmentObject(accountViewModel)
                        
                        AvatarIconButton()
                            .environmentObject(accountViewModel)
                        
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(self.orderViewModel.restaurant.sections.sorted(by: {$0.order <= $1.order}), id: \.id) { section in
                        SectionView(section: section)
                            .environmentObject(orderViewModel)
                            .environmentObject(accountViewModel)
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .alert(isPresented: $alertShouldBePresented, content: {
            Alert(title: Text("Quitter le restaurant ?"), message: Text("Vous devrez rescanner le QR Code pour revenir dans un restaurant. Votre commande non terminée sera supprimée."), primaryButton: .destructive(Text("Quitter"), action: {
                self.selection = .home
            }), secondaryButton: .cancel(Text("Annuler")))
            
        })
    }
    
}


#if DEBUG
struct RestaurantRootView_Previews: PreviewProvider {
    static var previews: some View {
        let view = RestaurantRootView(orderViewModel: OrderViewModel(restaurant: restaurant, table: table))
            .environmentObject(AccountViewModel())
        return view
        
    }
}
#endif
