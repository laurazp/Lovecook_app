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
    private let permissionUtils = PermissionUtils()
    
    let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var showImagePicker = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var imageName: String = ""
    
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
                        ForEach(viewModel.photos, id: \.id) { photo in
                            VStack(alignment: .center) {
                                RemoteImageView(downloadURL: photo.url)
                                    .frame(width: 110, height: 120)
                                
                                Text(photo.name)
                                    .lineLimit(1)
                                    .foregroundStyle(.black)
                                    .bold()
                                    .shadow(color: .gray, radius: 5, x: 3, y: 3)
                            }
                        }
                    }
                    .navigationTitle("Gallery")
                }.padding()
                
                VStack(spacing: 14) {
                    Text("Enter a name for your image before choosing one!")
                        .foregroundStyle(.black)
                        .bold()
                        .font(.caption)
                    TextField("Your image name", text: $imageName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    //TODO: Gestionar permisos cámara y permitir acceso a cámara de fotos
                    
                    Button {
                        Task {
                            await permissionUtils.requestPhotoLibraryAccess()
                            /*if await permissionUtils.hasPhotoLibraryPermission {
                                showImagePicker = true
                            }*/
                        }
                    } label: {
                        /*PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {*/
                            Image(systemName: "camera.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                                .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                        //}
                    }
                    
                    Text("Share your recipes with our community!")
                        .foregroundStyle(.black)
                        .bold()
                }/*.sheet(isPresented: $showImagePicker) {
                    PhotosPicker("", selection: $selectedItem, matching: .images, photoLibrary: .shared())
                }*/
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.lightGreen.opacity(0.5))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                .padding([.horizontal, .vertical], 20)
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
        }.onChange(of: selectedItem) { newValue in
            guard let newValue else { return }
            viewModel.saveUserImage(item: newValue, title: imageName) { clearedText in
                imageName = clearedText
            }
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makePhotoGalleryView().environmentObject(coordinator)
}
