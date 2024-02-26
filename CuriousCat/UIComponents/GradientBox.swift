import SwiftUI

struct GradientBox: View {
    @State private var gradientStartPoint: UnitPoint = .topLeading
    @State private var gradientEndPoint: UnitPoint = .bottomTrailing
    var image: UIImage?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
               if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .cornerRadius(15)
                }
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.clear)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.5)]), startPoint: gradientStartPoint, endPoint: gradientEndPoint)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.purple.opacity(0.5)]), startPoint: gradientStartPoint, endPoint: gradientEndPoint), lineWidth: 2)
                    )
            }
        }
    }
}

