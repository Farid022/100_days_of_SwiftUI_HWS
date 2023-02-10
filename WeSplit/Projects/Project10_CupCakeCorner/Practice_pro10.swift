//
//  Practice_pro10.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 07/12/2022.
//

import Foundation
import SwiftUI
//CodingKeys usage
class User222: ObservableObject, Codable {
    @Published var name: String = "Farid Khan"
    
    enum CodingKeys: CodingKey { //a type that can be used as a key for encoding and decoding
    case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}


/* Fetch data using URLSession
 Result store id, name and collection. Response store an array of results
 */
struct Response: Codable {
    var results: [Result]
}
struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
class FetchedResults: ObservableObject {
    @Published var results = [Result]()
    //1. Creating the URL we want to read.
    //2. Fetching the data for that URL.
    //3. Decoding the result of that data into a Response struct and store in the result array.
    func loadData() async { //It sleep for a while for the data to be fetched.
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        
        do {
            //where our sleep is likely to happen. Whereever sleep is possible, we use await.
            //Important 3 tasks happens here
            /*
             1. data(from:) method takes a URL and returns the Data object at that URL. This method belongs to URLSession and have an instance shared.
             2. The return value from data(from:) is a tuple containing the data at the URL and some metadata describing how the request went. underscore(_) means we ignore the metadata, and only we want the URL's data.
             3. Use both in such sitiuation -> try await
             4. Decoding the result of that data into a Response struct and store in the result array.
             */
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodeData = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodeData.results
            }
            
        } catch {
            print("Invalid Data")
        }
    }
}

//Topics: URLSession, AsyncImage, disabled
struct Project_10_practce: View {
    //1
    @StateObject var res = FetchedResults()
    
    //2
    @State private var userEmail = ""
    @State private var userPass = ""
    
    //3
    var disable_Form: Bool {
        return userEmail.count < 4 || userPass.count < 4
    }
    var body: some View {
        VStack {
            //fetch data using URLSession
            VStack {
                Text("Nothing yet")
                List {
                    ForEach(res.results, id: \.trackId) { item in
                        Text(item.trackName)
                    }
                }
            }
            .task {
                await res.loadData()
            }
            
            
            
            
            //AsyncImage(url: URL(string: ""), scale: 3)
    //        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
    //            image
    //                .resizable()
    //                .scaledToFit()
    //        } placeholder: {
    //            //ProgressView()
    //            Color.red
    //        }
    //        .frame(width: 300, height: 300)
    //        .cornerRadius(20)
            
            //Now show all three possible
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                if let image = image.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if image.error != nil {
                    Text("There was an error occured!")
                } else {
                    ProgressView()
                }
            }.frame(width: 300, height: 300)
            
            
            Form {
                Section {
                    TextField("User Email", text: $userEmail)
                    TextField("User Password", text: $userPass)
                }
                
                Button("Create account!") {
                    print("Creating account")
                }.disabled(disable_Form)
            }
        }
    }
}
