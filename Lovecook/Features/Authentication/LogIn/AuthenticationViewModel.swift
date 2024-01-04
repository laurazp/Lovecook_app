//
//  AuthenticationViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/12/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import Firebase
import GoogleSignIn
import AuthenticationServices

class AuthenticationViewModel: ObservableObject {

    @Published var state: SignInState = .signedOut
    private var authenticationManager =  AuthenticationManager()
    
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
}
