//
//  OrderIconButton.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 12/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct OrderIconButton: View {
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    
    var body: some View {
        NavigationLink(destination: OrderView()
                        .environmentObject(orderViewModel)) {
            ZStack {
                Image("OrderIcon")
                    .resizable()
                    .frame(width: 44.0, height: 44.0)
                    .colorMultiply(Color("Primary 2"))
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0.0, y: 5.0)

                if orderViewModel.productCount != 0 {
                    HStack {
                        Spacer()
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(Color("Text 1"))
                                    .frame(width: 14, height: 14)
                                
                                Text("\(orderViewModel.productCount)")
                                    .font(.custom("Inter Regular", size: 12))
                                    .foregroundColor(Color("Text 2"))
                                    .multilineTextAlignment(.center)
                                
                                LottieView(name: "Pop", loopMode: .playOnce)
                                    .frame(width: 80.0, height: 80.0)
                            }.frame(width: 22.0, height: 22.0)
                            Spacer()
                        }
                    }
                }
            }
            .frame(width: 50.0, height: 50.0)
        }
    }

}

#if DEBUG
struct OrderIconButton_Previews: PreviewProvider {
    static var previews: some View {
        let orderViewModel = OrderViewModel(restaurant: restaurant, table: table)
        orderViewModel.addFoodToOrder(food: caipirinha)
        return OrderIconButton().environmentObject(orderViewModel)

    }
}
#endif
