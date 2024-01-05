//
//  AuthenticationViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/12/23.
//

import Foundation
import AuthenticationServices
import Toast

class AuthenticationViewModel: ObservableObject {

    private var authenticationManager =  AuthenticationManager()
    @Published var state: SignInState = .signedOut
    
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    @Published var isAccepted: Bool = false
    
    var userType: String = ""
    
    func checkSignInWithGoogleState() -> Bool {
        authenticationManager.checkSignInWithGoogleState { [unowned self] state in
            self.state = state
        }
    }
    
    func signInWithGoogle() {
        self.authenticationManager.signInWithGoogle { [unowned self] state in
            self.state = .signedIn
        }
    }
    
    func signOut() {
        self.authenticationManager.signOut { [unowned self] state in
            self.state = .signedOut
        }
    }
    
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
    
    func logInWithEmailAndPassword(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        authenticationManager.loginWithEmailAndPassword(email: email, password: password) { [unowned self] state in
            self.state = state
        }
    }
    
    func resetPassword(withEmail email: String) -> Bool {
        guard !email.isEmpty else {
            Toast.default(image: UIImage(systemName: "info.circle")!, title: "Please enter your email.").show()
            return false
        }
        authenticationManager.resetUserPassword(withEmail: email)
        return true
    }
    
    func register() {
        if isAccepted {
            guard !userEmail.isEmpty, !userPassword.isEmpty else {
                print("No email or password found.")
                return
            }
            
            authenticationManager.registerWithEmailAndPassword(email: userEmail, password: userPassword) { [unowned self] state in
                self.state = .signedIn
            }
        } else {
            print("You have to accept the Terms and conditions to register.")
            return
        }
    }
    
    func getUserInfo() -> String {
        switch authenticationManager.getUserInfo() {
        case "email":
            return ""
        case "google":
            return ""
        case "apple":
            return ""
        default:
            break
        }
        return ""
    }
}
