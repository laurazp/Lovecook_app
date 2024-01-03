//
//  AuthenticationManager.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 27/12/23.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

typealias AuthenticationManagerCompletion = (SignInState)->Void

enum SignInState {
    case signedIn
    case signedOut
    case sessionError
}

final class AuthenticationManager {
    
    init() { }
    
    func checkSignInState(completion: @escaping AuthenticationManagerCompletion) -> Bool {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                if let error = error {
                    print("Error restoring previous sign-in: \(error.localizedDescription)")
                    //TODO: Handle the error if necessary
                    completion(.sessionError)
                } else if let user = user {
                    authenticateUser(for: user, with: error, completion: completion)
                }
            }
            return true
        } else {
            return false
        }
    }
    
    func signIn(completion: @escaping AuthenticationManagerCompletion) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
            
            if let error = error {
                print("Error restoring previous sign-in: \(error.localizedDescription)")
                //TODO: Handle the error if necessary
                completion(.sessionError)
            } else if let result = result {
                authenticateUser(for: result.user, with: error, completion: completion)
            }
        }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, 
                                  with error: Error?,
                                  completion: @escaping AuthenticationManagerCompletion) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let user = user,
              let idToken = user.idToken?.tokenString
        else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: user.accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.sessionError)
            } else {
                completion(.signedIn)
            }
        }
    }
    
    func signOut(completion: @escaping AuthenticationManagerCompletion) {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            completion(.signedOut)
        } catch {
            print(error.localizedDescription)
            completion(.sessionError)
        }
    }
    
    func signInWithApple() {
        
    }
}
