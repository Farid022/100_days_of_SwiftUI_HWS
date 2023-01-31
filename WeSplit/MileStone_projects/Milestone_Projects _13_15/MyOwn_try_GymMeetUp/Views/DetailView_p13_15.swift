//
//  DetailView_p13_15.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 17/01/2023.
//

import SwiftUI
import MapKit

struct DetailView_p13_15: View {
    @State var image: Image?
    let gymer: Gymer
    @ObservedObject var gymer_vm = Gymer_VM()
    
    var body: some View {
        VStack {
            ZStack {
                image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 600, height: 400)
                    .padding()
                
                Text(gymer.name)
                    .font(.title2)
                    .foregroundColor(.purple)
            }
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        image = gymer.convertUIimage_to_Image()
    }
}

//struct DetailView_p13_15_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView_p13_15()
//    }
//}
