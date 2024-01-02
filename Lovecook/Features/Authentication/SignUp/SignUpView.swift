//
//  SignUpView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("SIGN UP")
            Text("Thanks for joining us!")
            
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
            
            Button {
                viewModel.register()
            } label: {
                NavigationLink(destination: coordinator.makeUserMainView) {
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
    let coordinator = Coordinator()
    let viewModel = SignUpViewModel()
    
    return SignUpView()
        .environmentObject(viewModel)
        .environmentObject(coordinator)
}
