//
//  SectionView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 11/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct SectionView: View {
    let section: Section
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel

    var body: some View {
        VStack(spacing: 6.0) {
            HStack {
                Text(section.name)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color("Primary 1"))
                    .padding(.leading, 12.0)
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12.0) {
                    ForEach(section.categories.sorted(by: {$0.order <= $1.order}), id: \.id) {
                        category in
                        NavigationLink(destination: CategoryView(category: category)
                                        .environmentObject(orderViewModel)
                                        .environmentObject(accountViewModel)) {
                            CategoryCardView(category: category)
                        }.buttonStyle(PlainButtonStyle())
                        
                    }
                }
                .padding(.horizontal, 15.0)
            }
        }
        .frame(height: 211.0)
    }
}

#if DEBUG
struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: aLaUne)
            .previewLayout(.fixed(width: 412, height: 213))
            .background(Color("Background"))
        
    }
}
#endif
