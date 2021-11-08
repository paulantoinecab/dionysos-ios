//
//  URLImage.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 19/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI
import FetchImage

struct URLImage: View {
    
    @ObservedObject private var image: FetchImage
    
    var placeholder: Image
    var blurHash: String? = ""
    
    init(url: String, blurHash: String?) {
        self.blurHash = blurHash
        
        if let blurHash = self.blurHash, let image = UIImage(blurHash: blurHash, size: CGSize(width: 30.0, height: 20.0)) {
            self.placeholder = Image(uiImage: image)
        } else {
            self.placeholder = Image("Mojito")
        }
        
        if let url = URL(string: "\(url)") {
            image = FetchImage(url: url)
        } else {
            image = FetchImage(url: URL(string: "\(ServiceAPI.baseS3URL.rawValue)/\(ServiceAPI.media.rawValue)/restaurant/restaurant_3aa0a687-fde5-47da-835d-c2e0b0b6dd6c/shawn-ang-nmpW_WwwVSc-unsplash-2.jpg")!)
        }
    }
    
    var body: some View {
        ZStack {
            if let image = image.view {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }.animation(.easeOut)

    }
    
}
