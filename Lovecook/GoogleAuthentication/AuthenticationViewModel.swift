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
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    
    func signIn() {
        /* if GIDSignIn.sharedInstance.hasPreviousSignIn() {
          //TODO: mirar cómo hacerlo!
          GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] result, error in
            authenticateUser(for: result, with: error)
        }
      } else {*/
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
          GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
              authenticateUser(for: result, with: error)
          }
      //}
    }
    
    private func authenticateUser(for result: GIDSignInResult?, with error: Error?) {
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
        guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }
      
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
      
      Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
        if let error = error {
          print(error.localizedDescription)
        } else {
          self.state = .signedIn
        }
      }
    }
    
    func signOut() {
      do {
        try Auth.auth().signOut()
        GIDSignIn.sharedInstance.signOut()
        self.state = .signedOut
      } catch {
        print(error.localizedDescription)
      }
    }
}
