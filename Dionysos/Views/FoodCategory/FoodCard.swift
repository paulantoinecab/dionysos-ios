//
//  FoodCard.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 11/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct FoodCard: View {
    let food: Food
    
    var body: some View {
        VStack(spacing: 0.0) {
            //Rectangle 2
            ZStack {
                URLImage(url: food.image, blurHash: food.imageHash)
                    .frame(width: 200, height: 135)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }.shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0.0, y: 5.0)

            .frame(width: 200, height: 135)
            
            HStack(spacing: 6.0) {
                //Mojito
                Text(food.name)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color("Primary 3"))
                .lineLimit(1)
                
                Spacer()
                //10€
                Text("\(String(format: "%.2f", food.price)) €")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(Color("Primary 3"))
                    .multilineTextAlignment(.trailing)
            }
        }
        .frame(width: 200.0, height: 176.0)
        
    }
}

#if DEBUG
struct FoodCard_Previews: PreviewProvider {
    static var previews: some View {
        FoodCard(food: mojito)
            .previewLayout(.fixed(width: 200, height: 171))
        .background(Color("Background"))
    }
}
#endif
