//
//  PhotoGalleryView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 24/12/23.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct PhotoGalleryView: View {
    @StateObject private var viewModel: PhotoGalleryViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var selectedItem: PhotosPickerItem? = nil
    
    init(viewModel: PhotoGalleryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 18) {
                        ForEach(viewModel.photos, id: \.self) { photoName in
                            NavigationLink {
                                //TODO: Detail?
                                //coordinator.makePhotoDetailView()
                            } label: {
                                VStack(alignment: .center) {
                                    RemoteImageView(downloadURL: photoName)
                                        .frame(width: 110, height: 120)
                                    
                                    Text("photo name")
                                        .foregroundStyle(.black)
                                        .bold()
                                        .shadow(color: .gray, radius: 5, x: 3, y: 3)
                                }
                            }
                        }
                    }
                    //.id(UUID())
                    //.id(viewModel.refreshView)
                    .navigationTitle("Gallery")
                    /*.onChange(of: viewModel.photos) {
                        viewModel.getPhotosFromFirebase()
                    }*/
                }.padding()
                
                VStack {
                    //TODO: Gestionar permisos cámara y permitir acceso a cámara de fotos
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                            .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                            .padding()
                    }
                    Text("Share your recipes with our community!")
                        .foregroundStyle(.black)
                        .bold()
                }.padding()
            }
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    viewModel.getPhotosFromFirebase()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }.task {
            viewModel.getPhotosFromFirebase()
        }.onChange(of: selectedItem, perform: { newValue in
            if let newValue {
                viewModel.saveUserImage(item: newValue)
                //TODO: añadir foto al grid y recargar
                //viewModel.getPhotosFromFirebase()
            }
        })
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makePhotoGalleryView().environmentObject(coordinator)
}
