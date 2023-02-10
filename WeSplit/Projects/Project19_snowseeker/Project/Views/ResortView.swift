//
//  ResortView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 01/02/2023.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    //This looks great when we have enough space, but when space is limited it would be helpful to switch to a 2x2 grid layout.
    @Environment(\.horizontalSizeClass) var sizeClass//it tells us how much space is available, regular or compact.
    @Environment(\.dynamicTypeSize) var dynamicSize//
    
    //MARK: OPTIONAL ALERT.
    @State private var selectedFacility: Facility?
    @State private var isShowingFacility = false
    
    @EnvironmentObject var favourites: Favorites
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                // If we have a regular amount of space, we’re going to keep the current HStack approach so that everything its neatly on one line, but if space is restricted we’ll ditch that and place each of the views into a VStack.
                HStack {
                    //two rows of vertical stacks in a compact size class when an increased font size is used.
                    if sizeClass == .compact && dynamicSize > .large {
                        VStack(spacing: 10) {
                            ResortDetailsView(resort: resort)
                        }
                        VStack(spacing: 10) {
                            SkiDetailsView(resort: resort)
                        }
                    } else {
                        //one single line of text in a regular size class.
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)//any size up to and including .xxxLarge is fine, but nothing larger.
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    //MARK: How to get a single string from a [string].
                    //The only interesting part is that we’re going to show the resort’s facilities as a single text view using resort.facilities.joined(separator: ", ") to get a single string.
//                    Text(resort.facilities.joined(separator: ", "))
//                        .padding(.vertical)
                    
                    //Notice how the .and type is there? That’s because you can also use .or to get “A, B, or C” if that’s what you want.
//                    Text(resort.facilities, format: .list(type: .and))
//                        .padding(.vertical)
                    
                    HStack {
                        ForEach(resort.facilityType) { facility in
                            Button {
                                selectedFacility = facility
                                isShowingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    //.padding(.vertical)
                    
                    //favourit button
                    Button(favourites.contains(resort: resort) ? "Remove from Favourites" : "Add to Favourites") {
                        if favourites.contains(resort: resort) {
                            favourites.remove(resort: resort)
                        } else {
                            favourites.add(resort: resort)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                }.padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More Information", isPresented: $isShowingFacility, presenting: selectedFacility) { _ in
            //noting but a defualt okay button
        } message: { facility in
            Text(facility.decription)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
        }
        .environmentObject(Favorites())
    }
}
