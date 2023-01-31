//
//  Project_4.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 12/11/2022.
//
//Better Rest project: Topics:  DatePicker, Stepper, Date, DateComponents, core ML = Machine learning
import SwiftUI
import CoreML
struct Project_4_practice: View {
    @State var sleepAmount = 8.0
    @State var current_date = Date.now
    func setAlarm() {
        //set for one day
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
    }
    //DateComponent - It let us to read and write specific part of the date rather then the whole. i.e: access 8am.
    func specific_time() {
        var components = DateComponents()//it stores all the parts required to represent a date as individual values, meaning that we can read the hour and minute components and ignore the rest.
        
        components.hour = 8
        components.minute = 0
        let specific_date = Calendar.current.date(from: components)
        
        let newComponent = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hourr = newComponent.hour ?? 0
        let mins = newComponent.minute ?? 0
    }
    
    var body: some View {
        VStack {
            Stepper("Title: \(sleepAmount.formatted())", value: $sleepAmount, in: 1...10, step: 0.25)
            
            DatePicker("Selecet the date",
                       selection: $current_date,
                       in: Date.now...
                       ,displayedComponents: .date) //.date, hourAndMinute,
                //.labelsHidden()//to hide the title of the picker
            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
            
        }.padding()
    }
}


struct Project_4_BetterRest: View {
    @State private var wakeUp = defualt_wakeUp_Time
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defualt_wakeUp_Time: Date {
        //The fix here is simple: we can make defaultWakeTime a static variable, which means it belongs to the ContentView struct itself rather than a single instance of that struct. This in turn means defaultWakeTime can be read whenever we want, because it doesn’t rely on the existence of any other properties.
        var component = DateComponents()
        component.hour = 5
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Select the time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep?")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake?")
                        .font(.headline)
                    Stepper(coffeeAmount == 1 ? "1 cup": "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Okay") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let component = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (component.hour ?? 0) * 60 * 60
            let minute = (component.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedTime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem while calulating your bed time"
        }
        
        showAlert = true
    }
}


struct Project_4_practicePreviews: PreviewProvider {
    static var previews: some View {
        Project_4_BetterRest_chalenge()
    }
}


struct Project_4_BetterRest_chalenge: View {
    @State private var wakeUp = defualt_wakeUp_Time
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defualt_wakeUp_Time: Date {
        var component = DateComponents()
        component.hour = 5
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Hello") {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Select the time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section {
                    Text("Desired amount of sleep?")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake?")
                        .font(.headline)
                    Picker("\(coffeeAmount == 1 ? "1 cup": "\(coffeeAmount)")", selection: $coffeeAmount) {
                        ForEach(0..<10) { item in
                            if item != 0 {
                                Text("\(item)")
                            }
                        }
                    }//.pickerStyle(.segmented)
                }
                
                Section {
                    Button {
                        calculateBedTime()
                    } label: {
                        HStack{
                            Spacer()
                            Text("Calculate bedTime")
                            Spacer()
                        }
                    }
                }

            }
            .navigationTitle("Better Rest")
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Okay") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let component = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (component.hour ?? 0) * 60 * 60
            let minute = (component.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedTime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem while calulating your bed time"
        }
        
        showAlert = true
    }
}
