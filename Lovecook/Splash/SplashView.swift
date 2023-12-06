//
//  SplashView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 5/12/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                ContentView()
            } else {
                LottieView(filename: "lottie_animation", loopMode: .playOnce)
                    .frame(width: 200, height: 200)
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
