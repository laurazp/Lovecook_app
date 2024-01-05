//
//  SignUpViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 27/12/23.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    private var authenticationManager =  AuthenticationManager()
    @Published var state: SignInState = .signedOut
    
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    @Published var isAccepted: Bool = false
    
    @MainActor
    func register() {
        //TODO: gestionar isAccepted
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
}
