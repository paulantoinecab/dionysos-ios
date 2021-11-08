//
//  LottieView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 12/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {

    var name: String
    var loopMode: LottieLoopMode
    

    init(name: String, loopMode: LottieLoopMode = .loop) {
        self.name = name
        self.loopMode = loopMode
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()

        let animationView = AnimationView()
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play { (complete) in
            if complete {
                view.alpha = 0.0
            } else {
                view.alpha = 1.0
            }
        }
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
}
struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(name: "plus")
            .frame(width: 200.0, height: 200.0)
        
    }
}
