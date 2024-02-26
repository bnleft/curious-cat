import SwiftUI

struct ContentView: View {
    @State private var generatedImagePrompts: [ImagePrompt] = []
    @State private var showingForm = false
    @State private var catText: String = "Purrrrr... generated with ml-mgie <3"
    var cat: Cat = Cat()
    
    init() {
        _generatedImagePrompts = State(initialValue: [
            ImagePrompt(
                image: UIImage(named: "crab")!,
                prompt: "turn this crab yellow",
                generatedImage: UIImage(named: "yellow-crab")!, 
                catText: "i love crab, it's yellow now!"
            ),
            ImagePrompt(
                image: UIImage(named: "dragon-cat")!,
                prompt: "give this cat red eyes",
                generatedImage: UIImage(named: "evil-dragon-cat")!, 
                catText: "this cat is scarrwy >.<"
            ),
            ImagePrompt(
                image: UIImage(named: "dog-cat")!,
                prompt: "turn the cat fur to blue",
                generatedImage: UIImage(named: "blue-cat")!, 
                catText: "what happen to this cat..."
            )
        ])
    }


    var body: some View {
        NavigationView {
            VStack {
                Text("Curious Cat")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 16)
                    .frame(maxWidth: .infinity, alignment: .center) 
                
                HStack(alignment: .center, spacing: 20) {
                    Image("cat")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    
                    Text(catText)
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .padding(.vertical, 8) 
                
                ZStack {
                    contentBody
                    floatingButton
                }
                .sheet(isPresented: $showingForm) {
                    GenerateForm(generatedImagePrompts: $generatedImagePrompts, updateCatText: { newCatText in
                        self.catText = cat.meow()
                    })
                }
                
            }
        }
    }

    private var contentBody: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(generatedImagePrompts.indices, id: \.self) { index in
                    NavigationLink(destination: DetailView(imagePrompt: generatedImagePrompts[index])) {
                        GradientBox(image: generatedImagePrompts[index].image)
                            .frame(width: 150, height: 150)
                            .shadow(radius: 5)
                            .cornerRadius(15)
                    }
                }
            }
            .padding()
        }
    }

    private var floatingButton: some View {
        VStack {
            Spacer()
            FloatingButton(action: {
                showingForm = true
            })
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

