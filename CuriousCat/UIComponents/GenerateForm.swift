import SwiftUI
import PhotosUI

struct GenerateForm: View {
    @Binding var generatedImagePrompts: [ImagePrompt]
    
    var updateCatText: (String) -> Void
    var cat: Cat = Cat()
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var keyboard = KeyboardResponder()

    @State private var inputText: String = ""
    @State private var selectedImage: UIImage? = nil

    @FocusState private var isInputActive: Bool

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Generate Photo Edit")
                        .foregroundColor(Color.gray)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    Text("Select Image")
                    HStack(spacing: 20) {
                        ImagePicker(selectedImage: $selectedImage, placeholderText: "Select Image")
                    }
                    
                    Text("Enter Prompt")
                        .padding(.top, 20)
                    
                    resizableTextField
                }
                .padding(.horizontal)
            }
            .background(Color.clear)
            .onTapGesture {
                isInputActive = false
            }
            
            Spacer()
            
            gradientBorderButton
                .padding(.bottom, 60)
        }
        .background(Color(UIColor.secondarySystemBackground))
        .edgesIgnoringSafeArea(.all)
        .focused($isInputActive)
        .offset(y: -keyboard.currentHeight * 0.001)
        .animation(.easeOut(duration: 0.16), value: keyboard.currentHeight)
    }
    
    var resizableTextField: some View {
        ZStack(alignment: .topLeading) {
            
            
            TextEditor(text: $inputText)
                .padding(4)
                .background(Color.clear)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.purple.opacity(0.5)]), startPoint: .leading, endPoint: .trailing), lineWidth: 1)
                )
                .frame(minHeight: 100, maxHeight: .infinity)
                .focused($isInputActive)
        }
        .padding(.horizontal)
    }
    
    var gradientBorderButton: some View {
        Button(action: {
            print("Prompt Text:", inputText)
            if let newImage = generateImage(from: inputText) {
                generatedImagePrompts.append(ImagePrompt(image: selectedImage!, prompt: inputText, generatedImage: newImage, catText: cat.meow()))
                updateCatText(inputText)
            }
            isInputActive = false
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "wand.and.stars")
                Text("Generate")
            }
            .font(.title)
            .foregroundColor(.white)
            .padding()
        }
        .background(Color.purple.opacity(selectedImage != nil ? 0.3 : 0.1))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.purple.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.8), radius: 5, x: 0, y: 2)
        .frame(maxWidth: .infinity)
        .disabled(selectedImage == nil)
    }
    
    func generateImage(from prompt: String) -> UIImage? {
        return selectedImage
    }
}

