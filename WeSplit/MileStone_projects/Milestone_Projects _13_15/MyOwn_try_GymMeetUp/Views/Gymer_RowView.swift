//
//  SwiftUIView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 17/01/2023.
//

import SwiftUI

struct Gymer_RowView: View {
    let gymer: Gymer
    @State var image: Image?
    
    var body: some View {
        HStack {
            image?
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .shadow(radius: 2)
            
            Text(gymer.name)
                .font(.title2)
            Spacer()
            
        }.onAppear(perform: loadImage)
    }
    
    func loadImage() {
        image = gymer.convertUIimage_to_Image()
    }
}

struct Gymer_RowView_Previews: PreviewProvider {
    static var previews: some View {
        Gymer_RowView(gymer: Gymer.example)
            .previewLayout(.sizeThatFits)
                        .padding()
    }
}
