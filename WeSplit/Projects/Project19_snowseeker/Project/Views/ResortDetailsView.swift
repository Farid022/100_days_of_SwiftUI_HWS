//
//  ResortDetailsView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 01/02/2023.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    //The size of a resort is stored as a value from 1 to 3, but really we want to use “Small”, “Average”, and “Large” instead.
    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        case 3:
            return "Large"
        default:
            return ""
        }
    }
    
    //The price is stored as a value from 1 to 3, but we’re going to replace that with $, $$, or $$$.
    var price: String {
        String(repeating: "$", count: resort.price)//creates a new string by repeating a substring a certain number of times.
    }
    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
                
            }
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
        //it does get passed down to its child views, which means they will automatically spread out horizontally.
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
