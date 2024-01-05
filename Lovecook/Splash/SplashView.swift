//
//  SplashView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 5/12/23.
//

import SwiftUI

struct SplashView: View {
    
    struct Layout {
        static let frameSize: CGFloat = 200
        static let animationFilename = "lottie_animation"
    }
    
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                ContentView()
            } else {
                LottieView(
                    filename: Layout.animationFilename,
                    loopMode: .playOnce)
                .frame(
                    width: Layout.frameSize,
                    height: Layout.frameSize)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.8) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
