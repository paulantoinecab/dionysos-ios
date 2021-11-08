//
//  CategoryCardView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 10/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct CategoryCardView: View {
    let category: Category
    
    var body: some View {
        VStack(spacing: 8.0) {
        //Rectangle 2
            ZStack {
                URLImage(url: category.image, blurHash: category.imageHash)
                .frame(width: 200, height: 135)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0.0, y: 5.0)
            HStack {
            //Cocktails
                Text(category.name).font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color("Primary 3"))
                Spacer()
            }.padding(.leading, 8.0)
        }
        .frame(width: 200.0, height: 167.0)
    }
}

#if DEBUG
struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        return CategoryCardView(category: planches)
            .previewLayout(.fixed(width: 200, height: 156.0))
        .background(Color("Background"))

    }
}
#endif
