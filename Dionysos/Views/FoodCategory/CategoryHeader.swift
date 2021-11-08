//
//  CategoryHeader.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 11/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct CategoryHeader: View {
    let category: Category
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12.0) {
                ForEach(category.headers.sorted(by: {$0.order <= $1.order}), id: \.id) {
                    food in
                    NavigationLink(destination: FoodDetailView( food: food)
                                    .environmentObject(orderViewModel)
                                    .environmentObject(accountViewModel)
                    ) {
                        FoodCard(food: food)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }.padding(.horizontal, 15.0)
        }
    }
}

#if DEBUG
struct CategoryHeader_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHeader(category: cocktails)
            .previewLayout(.fixed(width: 412, height: 171))
            .background(Color("Background"))
    }
}
#endif
