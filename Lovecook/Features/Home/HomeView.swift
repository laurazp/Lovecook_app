//
//  HomeView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import SwiftUI
import GoogleSignIn

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    private let user = GIDSignIn.sharedInstance.currentUser
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text(user?.profile?.name ?? "")
                            .font(.headline)
                        
                        Text(user?.profile?.email ?? "")
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding()
                
                Spacer()
                
                //TODO: Revisar !!!
                Button {
                    viewModel.signOut()
                } label: {
                    Text("Sign out")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                        
                }
                .cornerRadius(20)
                .buttonStyle(.borderedProminent)
                .tint(Color.darkBlue)
                .controlSize(.large)
                .padding(38)
            }
            .navigationTitle("Home")
            .padding(16)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NetworkImage: View {
    let url: URL?
    
    var body: some View {
        if let url = url,
           let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}


#Preview {
    let viewModel = AuthenticationViewModel()

    return HomeView()
        .environmentObject(viewModel)
}
