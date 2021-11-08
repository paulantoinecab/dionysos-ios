//
//  FoodSectionView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 11/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct FoodSectionView: View {
    let foodSection: FoodSection
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel

    var body: some View {
        VStack(spacing: 12.0) {
            //Large Title
            HStack {
                Text(foodSection.name)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color("Primary 1"))
                Spacer()
            }
            ForEach(foodSection.food.sorted(by: {$0.order <= $1.order}), id: \.id) {
                food in
                NavigationLink(destination: FoodDetailView(food: food)
                                .environmentObject(orderViewModel)
                                .environmentObject(accountViewModel)) {
                    FoodRow(food: food)
                }
                .buttonStyle(PlainButtonStyle())

            }
        }
    }
}

#if DEBUG
struct FoodSectionView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSectionView(foodSection: cocktailsDuMoment)
            .background(Color("Background"))
    }
}
#endif
