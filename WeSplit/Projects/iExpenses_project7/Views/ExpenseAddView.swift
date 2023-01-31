//
//  ExpenseAddView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 22/11/2022.
//

import SwiftUI

struct ExpenseAddView: View {
//We don’t want to create a second instance of the Expenses class in AddView, but instead want it to share the existing instance from ContentView.
    @ObservedObject var expenses: Expenses
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    let types = ["Personal", "Business"]
    @Environment(\.dismiss) var dismiso
    
    //Challenges:
    @State var countryCode = "USD"
    let countryCodes = ["USD", "Euro", "GB", "MR", "PKR"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                HStack {
                    TextField("Amount", value: $amount, format: .currency(code: "\(countryCode)"))
                        .keyboardType(.decimalPad)
                    
                    Picker("", selection: $countryCode) {
                        ForEach(countryCodes, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("Add Expense")
            .toolbar {
                Button {
                    let expense = ExpenseItem(name: name, type: type, amount: amount, countryCode: countryCode)
                    expenses.items.append(expense)
                    dismiso()
                } label: {
                    Text("Save")
                }

            }
        }
    }
}

struct ExpenseAddView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseAddView(expenses: Expenses())
    }
}
