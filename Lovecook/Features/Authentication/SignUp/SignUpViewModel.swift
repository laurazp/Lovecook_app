//
//  SignUpViewModel.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 27/12/23.
//

import Foundation
import Firebase

class SignUpViewModel: ObservableObject {
    
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    @Published var isAccepted: Bool = false
    
    func register() {
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    //TODO: es necesario aquí para loguear nada más registrarse??
    func login() {
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
