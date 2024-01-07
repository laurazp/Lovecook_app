//
//  AuthView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI

struct AuthView: View {
    
    private struct Layout {
        static let appTitle = "LoveCook"
        static let logInButtonTitle = "Log in"
        static let signUpButtonTitle = "Sign up"
        static let accountSubtitle = "Don't have an account yet?"
        static let backgroundImageName = "food_background"
    }
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State var isLoggedIn = false
    
    var body: some View {
        
        if (!isLoggedIn) {
            NavigationStack {
                VStack(spacing: 18) {
                    Spacer()
                    
                    Text(Layout.appTitle)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    Spacer()
                    Spacer()
                    
                    Button {} label: {
                        NavigationLink(destination: LogInView()) {
                            Text(Layout.logInButtonTitle)
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }
                    }
                    .cornerRadius(20)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.lightGreen)
                    .controlSize(.large)
                    
                    Text(Layout.accountSubtitle)
                        .foregroundStyle(.white)
                        .opacity(0.8)
                        .font(.caption2)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text(Layout.signUpButtonTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .foregroundColor(.lightGreen)
                            .fontWeight(.bold)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.lightGreen, lineWidth: 1.7)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
                .padding(28)
                .background(
                    Image(Layout.backgroundImageName)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.8)
                )
                .onAppear {
                    isLoggedIn = viewModel.checkSignInWithGoogleState()
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
