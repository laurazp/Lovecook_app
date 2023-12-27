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
        VStack(spacing: 18) {
            Text("WELCOME BACK!")
                .font(Font.system(size: 20))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.darkBlue)
            Text("Log in to your account")
                .font(Font.system(size: 16))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.gray)
             
            VStack {
                GoogleSignInButton()
                        .padding()
                        .onTapGesture {
                          viewModel.signIn()
                        }
                
                //TODO: Botón para acceder a login de Apple ???
            }
            .frame(height: 120)

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
