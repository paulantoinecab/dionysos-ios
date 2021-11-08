//
//  RestaurantHeader.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 16/11/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct RestaurantHeader: View {
    @ObservedObject var orderViewModel: OrderViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            URLImage(url: orderViewModel.restaurant.profilePic, blurHash: orderViewModel.restaurant.profilePicHash)
                .clipShape(Circle())
                .frame(width: 120, height: 120)
            VStack(spacing: 4.0) {
                // La Madone
                Text(orderViewModel.restaurant.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("Primary 2"))
                
                //Table 12
                Text(orderViewModel.table.name)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color("Primary 2"))
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#if DEBUG
struct RestaurantHeader_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantHeader(orderViewModel: OrderViewModel(restaurant: restaurant, table: table))
    }
}
#endif
