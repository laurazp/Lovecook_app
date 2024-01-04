//
//  LogInView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel

    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    
    var body: some View {
        VStack(spacing: 22) {
            Text("WELCOME BACK!")
                .font(Font.system(size: 20))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.darkBlue)
            Text("Log in to your account")
                .font(Font.system(size: 16))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.gray)
             
            VStack(spacing: 46) {
                GoogleSignInButton()
                        .padding()
                        .onTapGesture {
                          viewModel.signIn()
                        }
                SignInWithAppleSwiftUIButton()
                //TODO: aún falta que lleve a página de inicio al loguear
                
            }
            .frame(height: 150)

            Text("- or continue with e-mail -")
                .font(Font.system(size: 16))
                .foregroundColor(Color.gray)
            
            TextField("Enter your Email", text: $userEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $userPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                //TODO: log in with email??
            } label: {
                NavigationLink(destination: MainView()) {
                    Text("Log in")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                    .foregroundColor(Color.white)}
            }
            .cornerRadius(20)
            .buttonStyle(.borderedProminent)
            .tint(Color.lightGreen)
            .controlSize(.large)
            
            Text("Forgot your password?")
                .font(.caption)
                .foregroundColor(Color.gray)
        }
        .padding()
    }
}

#Preview {
    LogInView()
}
