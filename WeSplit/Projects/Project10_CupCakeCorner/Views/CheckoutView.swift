//
//  CheckoutView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 07/12/2022.
//

import Foundation
import SwiftUI
struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                //.frame(height: 233)
                
                Text("Your total is: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task { //Task { … }. This is the best way to run an asynchronous function from a synchronous one, such as a button action.
                        await order.placeOrder()
                    }
                }
                .buttonStyle(.bordered)
                //.background(.thinMaterial)
                
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(order.confirmationTitle, isPresented: $order.showingConfirmation) {
            Button("Ok") {}
        } message: {
            Text(order.confirmationMessage)
        }
    }
}
