//
//  MoonShot_pro8.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 24/11/2022.
//

import SwiftUI
/*
 Topics: 1: GeometryReader: it lets us read the size of a view's container.
 2: Generics let us write code that can use a variety of different types.
 They add a lot of flexibility, but usually it's best to write a method for a single type first.
 ,ScrollView, NavigationLink, Images, complex JSON-array inside array
 */

struct CustomText: View {
    let text: String
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Custom text created!")
        self.text = text
    }
}
//two struct for two arrays - If you want to decode this kind of hierarchical data, the key is to create separate types for each level you have.
//what the JSON contains. These two.
struct UserInfo: Codable {
    let name: String
    let address: Address
}
struct Address: Codable {
    let street: String
    let city: String
}
struct Practice_pro8: View {
    @State var newJsonText = "Nothing converted yet"
    //if we want to have three columns 80 points wide then do this
    let layout = [
//        GridItem(.fixed(150)),
//        GridItem(.fixed(150)),
//        GridItem(.fixed(150))
        
        //the best part of grids is their ability to work across a variety of screen sizes. This can be done with a different column layout using adaptive sizes, like this:
        GridItem(.adaptive(minimum: 120, maximum: 150))
    ]
    var body: some View {
        NavigationView {
            VStack {
//                GeometryReader { geo in //the geoObj let us query the environment, how big is the container, what is our view position.
//                    Image("arnold")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: geo.size.width * 0.8, height: 300)
//                        .frame(width: geo.size.width * 1.0, height: geo.size.height) //to center
//                        //.clipped()
//                }
                
//                ScrollView(.vertical) {
//                    LazyVStack(spacing: 10) {
//                        ForEach(1..<4, id: \.self) { item in
//                            NavigationLink {
//                                Text("New View: \(item)")
//                            } label: {
//                                CustomText("Item: \(item)")
//                            }
//
//                        }
//                    }.frame(maxWidth: .infinity)
//                }
                
//                NavigationLink {
//                    Text("Here is the detail view")
//                } label: {
//                    Text("Go from here")
//                }
                
//                Button("Decode Complex JSON") {
//                    let jsonText = """
//{
//      "name": "Farid",
//      "address" : {
//       "street": "Amandi gul badan sha",
//       "city": "Bannu"
//    }
//}
//"""
//
////Now for the best part: we can convert our JSON string to the Data type (which is what Codable works with), then decode that into a User instance:
//                    let data = Data(jsonText.utf8)
//                    let decoder = JSONDecoder()
//                    if let user = try? decoder.decode(UserInfo.self, from: data) {
//                        newJsonText = user.address.street
//                        print(user.address.street)
//                    }
//                }
//                Text(newJsonText)
                
                
                //LazyVgrid
                ScrollView(.horizontal ) {
                    LazyHGrid(rows: layout) {
                        ForEach(0..<100) {
                            Text("Item: \($0)")
                                .padding()
                        }
                    }
                }
                
                
            }
        }
    }
}
