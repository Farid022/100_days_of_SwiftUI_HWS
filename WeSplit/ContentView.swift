//
//  ContentView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 07/11/2022.
//

import SwiftUI

struct ContentView: View { //we created a struc with the name of ContentView which confrims to View prototcol
    @State var clickMe: String = "Jemmy View"
    @State var bindinggg_text = ""
    
    
    let students: [String] = ["Jemmy", "Khan", "ALi", "Liza", "Liza"]
    @State var isSelected: String = "Liza"
    
    var body: some View {
        //inside the struct there is one computed property called body. This means it will return something that conforms to the View protocol, which is our layout
   
        
        NavigationView {
            Form {
                Group{ //If you wanted to have 11 things inside the form you should put some rows inside a Group. Groups don’t actually change the way your user interface looks, they just let us work around SwiftUI’s limitation of ten child views inside a parent – that’s text views inside a form, in this instance.
                    Text("Hello")
                    
                    Button {
                        //clickMe = "New String" //not possible as we know that inside struct, if i want to change a property inside func then i will add mutataing keyword but here we use @State to change property inside...
                        clickMe = "New View"
                    } label: {
                        Text("Click Me")
                    }

                    TextField("Enter something", text: $bindinggg_text)
                    //So, when you see a dollar sign before a property name, remember that it creates a two-way binding: the value of the property is read, but also written.
                    
                    Text("Your Name is: \(bindinggg_text)")
                    //Notice how that uses name rather than $name? That’s because we don’t want a two-way binding here – we want to read the value, yes, but we don’t want to write it back somehow, because that text view won’t change.
                    
                }
                
                
                
                Section {
                    Text("Here is a new section")
                }
                
                ForEach(0..<10) { num in  //{} it is closure, what you want to perform with. we can also use $0 instead of the num
                    Text("Number: \(num)")
                }
                
                Section{
                    Picker("Select a Student", selection: $isSelected) {
                        ForEach(students, id: \.self) { std in //id: \.self= assign a unique id, the string by itself are unque ids. issue occurs when we get same string in an array, then the ids beocmes dublicated.
                            Text(std)
                        }
                    }
                }
            }
            .navigationTitle(clickMe)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider { //Below the ContentView struct you’ll see a ContentView_Previews struct, which conforms to the PreviewProvider protocol.
    static var previews: some View {
        ContentView()
    }
}
