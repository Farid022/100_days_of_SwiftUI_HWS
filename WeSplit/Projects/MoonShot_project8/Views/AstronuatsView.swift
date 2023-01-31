//
//  AstronuatsView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 26/11/2022.
//

import SwiftUI

struct AstronuatsView: View {
    let astronuat: Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronuat.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronuat.description)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronuat.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronuatsView_Previews: PreviewProvider {
    static let astronuat: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronuatsView(astronuat: astronuat["armstrong"]!)
    }
}
