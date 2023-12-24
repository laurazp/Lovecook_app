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
                    LazyVGrid(columns: gridItemLayout, spacing: 14) {
                        ForEach(viewModel.photos, id: \.self) { photoName in
                            NavigationLink {
                                //TODO: Detail?
                                coordinator.makePhotoGalleryView()
                            } label: {
                                ZStack {
                                    KFImage(URL(string: photoName))
                                    //UIImage(named: photoName)
                                        /*.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .shadow(color: .black, radius: 5, x: 3, y: 5)
                                        .padding(12)
                                        .frame(width: 180, height: 200)
                                        .background(.brown)
                                        .cornerRadius(16)*/
                                    Text(photoName)
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .bold()
                                        .shadow(color: .black, radius: 5, x: 3, y: 5)
                                }
                                .frame(width: 190, height: 200)
                            }
                        }
                    }
                    .navigationTitle("Gallery")
                    .padding(12)
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                        .padding()
                }
            }
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getPhotos()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }.task {
            await viewModel.getPhotos()
        }.onChange(of: selectedItem, perform: { newValue in
            if let newValue {
                viewModel.saveUserImage(item: newValue)
            }
        })
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makePhotoGalleryView().environmentObject(coordinator)
}
