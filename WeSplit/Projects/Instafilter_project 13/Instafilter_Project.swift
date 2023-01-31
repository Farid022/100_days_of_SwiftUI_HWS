//
//  Instafilter_Project.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 06/01/2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct Instafilter_Project: View {
    @State private var image: Image?
    @State private var filterIntesity = 0.5
    @State private var showBottomSheet: Bool = false
    //we need a property that will store the image the user selected. We gave the ImagePicker struct an @Binding property attached to a UIImage, which means when we create the image picker we need to pass in a UIImage for it to link to. When the @Binding property changes, the external value changes as well, which lets us read the value.
    @State private var inputImage: UIImage?
    @State private var showingFilterSheet: Bool = false
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    
    let context = CIContext()
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to add a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }.onTapGesture {
                    showBottomSheet = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntesity)
                        .onChange(of: filterIntesity) { _ in
                            applyProcessing()
                        }
                }.padding(.vertical)
                
                HStack {
                    Button("Change Filter") { showingFilterSheet = true }
                    Spacer()
                    Button("Save", action: save)
                        .disabled((image == nil) ? true : false)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in
                //_ in ignore the input, just loadImage()
                loadImage()
            }
            .sheet(isPresented: $showBottomSheet) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("ddd", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func loadImage() {
        //convert UIimage to Image-> to use resizable and other modifiers.
        guard let inputImage = inputImage else { return }
        //image = Image(uiImage: inputImage)
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)") 
        }
        
        
        imageSaver.writeToPhoto_Album(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntesity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntesity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntesity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct Instafilter_Project_Previews: PreviewProvider {
    static var previews: some View {
        Instafilter_Project()
    }
}
