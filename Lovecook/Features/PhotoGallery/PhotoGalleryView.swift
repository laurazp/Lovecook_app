//
//  PhotoGalleryView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 24/12/23.
//

import SwiftUI
import Kingfisher
import PhotosUI
import Toast

struct PhotoGalleryView: View {
    
    private struct Layout {
        static let galleryTitle = "Gallery"
        static let uploadImageText = "Enter a name for your image before choosing one!"
        static let imageNameTextfieldHint = "Your image name"
        static let photoPickerImageName = "camera.fill"
        static let shareRecipesText = "Share your recipes with our community!"
    }
    
    @StateObject private var viewModel: PhotoGalleryViewModel
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.colorScheme) var colorScheme
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
                                    .bold()
                                    .shadow(color: .gray, radius: 5, x: 3, y: 3)
                            }
                        }
                    }
                    .navigationTitle(Layout.galleryTitle)
                }.padding()
                
                // MARK: - Upload image
                VStack(spacing: 14) {
                    Text(Layout.uploadImageText)
                        .bold()
                        .font(.caption)
                    TextField(Layout.imageNameTextfieldHint, text: $imageName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                        Image(systemName: Layout.photoPickerImageName)
                            .font(.system(size: 30))
                            .foregroundColor(showImagePicker ? .black : .gray)
                            .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                    }
                    .disabled(!showImagePicker)
                    
                    Text(Layout.shareRecipesText)
                        .bold()
                }
                .onAppear {
                    Task {
                        await permissionUtils.requestPhotoLibraryAccess() { granted in
                            if granted {
                                showImagePicker = true
                            } else {
                                showImagePicker = false
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.lightGreen)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                .padding([.horizontal, .vertical], 20)
            }
        }
        .errorLoadingListAlertDialog(error: viewModel.error, errorMessage: viewModel.error?.localizedDescription, retryButtonAction: {
            Task {
                viewModel.getPhotosFromFirebase()
            }
        })
        .task {
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
