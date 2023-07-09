//
//  ContentView.swift
//  Magus
//
//  Created by Peng Zhang on 4/27/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model1 = FirstMagicModel()
    @State var text = ""
    @State var image: UIImage?
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView{
            //Spacer()
            VStack{
                Spacer()
                if let image = image{
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                }
                else{
                    Text("Type something, Magus will surprise you!")
                }
                Spacer()
                TextField("Type here...", text: $text)
                    .padding()
                Button("Magus!"){
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty{
                        Task{
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil, from: nil, for: nil)
                            isTextFieldFocused = false
                            let result = await model1.generateImage(prompt: text)
                            if(result == nil){
                                print("Fail to generate.")
                            }
                            self.image = result
                        }
                    }
                }
            }
            .navigationTitle("Welcome to Magus!")
            .onAppear{
                model1.setup()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
