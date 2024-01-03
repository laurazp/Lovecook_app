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

class AuthenticationViewModel: ObservableObject {

    @Published var state: SignInState = .signedOut
    private var authenticationManager =  AuthenticationManager()
    
    func checkSignInState() -> Bool {
        authenticationManager.checkSignInState { [unowned self] state in
            self.state = state
        }
    }
    
    func signIn() {
        self.authenticationManager.signIn { [unowned self] state in
            self.state = .signedIn
        }
    }
    
    func signOut() {
        self.authenticationManager.signOut { [unowned self] state in
            self.state = .signedOut
        }
    }
    
    func signInWithApple() {
        self.authenticationManager.signInWithApple()
    }
}
