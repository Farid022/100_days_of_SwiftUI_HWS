//
//  Project_1.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 12/11/2022.
//

import SwiftUI
import UIKit
import UIOnboarding

struct Project_1: View {
    @State var checkAmount = 0.0
    @State var nof_ofPeople = 3
    @State var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    
    //we have a computed property which calculate total tip per person
    var total_tip_perPerson: Double {
        let peopleCount = Double(nof_ofPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grantTotal = checkAmount + tipValue
        let amountPer_Person = grantTotal / peopleCount
        return amountPer_Person
    }
    
    //We need to hide the keyboard, because there is not done button in decimalType keyboard
    // @FocusState. This is exactly like a regular @State property, except it’s specifically designed to handle input focus in our UI. we have two ways to hide keyboard. 1: .focused(), toolbar
    @FocusState var amountIsFocused: Bool
    
    func checkAmount_toBool() -> Bool {
        if checkAmount == 0.0 {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    //TextField("Enter amount", text: $checkAmount) // binding accept only string
                    //TextField("Enter amount", value: $checkAmount, format: .currency(code: "USD"))
                    TextField("Enter amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused) //two way binding
                    
                    Picker("Number of people", selection: $nof_ofPeople) {
                        ForEach(1..<50) { person in
                            Text("\(person) people")
                        }
                    }
                }
                Section{
                    //Text("How many tip percentage do you wnat")
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                            //Text("dd")
                        }
                    }.pickerStyle(.segmented)
                    
                    //Text("\(tipPercentage)")
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section{
                    Text(total_tip_perPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .background(checkAmount_toBool() ? .white : .red)
                }
                
            }.navigationTitle("We Split")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}


struct Project_1_Previews: PreviewProvider {
    static var previews: some View {
        Project_1()
    }
}


