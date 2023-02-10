//
//  BucketList_project.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 13/01/2023.
//

import SwiftUI
import MapKit


struct BucketList_project: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            Text(location.name)
                                .fixedSize() //text is ver....
                        }.onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.green)
                    .opacity(0.4)
                    .frame(width: 50, height: 50)
                
                VStack {
                    Spacer()
                    HStack {
                        
                        Spacer()
                        Button {
                            //we want to add a location to the array, whenever the + button is tapped.
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()//make sure the button is bigger before we add a background color.
                                .background(.green.opacity(0.4))
                                .foregroundColor(.black)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                //So, that passes the location into EditView, and also passes in a closure to run when the Save button is pressed. That accepts the new location, then looks up where the current location is and replaces it in the array. This will cause our map to update immediately with the new data.
                EditView(location: place) { newLocation in
                    viewModel.updateLocation(newlocation: newLocation)
                }
                //So the onSave gives us the single location to work with.
                //EditView(location: place, onSave: <#T##(Location2) -> Void#>)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("\(viewModel.title)"),
                      primaryButton: .cancel(),
                      secondaryButton: .default(Text("Okay"))
                )
            }
        } else {
            Button("UnLock The Map") {
                viewModel.authenticate()
            }
            .padding()
            .background(.black)
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Capsule())
        }
    }
}

struct BucketList_project_Previews: PreviewProvider {
    static var previews: some View {
        BucketList_project()
    }
}
