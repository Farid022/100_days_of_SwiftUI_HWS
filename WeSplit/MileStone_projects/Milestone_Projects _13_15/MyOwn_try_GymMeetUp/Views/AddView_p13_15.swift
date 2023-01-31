//
//  AddView_p13_15.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 17/01/2023.
//

import SwiftUI

struct AddView_p13_15: View {
    @ObservedObject var gymer_vm: Gymer_VM
    @Environment(\.dismiss) var dismiss
    
    @State private var image: Image?
    @State private var inputUIImage: UIImage?
    @State private var savedUIImage: UIImage?
    @State private var showingImagePicker = false
    @State private var gymerName = ""
    let locationFetcher = LocationFetcher2()
    
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter picture name", text: $gymerName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                        .frame(width: 300, height: 300)
                    
                    Text("Tap to add picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
                .onTapGesture {
                    showingImagePicker = true
                }
            }
            .onChange(of: inputUIImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputUIImage)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        guard let location = locationFetcher.lastKnownLocation else { return }
                        gymer_vm.addNew_Gymer(name: gymerName, inputUIimage: savedUIImage, latitude: location.latitude, longitude: location.longitude)
                        gymer_vm.updateView()
                        dismiss()
                    }
                    .disabled(inputUIImage == nil)
                    .disabled(gymerName == "")
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
            }
            .onAppear { locationFetcher.start() }
        }
    }
    
    func loadImage() {
            guard let inputUIImage = inputUIImage else { return }
            image = Image(uiImage: inputUIImage)
            savedUIImage = inputUIImage
        }
    
    init(gymer_vm: Gymer_VM) {
        self.gymer_vm = gymer_vm
    }
}

//struct AddView_p13_15_Previews: PreviewProvider {
//    static var previews: some View {
//        AddView_p13_15()
//    }
//}
