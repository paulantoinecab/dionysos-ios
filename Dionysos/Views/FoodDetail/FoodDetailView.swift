//
//  FoodDetailView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 12/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct FoodDetailView: View {
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    let food: Food
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("FoodDetail 1")
                }
            }.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 36.0) {
                HStack(spacing: 16.0) {
                    VStack(spacing: 8.0) {
                        Text(food.name)
                            .font(.system(size: 24, weight: .bold))                            .foregroundColor(Color("Primary 1"))
                        
                        Text("\(String(format: "%.2f", food.price)) €")
                            .font(.system(size: 20, weight: .medium)).foregroundColor(Color("Primary 2"))
                    }
                    URLImage(url: food.image, blurHash: food.imageHash)
                        .frame(width: 115, height: 115)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0.0, y: 5.0)
                }
                
                Text(food.foodDescription)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16.5)

                VStack(alignment: .leading, spacing: 8.0) {
                    HStack {
                    Text("Ingrédients")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color("Primary 2"))
                        Spacer()
                    }
                    HStack {
                        Text(food.ingredients)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black)
                        Spacer()
                    }


                }.padding(.horizontal, 16.5)

                Spacer()
                
                OrderIconButton()
                    .environmentObject(orderViewModel)
                    .environmentObject(accountViewModel)
                
                Button(action: {
                        self.orderViewModel.addFoodToOrder(food: self.food)}
                ) {
                    ZStack {
                        //Rectangle 15
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Primary 1"))
                        //Ajouter à la commande
                        Text("Ajouter à la commande")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color("Secondary 1"))
                            .multilineTextAlignment(.center)
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 55, maxHeight: 55, alignment: .topLeading)
                    .padding(.horizontal, 33.0)
                    .padding(.bottom, 41.0)
                }
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:20, x:0, y:10)
            }
        }.navigationBarTitle("", displayMode: .inline)

    }
}

#if DEBUG
struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(food: sexOnTheBeach)
            .environmentObject(AccountViewModel())
            .environmentObject(OrderViewModel(restaurant: restaurant, table: table))
    }
}
#endif
