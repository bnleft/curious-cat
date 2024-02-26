import SwiftUI

struct DetailView: View {
    var imagePrompt: ImagePrompt
    var body: some View {
        VStack {
            HStack {
                Image("cat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                Text(imagePrompt.catText)
                    .font(.title2)
                    .fontWeight(.medium)
            }
            
            HStack {
                Image(uiImage: imagePrompt.image)
                    .resizable()
                    .scaledToFit()
                Image(uiImage: imagePrompt.generatedImage)
                    .resizable()
                    .scaledToFit()
            }
            Text("Prompt: " +  imagePrompt.prompt)
                .padding()
        }
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
    }
}
