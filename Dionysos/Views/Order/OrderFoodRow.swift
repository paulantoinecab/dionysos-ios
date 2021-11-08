//
//  OrderFoodRow.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 12/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct OrderFoodRow: View {
    let food: Food
    init(food: Food){
        self.food = food
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        HStack(spacing: 12.0) {
            //Rectangle 12
            URLImage(url: food.image, blurHash: food.imageHash)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 0) {
                    //Sex On The Beach
                    Text(food.name)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color("Primary 3"))
                
                    //Le Sex on the beach est un...
                    Text(food.foodDescription)
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(3)
            }
            
            VStack(alignment: .trailing) {
                Spacer()
                Text("\(String(format: "%.2f", food.price)) €")
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(Color("Primary 3"))
                    .multilineTextAlignment(.trailing)
                Text("x \(food.quantity)")
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(Color("Primary 3"))
                    .multilineTextAlignment(.trailing)
                
            }
        }
        .listRowBackground(Color("Background"))
        .background(Color("Background"))
        .frame(height: 60.0)
        
    }
}

#if DEBUG
struct OrderFoodRow_Previews: PreviewProvider {
    static var previews: some View {
        return OrderFoodRow(food: sexOnTheBeach)
            .previewLayout(.fixed(width: 355, height: 66))
            .background(Color("Background"))
    }
}
#endif
