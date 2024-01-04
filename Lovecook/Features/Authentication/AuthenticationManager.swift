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
import AuthenticationServices

typealias AuthenticationManagerCompletion = (SignInState)->Void

enum SignInState {
    case signedIn
    case signedOut
    case sessionError
}

final class AuthenticationManager {
    
    init() { }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authResult.user)
    }

    func checkSignInWithGoogleState(completion: @escaping AuthenticationManagerCompletion) -> Bool {
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
    
    func signInWithGoogle(completion: @escaping AuthenticationManagerCompletion) {
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
            //TODO: access `authResult` to add user info in UserAccountView and store it!
            let userID = authResult?.user.uid
            let userName = authResult?.additionalUserInfo?.username
            
            completion(.signedIn)
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
    
    //TODO: revisar y terminar
    /*func appleSignOut(completion: @escaping AuthenticationManagerCompletion) {
        do {
            try Auth.auth().signOut()
            
            guard let userID = currentAppleUserID else {
                            completion(.sessionError)
                            return
                        }
                
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userID) { credentialState, error in
                switch credentialState {
                case .authorized:
                    //todo: revoke
                    break
                case .revoked, .notFound:
                    // Already signed out or user doesn't exist
                    completion(.signedOut)
                case .transferred:
                    break
                @unknown default:
                    completion(.sessionError)
                }
            }
        } catch {
            print(error.localizedDescription)
            completion(.sessionError)
        }
    }*/
}
