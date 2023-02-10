//
//  CupcakeCorner.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 04/12/2022.
//

import Foundation
import SwiftUI

struct CupCakeCornerView_pro10: View {
    @StateObject var order = Order()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) { order in
                            Text("\(Order.types[order])")
                        }
                    }
                }
                
                Section {
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any Special request?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting.animation())
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles.animation())

                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }

                }
            }.navigationTitle("CupCake Corner")
        }
    }
}

struct CupCakeCornerView_pro10_Previews: PreviewProvider {
    static var previews: some View {
        CupCakeCornerView_pro10()
    }
}
