//
//  SignUpView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var newUserName: String = ""
    @State private var newUserEmail: String = ""
    @State private var newUserPassword: String = ""
    @State private var isAccepted: Bool = false
    
    var body: some View {
        VStack(spacing: 18) {
            Text("SIGN UP")
            Text("Thanks for joining us!")
                
            TextField("Enter your name", text: $newUserName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Enter your email", text: $newUserEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Choose a password", text: $newUserPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            //TODO: Checkbox
            Toggle(isOn: $isAccepted) {
                Text("I have read and agree to the Terms and Conditions")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            .toggleStyle(CheckboxToggleStyle.init())
            
            Button {
                //TODO: check and save user data
            } label: {
                //TODO: login o home? ckechear primero
                NavigationLink(destination: HomeView()) {
                    Text("Sign up")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                    .foregroundColor(Color.white)}
            }
            .cornerRadius(20)
            .buttonStyle(.borderedProminent)
            .tint(Color.lightGreen)
            .controlSize(.large)
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
