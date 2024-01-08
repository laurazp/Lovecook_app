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
import Toast

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        
        switch viewModel.state {
        case .signedOut, .sessionError: AuthView().alert("Something went wrong...", isPresented: Binding.constant(viewModel.state == .sessionError)) {
            Button("OK") {}
        }
        case .signedIn: MainView()
        }
    }
}

#Preview {
    let viewModel = AuthenticationViewModel()
    
    return ContentView()
        .environmentObject(viewModel)
}
