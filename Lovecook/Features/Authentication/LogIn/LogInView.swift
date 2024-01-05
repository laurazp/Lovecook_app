//
//  LogInView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 9/12/23.
//

import SwiftUI
import Toast

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
                          viewModel.signInWithGoogle()
                        }
                SignInWithAppleSwiftUIButton()
            }
            .frame(height: 150)

            Text("- or continue with e-mail -")
                .font(Font.system(size: 16))
                .foregroundColor(Color.gray)
            
            TextField("Enter your Email", text: $userEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $userPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            GreenRoundedButton(buttonText: "Log in") {
                viewModel.logInWithEmailAndPassword(email: userEmail, password: userPassword)
            }
            
            Text("Forgot your password?")
                .font(.caption)
                .foregroundColor(Color.gray)
                .onTapGesture {
                    if viewModel.resetPassword(withEmail: userEmail) {
                        Toast.default(
                            image: UIImage(systemName: "envelope.fill")!,
                            title: "Please check your email").show()
                    }
                }
        }
        .padding()
    }
}

#Preview {
    LogInView()
}
