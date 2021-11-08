//
//  FoodRow.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 11/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct FoodRow: View {
    let food: Food
    var body: some View {
        HStack(spacing: 12.0) {
            //Rectangle 12
            URLImage(url: food.image, blurHash: food.imageHash)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0.0, y: 5.0)
            VStack {
                HStack {
                    //Sex On The Beach
                    Text(food.name)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color("Primary 3"))
                    Spacer()
                    Text("\(String(format: "%.2f", food.price)) €")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(Color("Primary 3"))
                        .multilineTextAlignment(.center)
                }
                HStack {
                    //Le Sex on the beach est un...
                    Text(food.foodDescription)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black).lineLimit(3)
                    Spacer()
                }
            }
            Image("RightChevron")
                .colorMultiply(Color("Primary 1"))
                .frame(width: 10.0, height: 17.0)
        }
        
    }
}

#if DEBUG
struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodRow(food: sexOnTheBeach)
            .previewLayout(.fixed(width: 337, height: 66))
            .background(Color("Background"))
    }
}
#endif
