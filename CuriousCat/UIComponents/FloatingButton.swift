import SwiftUI

struct FloatingButton: View {
    @State private var gradientStartPoint: UnitPoint = .topLeading
    @State private var gradientEndPoint: UnitPoint = .bottomTrailing
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.purple.opacity(0.5)]), startPoint: gradientStartPoint, endPoint: gradientEndPoint))
                    .frame(width: 64, height: 64)
                
                Circle()
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color.white, Color.purple]), startPoint: gradientStartPoint, endPoint: gradientEndPoint), lineWidth: 2)
                    .frame(width: 68, height: 68)
                
                Image(systemName: "plus")
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
            }
        }
        .shadow(color: Color.black.opacity(0.8), radius: 5, x: 0, y: 2)
        .padding(.all, 10)
    }
}
