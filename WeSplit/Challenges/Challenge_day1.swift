//
//  Challenge_day1.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 12/11/2022.
//

import SwiftUI
struct Challenge_day1: View {
    @State var inputeNumber: Double = 0.0
    @State var select_from: String = "inches"
    @State var select_to: String = "cm"
    let array_select = ["inches", "cm"]
    
    var convertFrom_to: Double {
        let inche = 2.54
        let cm = 0.3937
        let inches_to_cm = inputeNumber * inche
        let cm_to_inches = inputeNumber * cm
        
        if select_from == "inches" && select_to == "cm" {
            return inches_to_cm
        } else
        if select_from == "inches" && select_to == "inches" {
            return inputeNumber
        } else
        if select_from == "cm" && select_to == "cm" {
            return inputeNumber
        } else {
            return cm_to_inches
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter input", value: $inputeNumber, format: .number)
                }
                
                Section {
                    Picker("", selection: $select_from) {
                        ForEach(array_select, id: \.self) { item in
                            Text(item)
                        }
                    }
                }.pickerStyle(.segmented)
                
                Section {
                    Picker("", selection: $select_to) {
                        ForEach(array_select, id: \.self) {
                            Text($0)
                        }
                    }
                }.pickerStyle(.segmented)
                
                Section {
                    Text("Converted: \(convertFrom_to.formatted())")
                }
                
            }.navigationTitle("Converter")
        }
    }
}

struct Challenge_day1_Previews: PreviewProvider {
    static var previews: some View {
        Challenge_day1()
    }
}
