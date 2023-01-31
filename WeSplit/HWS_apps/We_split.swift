//
//  We_split.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 08/11/2022.
//

import SwiftUI


//Challenge goes here.
/*
 You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.
 */
struct Challenge_day19: View {
    @State var inputUnits = 1
    @State var outputUnits = 1
    @State var inputNumber = 1
    let units = [1, 60, 3600, 86400]
    let units_inStrings = [
        1: "Seconds",
        60: "Minutes",
        3600: "Hours",
        86400: "Days"
    ]
    var convertedNumber: Int {
        let converted = inputNumber * inputUnits / outputUnits;
        return converted
    }
    @FocusState var isKeyboardPopUp: Bool
    
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Enter a number", value: $inputNumber, format: .number)                } header: {
                    Text("Number to convert")
                }
                
                Section {
                    Picker("Number", selection: $inputUnits) {
                        ForEach(units, id: \.self) {
                            if let lebel = units_inStrings[$0]{
                                Text(lebel)
                            }
                        }
                    }.pickerStyle(.segmented)
                }  header: {
                    Text("Convert from")
                }
                
                Section {
                    Picker("Number", selection: $outputUnits) {
                        ForEach(units, id: \.self) {
                            if let lebel = units_inStrings[$0] {
                                Text(lebel)
                            }
                        }
                    }.pickerStyle(.segmented)
                }  header: {
                    Text("Convert to")
                }
                
                Section {
                    Text("\(convertedNumber)")
                }
                
                
            }.navigationTitle("Challenge Day19")
        }
    }
    
}

//F to C. Temprature conversion
struct Temprature_Conversion: View {
    // Declare State variables for input and establish a default value for each.
        @State private var inputTemperature = 0.0
        @State private var inputUnits = "Fehrenheit"
        @State private var outputUnits = "C"

        // Array with the initial of the type of units we can convert to and from.
        let unitsTemperature = ["Fehrenheit","Kelvin"]

        // Declare Focus State variable to dismiss numeric keyboard
        @FocusState private var inputTemperatureFocused: Bool

        // Calculated Property with the temperature converted to the unit selected.
        var outputTemperature: Double {
            // Variable to hold the temperature in our intermediate unit Cº
            var temperatureInCelsius = 0.0

            // Converting from any unit to celsius
            if inputUnits == "Fehrenheit" { // from Fahrenheit
                temperatureInCelsius = (inputTemperature - 32) * 5/9
            } else if inputUnits == "Kelvin" { // from Kelvin
                temperatureInCelsius = inputTemperature - 273.15
            } else { // from Celsius
                temperatureInCelsius = inputTemperature
            }

            // Converting from celsius to the desired unit and returning the value.
            if outputUnits == "Fehrenheit" { // to Fahrenheit
                return temperatureInCelsius * 9/5 + 32
            } else if outputUnits == "Kelvin" { // to Kelvin
                return temperatureInCelsius + 273.15
            } else { // to Celsius
                return temperatureInCelsius
            }

        }
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Input current temprature", value: $inputTemperature, format: .number)
                } header: {
                    Text("User Input in Celsius")
                }
                
                Section {
                    Picker("Select temprature", selection: $inputUnits) {
                        ForEach(unitsTemperature, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert To")
                }
                
                Section {
                    Text("\(outputTemperature)")
                } header: {
                    Text("User Output:")
                }
                
            }
        }
    }
}
