//
//  AuthenticationManager.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 27/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import GoogleSignIn
import FirebaseCore
import AuthenticationServices

typealias AuthenticationManagerCompletion = (SignInState)->Void

enum SignInState {
    case signedIn
    case signedOut
    case sessionError
}

final class AuthenticationManager {
    
    init() { }
    
    // MARK: - GoogleSignIn
    func checkSignInWithGoogleState(completion: @escaping AuthenticationManagerCompletion) -> Bool {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                if let error = error {
                    print("Error restoring previous sign-in: \(error.localizedDescription)")
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
    
    func signInWithGoogle(completion: @escaping AuthenticationManagerCompletion) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
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
        else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.sessionError)
            }
            if let user = result?.user {
                print(user)
                completion(.signedIn)
            }
            else {
                completion(.signedOut)
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
    
    // MARK: - AppleSignIn
    func signInWithApple(authResults: ASAuthorization, completion: @escaping AuthenticationManagerCompletion) {
        guard let credential = authResults.credential as? ASAuthorizationAppleIDCredential else {
            print("Unable to get Apple credential")
            return
        }
        
        let token = credential.identityToken
        guard let tokenString = String(data: token!, encoding: .utf8) else {
            print("Unable to convert token to string")
            return
        }
        
        let oauthCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nil)
        
        Auth.auth().signIn(with: oauthCredential) { (authResult, error) in
            if let error = error {
                print("Firebase sign in with Apple failed: \(error.localizedDescription)")
                completion(.sessionError)
                return
            }
            
            print("Firebase sign in with Apple successful")
            completion(.signedIn)
            
            //TODO: Store user data in Firebase storage
            let userID = authResult?.user.uid
            let userName = authResult?.additionalUserInfo?.username
        }
    }
    
    func checkSignInWithAppleState(completion: @escaping AuthenticationManagerCompletion) -> Bool {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: Auth.auth().currentUser?.uid ?? "") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                completion(.signedIn)
            case .revoked, .notFound:
                DispatchQueue.main.async {
                    completion(.signedOut)
                }
            default:
                break
            }
        }
        return true
    }
    
    func appleSignOut(completion: @escaping AuthenticationManagerCompletion) {
        do {
            try Auth.auth().signOut()
            completion(.signedOut)
        } catch {
            print(error.localizedDescription)
            completion(.sessionError)
        }
    }
    
    // MARK: - Email & password SignIn and Register
    func registerWithEmailAndPassword(email: String, password: String, completion: @escaping AuthenticationManagerCompletion) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error as? NSError {
                switch AuthErrorCode(_nsError: error).code {
                case .operationNotAllowed:
                    print("The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.")
                case .emailAlreadyInUse:
                    print("Email already in use.")
                case .invalidEmail:
                    print("The email address has an incorrect format.")
                case .weakPassword:
                    print("The password must be 6 characters long or more.")
                default:
                    print("Error: \(error.localizedDescription)")
                }
            }
            print("Success creating the user!")
            //TODO: Store user data in Firebase storage
            let user  = result?.user
        }
    }
    
    func loginWithEmailAndPassword(email: String, password: String, completion: @escaping AuthenticationManagerCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Log in failed: \(error.localizedDescription)")
                let user = result?.user
                completion(.sessionError)
            } else {
                completion(.signedIn)
            }
        }
    }
    
    func checkEmailSingInState(completion: @escaping AuthenticationManagerCompletion) -> Bool {
        if let user = Auth.auth().currentUser {
            return true
        } else {
            return false
        }
    }
    
    func resetUserPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    //TODO: cambiar de [] a map y terminar o borrar!!
    func getUserInfo() -> [String] {
        var userInfo = ["", "", ""]
        
        let googleUser = checkSignInWithGoogleState {_ in
            let userName = GIDSignIn.sharedInstance.currentUser?.profile?.name ?? ""
            let userEmail = GIDSignIn.sharedInstance.currentUser?.profile?.email ?? ""
            let userImage = GIDSignIn.sharedInstance.currentUser?.profile?.imageURL(withDimension: 200)?.absoluteString ?? ""
            userInfo = [userName, userEmail, userImage]
        }
        
        let appleUser = checkSignInWithAppleState { _ in
            userInfo = ["", "", ""]
        }
        
        return userInfo
    }
}
