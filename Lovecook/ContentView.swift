//
//  ContentView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI
import CoreData
import FirebaseCore
import FirebaseAuth
import Firebase
import GoogleSignIn

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        
        switch viewModel.state {
        case .signedOut, .sessionError: AuthView().overlay {
            if viewModel.state == .sessionError {
                errorView
            }
        }
        case .signedIn: MainView()
        }
    }
    
    var errorView: some View {
        Text("Something went wrong...")
    }
}

#Preview {
    let viewModel = AuthenticationViewModel()
    
    return ContentView()
        .environmentObject(viewModel)
}
