//
//  AvatarIconButton.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 12/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct AvatarIconButton: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var selection: Page?
    
    enum Page {
        case login
        case account
    }
    
    var body: some View {
        ZStack {
            NavigationLink("AccountView", destination: AccountView()
                            .environmentObject(accountViewModel),
                           tag: .account, selection: $selection)
                .hidden()
            
            NavigationLink("LoginView", destination: LoginView()
                            .environmentObject(accountViewModel),
                           tag: .login, selection: $selection)
                .hidden()
            
            Button(action: {self.selection =  accountViewModel.isLoggedIn ? .account : .login}) {
                Image("AvatarIcon")
                    .resizable()
                    .frame(width: 44.0, height: 44.0)
                    .colorMultiply(Color("Primary 2"))
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0.0, y: 5.0)

            }
        } .frame(width: 44.0, height: 44.0)
    }
}

struct AvatarIconButton_Previews: PreviewProvider {
    static var previews: some View {
        AvatarIconButton()
    }
}
