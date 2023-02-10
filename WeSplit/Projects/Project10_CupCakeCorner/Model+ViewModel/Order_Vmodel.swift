//
//  Order_Vmodel.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 07/12/2022.
//

import Foundation
class Order: ObservableObject, Codable {
    //1. Swift doesn’t understand how to encode and decode published properties.
    //2. Our problem is, that we want to submit the user’s order to an internet server, which means we need it as JSON – we need the Codable protocol to work.
    //3. Telling Swift what should be encoded, how it should be encoded, and also how it should be decoded – converted back from JSON to Swift data.
    //4. So we use enum that conforms to CodingKey, listing all the properties we want to save.
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }//The CodingKey protocol lets us list the properties we want to archive and unarchive as enum cases.
    //5. writes out all the properties attached to their respective key using encode method.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
            try container.encode(quantity, forKey: .quantity)

            try container.encode(extraFrosting, forKey: .extraFrosting)
            try container.encode(addSprinkles, forKey: .addSprinkles)

            try container.encode(name, forKey: .name)
            try container.encode(streetAddress, forKey: .streetAddress)
            try container.encode(city, forKey: .city)
            try container.encode(zip, forKey: .zip)
    }
    //6. required initializer to decode an instance of Order from some archived data.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

            type = try container.decode(Int.self, forKey: .type)
            quantity = try container.decode(Int.self, forKey: .quantity)

            extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
            addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

            name = try container.decode(String.self, forKey: .name)
            streetAddress = try container.decode(String.self, forKey: .streetAddress)
            city = try container.decode(String.self, forKey: .city)
            zip = try container.decode(String.self, forKey: .zip)
    }
    
    init() {}

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 2
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    var hasValidAdress: Bool {
        let regExp_patern = "\\s"
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || streetAddress.hasPrefix(" ") || streetAddress.hasSuffix(" ") {
            return false
        }
        
    
        
//        if let range = streetAddress.range(of: regExp_patern, options: .regularExpression) {
//            print("The address contains whitespaces")
//            return false
//        }
        
        return true
        
    }
    
    @Published var confirmationMessage = ""
    @Published var showingConfirmation = false
    @Published var confirmationTitle = ""
    
    //The logic goes here
    /*
     There’s a base cost of $2 per cupcake.
     We’ll add a little to the cost for more complicated cakes.
     Extra frosting will cost $1 per cake.
     Adding sprinkles will be another 50 cents per cake.
     */
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
    func placeOrder() async {
        //Inside placeOrder() we need to do three things:
        /*
         1. Convert our current order object into some JSON data that can be sent.
         2. Tell Swift how to send that data over a network call.
         3. Run that request and process the response.
         */
        
        //1.
        guard let encoded = try? JSONEncoder().encode(Order()) else {
            print("Failed to encode order!")
            return
        }
        
        //2.
        /*
         The second step means using a new type called URLRequest, which is like a URL except it gives us options to add extra information such as the type of request, user data, and more.

         We need to attach the data in a very specific way so that the server can process it correctly, which means we need to provide two extra pieces of data beyond just our order:

         The HTTP method of a request determines how data should be sent. There are several HTTP methods, but in practice only GET (“I want to read data”) and POST (“I want to write data”) are used much. We want to write data here, so we’ll be using POST.
         The content type of a request determines what kind of data is being sent, which affects the way the server treats our data. This is specified in what’s called a MIME type, which was originally made for sending attachments in emails, and it has several thousand highly specific options.
         
         //Note: Where to send.
         //Of course, the real question is where to send our request, and I don’t think you really want to set up your own web server in order to follow this tutorial. So, instead we’re going to use a really helpful website called https://reqres.in – it lets us send any data we want, and will automatically send it back. This is a great way of prototyping network code, because you’ll get real data back from whatever you send.
         */
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url) // URLRequest just describes how data should be fetched.
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST" // i want to write the post info, the info has type of aplication/json-to my application, HTTP GET calls are designed to read data, and POST calls are designed to write data.
        
        
        //3.
        do {
            //When a URLSession download completes, it will send back the downloaded data plus any additional metadata. These values are passed back in a tuple, and you can use _ to ignore either of them.
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decoded = try? JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank You!"
            confirmationMessage = "Your order for \(quantity)x \(Order.types[type].lowercased()) cupcakes are on the way!"
            
            DispatchQueue.main.async {
                self.showingConfirmation = true
            }
            
        } catch {
            showingConfirmation = true
            print("Checkout failed.")
            confirmationTitle = "Sorry! Order Failed "
            confirmationMessage = "Make sure you are connected to internet!"
        }
        
    }
}
