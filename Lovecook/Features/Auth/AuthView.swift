//
//  AuthView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State var isLoggedIn = false
    
    var body: some View {
        
        if (!isLoggedIn) {
            NavigationStack {
                VStack(spacing: 18) {
                    Spacer()
                    
                    Text("LoveCook")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    Spacer()
                    Spacer()
                    
                    Button {} label: {
                        NavigationLink(destination: LogInView()) {
                            Text("Log in")
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                            .foregroundColor(Color.white)}
                    }
                    .cornerRadius(20)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.lightGreen)
                    .controlSize(.large)
                    
                    Text("Don't have an account yet?")
                        .foregroundStyle(.white)
                        .opacity(0.8)
                        .font(.caption2)
                    
                    //TODO: fix link to also work in text!!
                    NavigationLink(destination: SignUpView()) {
                        Button("Sign up") {}
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                            .foregroundStyle(.lightGreen)
                            .fontWeight(.bold)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.lightGreen, lineWidth: 1.7)
                            )
                    }
                    Spacer()
                }
                .padding(28)
                .background(
                    Image("food_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.8)
                )
                .onAppear {
                    isLoggedIn = viewModel.checkSignInState()
                }
            }
        }
    }
}

#Preview {
    let viewModel = AuthenticationViewModel()
    
    return AuthView()
        .environmentObject(viewModel)
}
