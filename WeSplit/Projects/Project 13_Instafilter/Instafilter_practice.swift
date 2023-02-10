//
//  Instafilter_practice.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 05/01/2023.
//

import SwiftUI

struct Instafilter_practice: View {
    //So here if we slide, No printing, and only it prints when we tab the button. assigning property observers used with property wrappers often won’t work
//    @State private var blurAmount = 0.0 {
//        didSet {
//            print("The New value is: \(blurAmount)")
//        }
//    }
    @State private var blurAmount = 0.0
    
    //confirmation dialog
    @State private var showingConfirmation = false
    @State private var background = Color.purple
    
    //UIViewController for Image picker
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showImagePicker = false
    
    var body: some View {
        VStack {
            //1.onChange example.
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .blur(radius: blurAmount)
                
                Slider(value: $blurAmount, in: 1...20)
                    .onChange(of: blurAmount) { newValue in
                        print("The new value is: \(blurAmount)")
                    }//
                
                Button("Tap me") {
                    blurAmount = Double.random(in: 1...20)
                }
            }// we can also put the onChange here.
            
            //2.Confirmation dialog.
            VStack {
                Text("Change Color")
                    .frame(width: 100, height: 100)
                    .background(background)
                    .onTapGesture {
                        showingConfirmation = true
                    }
            }.confirmationDialog("The title", isPresented: $showingConfirmation) {
                Button("Red") { background = .red }
                Button("Blue") { background = .blue }
                Button("Yellow") { background = .yellow }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Select Carefully")
            }
            
            //3.Integrating Core Image with SwiftUI. Watch when required.
            
            //4.UIViewController for ImagePicking
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
                
                Button("Pick Image from Library") {
                    showImagePicker = true
                }
                Button("Save Photo") {
                    guard let inputImage = inputImage else { return }
                    let imageSaver = ImageSaver()
                    imageSaver.writeToPhoto_Album(image: inputImage)
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { image in
            loadImage()
        }
    }
    
    func loadImage() { //checks whether inputImage has a value, and if it does uses it to assign a new Image view to the image property.
        guard let uiImage = inputImage else { return }
        image = Image(uiImage: uiImage)
    }
}

struct Instafilter_practice_Previews: PreviewProvider {
    static var previews: some View {
        Instafilter_practice()
    }
}
