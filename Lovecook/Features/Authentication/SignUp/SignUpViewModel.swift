//
//  SignUpViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 27/12/23.
//

import Foundation
import Firebase

@MainActor
class SignUpViewModel: ObservableObject {
    
    private var authenticationManager =  AuthenticationManager()
    
    @Published var state: SignInState = .signedOut
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    @Published var isAccepted: Bool = false
    
    func register() {
        //TODO: gestionar isAccepted
        guard !userEmail.isEmpty, !userPassword.isEmpty else {
            print("No email or password found.")
            return
        }
        
        Task {
            do {
                let user = try await self.authenticationManager.createUser(email: userEmail, password: userPassword) 
                print("Success creating the user!")
                print(user)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    //TODO: es necesario aquí para loguear nada más registrarse??
    func login() {
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { authResult, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
