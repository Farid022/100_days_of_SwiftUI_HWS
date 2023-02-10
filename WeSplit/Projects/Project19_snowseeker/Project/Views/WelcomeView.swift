//
//  WelcomeView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 01/02/2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to the SnowSeeker!")
                .font(.title)
            
            Text("Please select a resort from the left-hand menu, swipe from the left edge to show it")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
