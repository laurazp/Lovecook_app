//
//  MainView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        VStack(spacing: 26) {
            Spacer()
            
            Text("LoveCook")
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .font(.largeTitle)
            Spacer()
            Spacer()
            Button {
                
            } label: {
                Text("Log in")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            Button {
                
            } label: {
                Text("Sign up")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            Spacer()
        }
        .padding(24)
        .background(
            Image("food_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .opacity(0.8)
        )
    }
}

#Preview {
    MainView()
}
