//
//  AuthenticationViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/12/23.
//

import Foundation
import AuthenticationServices
import Toast
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    
    private var authenticationManager =  AuthenticationManager()
    @Published var state: SignInState = .signedOut
    
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    @Published var isAccepted: Bool = false
    
    // MARK: - GoogleSignIn
    func signInWithGoogle() {
        self.authenticationManager.signInWithGoogle { [unowned self] state in
            self.state = .signedIn
        }
    }
    
    func checkSignInWithGoogleState() -> Bool {
        authenticationManager.checkSignInWithGoogleState { [unowned self] state in
            self.state = state
        }
    }
    
    // MARK: - AppleSignIn
    func signInWithApple(authResults: ASAuthorization) {
        self.authenticationManager.signInWithApple(authResults: authResults) { [unowned self] state in
            self.state = .signedIn
        }
    }
    
    func checkSignInWithAppleState() -> Bool {
        authenticationManager.checkSignInWithAppleState { [unowned self] state in
            self.state = state
        }
    }
    
    // MARK: - Email & password SignIn and Register
    func logInWithEmailAndPassword(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            Toast.default(
                image: UIImage(systemName: "info.circle")!,
                title: "Email and password needed.").show()
            return
        }
        authenticationManager.loginWithEmailAndPassword(email: email, password: password) { [unowned self] state in
            self.state = state
        }
    }
    
    func resetPassword(withEmail email: String) -> Bool {
        guard !email.isEmpty else {
            Toast.default(
                image: UIImage(systemName: "info.circle")!,
                title: "Please enter your email.").show()
            return false
        }
        authenticationManager.resetUserPassword(withEmail: email)
        return true
    }
    
    func register() {
        if isAccepted {
            guard !userEmail.isEmpty, !userPassword.isEmpty else {
                Toast.default(
                    image: UIImage(systemName: "envelope.fill")!,
                    title: "Email and password needed",
                    subtitle: "Please enter valid email and password"
                ).show()
                return
            }
            authenticationManager.registerWithEmailAndPassword(email: userEmail, password: userPassword) { [unowned self] state in
                self.state = state
            }
        } else {
            Toast.default(
                image: UIImage(systemName: "pencil.and.list.clipboard")!,
                title: "Terms and conditions",
                subtitle: "You have to accept Terms and conditions"
            ).show()
            return
        }
    }
    
    // MARK: - Common
    func signOut() {
        self.authenticationManager.signOut { [unowned self] state in
            self.state = .signedOut
        }
    }
    
    func getUser() -> GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser
    }
}
