//
//  LogInView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI
import Toast

struct LogInView: View {
    
    private struct Layout {
        static let welcomeTitle = "WELCOME BACK!"
        static let accountSubtitle = "Log in to your account"
        static let emailSubtitle = "- or continue with e-mail -"
        static let emailHint = "Enter your Email"
        static let passwordHint = "Password"
        static let logInButtonTitle = "Log in"
        static let forgotPasswordText = "Forgot your password?"
        static let resetPasswordImageName = "envelope.fill"
        static let resetPasswordToastText = "Please check your email"
        static let subtitleSize: CGFloat = 16
        static let titleSize: CGFloat = 20
        static let socialButtonsStackSize: CGFloat = 150
    }
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    
    var body: some View {
        VStack(spacing: 22) {
            Text(Layout.welcomeTitle)
                .font(Font.system(size: Layout.titleSize))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.darkBlue)
            Text(Layout.accountSubtitle)
                .font(Font.system(size: Layout.subtitleSize))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.gray)
            
            VStack(spacing: 46) {
                GoogleSignInButton()
                    .padding()
                    .onTapGesture {
                        viewModel.signInWithGoogle()
                    }
                SignInWithAppleSwiftUIButton()
            }
            .frame(height: Layout.socialButtonsStackSize)
            
            Text(Layout.emailSubtitle)
                .font(Font.system(size: Layout.subtitleSize))
                .foregroundColor(Color.gray)
            
            TextField(Layout.emailHint, text: $userEmail)
                .authenticationTextfieldStyle()
            
            SecureField(Layout.passwordHint, text: $userPassword)
                .authenticationTextfieldStyle()
            
            GreenRoundedButton(buttonText: Layout.logInButtonTitle) {
                viewModel.logInWithEmailAndPassword(email: userEmail, password: userPassword)
            }
            
            Text(Layout.forgotPasswordText)
                .font(.caption)
                .foregroundColor(Color.gray)
                .onTapGesture {
                    if viewModel.resetPassword(withEmail: userEmail) {
                        Toast.default(
                            image: UIImage(systemName: Layout.resetPasswordImageName)!,
                            title: Layout.resetPasswordToastText).show()
                    }
                }
        }
        .padding()
    }
}

#Preview {
    LogInView()
}
