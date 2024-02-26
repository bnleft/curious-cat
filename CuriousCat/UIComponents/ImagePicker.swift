import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @Binding var selectedImage: UIImage?
    var placeholderText: String
    
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    
    private let imageSize: CGFloat = 300
    private let borderSize: CGFloat = 1
    
    var body: some View {
        ZStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .cornerRadius(15)
                    .clipped()
            } else {
                PhotosPicker(
                    selection: $selectedPhotoItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Label(placeholderText, systemImage: "photo")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.gray)
                        .frame(width: imageSize, height: imageSize)
                        .background(Color.secondary.opacity(0.25))
                        .cornerRadius(15)
                }
                .onChange(of: selectedPhotoItem) {
                    Task {
                        if let data = try? await selectedPhotoItem?.loadTransferable(type: Data.self) {
                            selectedImage = UIImage(data: data)
                        }
                    }
                }
            }
        }
        .frame(width: imageSize, height: imageSize)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.clear)
                .frame(width: imageSize + borderSize, height: imageSize + borderSize)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.purple.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: borderSize)
        )
    }
}

