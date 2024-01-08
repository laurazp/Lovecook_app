//
//  UserAccountView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI
import GoogleSignIn

struct UserAccountView: View {
    
    private struct Layout {
        static let signOutButtonTitle = "Sign out"
        static let defaultUserDataText = "Unable to retrieve user data."
    }
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
        
    var body: some View {
        let user = viewModel.getUser()

        NavigationView {
            VStack(spacing: 28) {
                UserNetworkImage(url: user?.profile?.imageURL(withDimension: 200))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .center)
                    .cornerRadius(8)
                    .clipShape(Circle())
       
                VStack(alignment: .leading, spacing: 18) {
                    Text(user?.profile?.name ?? "")
                        .font(.headline)
                    
                    Text(user?.profile?.email ?? Layout.defaultUserDataText)
                        .font(.subheadline)
                    
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.lightGreen)
                .cornerRadius(12)
                
                Button {
                    viewModel.signOut()
                } label: {
                    Text(Layout.signOutButtonTitle)
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                .cornerRadius(20)
                .buttonStyle(.borderedProminent)
                .tint(Color.darkBlue)
                .controlSize(.large)
            }
            .padding(22)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    let viewModel = AuthenticationViewModel()
    
    return UserAccountView()
        .environmentObject(viewModel)
}
