//
//  CategoryView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 11/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    let category: Category
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    var body: some View {
        return ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0.0) {
                ScrollView(.vertical, showsIndicators: false) {
                    CategoryHeader(category: category)
                        .environmentObject(orderViewModel)
                    VStack(spacing: 14.0) {
                        ForEach(category.foodSections.sorted(by: {$0.order <= $1.order}), id: \.id) {
                            subsection in
                            FoodSectionView(foodSection: subsection)
                                .environmentObject(orderViewModel)
                                .environmentObject(accountViewModel)
                        }
                    }.padding(.leading, 21.0)
                    .padding(.trailing, 11.0)
                    
                }
                .padding(.top, 16.0)
                
            }
            
        }.navigationBarTitle(Text(category.name), displayMode: .large)
    }
}

#if DEBUG
struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: cocktails)
    }
}
#endif
