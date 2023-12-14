//
//  LogInView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI

struct LogInView: View {
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    
    var body: some View {
        VStack(spacing: 18) {
            Text("WELCOME BACK!")
            Text("Log in to your account")
            
            //TODO: View para acceder a login de Google/Apple
            
            Text("- or continue with e-mail -")
            
            TextField("Enter your Email", text: $userEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $userPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                //TODO: log in with email??
            } label: {
                NavigationLink(destination: HomeView()) {
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
