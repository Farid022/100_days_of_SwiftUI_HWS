//
//  TryView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 03/02/2023.
//

import SwiftUI

struct TryView: View {
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("Some text")
                    .foregroundColor(.white)
                    .animation(nil)
            }.buttonStyle(.borderedProminent)
                //.disabled(true)
                .scaleEffect(4)
            
            
        }.foregroundColor(.green)
    }
    
    
}

struct TryView_Previews: PreviewProvider {
    static var previews: some View {
        TryView()
    }
}
