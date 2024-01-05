//
//  SignUpView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("SIGN UP")
                .font(Font.system(size: 20))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.darkBlue)
            Text("Thanks for joining us!")
                .font(Font.system(size: 16))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.gray)
            
            TextField("Enter your email", text: $viewModel.userEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            SecureField("Choose a password", text: $viewModel.userPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            Toggle(isOn: $viewModel.isAccepted) {
                Text("I have read and agree to the Terms and Conditions")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            .toggleStyle(CheckboxToggleStyle.init())
            
            GreenRoundedButton(buttonText: "Sign up") {
                viewModel.register()
            }
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
