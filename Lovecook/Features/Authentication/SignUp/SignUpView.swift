//
//  SignUpView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI

struct SignUpView: View {
    
    private struct Layout {
        static let signUpTitle = "SIGN UP"
        static let signUpSubtitle = "Thanks for joining us!"
        static let emailSubtitle = "- or continue with e-mail -"
        static let emailHint = "Enter your Email"
        static let passwordHint = "Choose a password"
        static let signUpButtonTitle = "Sign up"
        static let termsAndConditionsText = "I have read and agree to the Terms and Conditions"
        static let subtitleSize: CGFloat = 16
        static let titleSize: CGFloat = 20
    }
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text(Layout.signUpTitle)
                .font(Font.system(size: Layout.titleSize))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.darkBlue)
            Text(Layout.signUpSubtitle)
                .font(Font.system(size: Layout.subtitleSize))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.gray)
            
            TextField(Layout.emailHint, text: $viewModel.userEmail)
                .authenticationTextfieldStyle()
            
            SecureField(Layout.passwordHint, text: $viewModel.userPassword)
                .authenticationTextfieldStyle()
            
            Toggle(isOn: $viewModel.isAccepted) {
                Text(Layout.termsAndConditionsText)
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            .toggleStyle(CheckboxToggleStyle.init())
            
            GreenRoundedButton(buttonText: Layout.signUpButtonTitle) {
                viewModel.register()
            }
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
