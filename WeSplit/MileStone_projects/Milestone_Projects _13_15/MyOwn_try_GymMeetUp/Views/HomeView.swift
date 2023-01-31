//
//  HomeView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 17/01/2023.
//

import SwiftUI
import UIKit
//Challenge is:
/*
 Breaking it down, you should:

 1. Wrap PHPickerViewController so it can be used to select photos.
 2. Detect when a new photo is imported, and immediately ask the user to name the photo.
 3. Save that name and photo somewhere safe.
 4. Show all names and photos in a list, sorted by name.
 5. Create a detail screen that shows a picture full size.
 6. Decide on a way to save all this data.
 */

struct HomeView: View {
    @StateObject var gymer_vm = Gymer_VM()
    
    @State var refresh: Bool = false
    @State private var showingAddView = false
    let loc_fetcher = LocationFetcher2()
    @State private var imageLocationLatidude: Double = 0.0
    @State var imageLocationLongitude: Double = 0.0
    
    func find() {
        if let location = loc_fetcher.lastKnownLocation {
            imageLocationLatidude = location.latitude
            imageLocationLatidude = location.longitude
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gymer_vm.meetup) { meetup in
                    NavigationLink {
                        DetailView_p13_15(gymer: meetup)
                    } label: {
                        Gymer_RowView(gymer: meetup)
                    }

                }
                .onDelete(perform: gymer_vm.deleteRow)
            }
            .navigationTitle("MeetUp")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingAddView = true
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.black.opacity(0.8))
                            
                            Image(systemName: "plus")
                                .padding()
                                .bold()
                                .foregroundColor(.white)
                                .font(.title)
                        }
                    }

                }
            }
            .sheet(isPresented: $showingAddView) {
                AddView_p13_15(gymer_vm: gymer_vm)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
