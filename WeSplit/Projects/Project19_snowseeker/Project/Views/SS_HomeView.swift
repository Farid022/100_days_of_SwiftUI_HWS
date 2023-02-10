//
//  SS_HomeView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 01/02/2023.
//

import SwiftUI
//if we want to stop the iphone primery and secondary concept, we can strop for iphones only.
extension View {
//We need to use the @ViewBuilder attribute here because the two returned view types are different. That uses Apple’s UIDevice class to detect whether we are currently running on a phone or a tablet, and if it’s a phone enables the simpler StackNavigationViewStyle approach.
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct SS_HomeView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favourites = Favorites()
    @State private var searchText = ""
    
    @State private var isConfirmationDialogShowing = false
    @State private var isSortByName = false
    @State private var isSortByCountry = false
    var body: some View {
        NavigationView {
            //It is the primery view.
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay (
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                        
                        if favourites.contains(resort: resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favourite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for resort...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isConfirmationDialogShowing = true
                    } label: {
                        Image(systemName: "list.bullet.circle")//list.bullet.circle
                    }
                }
            }
            .confirmationDialog("", isPresented: $isConfirmationDialogShowing) {
                Button {
                    isSortByName = true
                    //allTypes = .sortbyName
                } label: {
                    Text("Sort by name")
                }
                
                Button {
                    isSortByCountry = true
                    //allTypes = .sortbyCountry
                } label: {
                    Text("Sort by contry code")
                }
            }
            .onAppear {
                allTypes = .none
            }
            
            
            //to avoid the blank screen while you are on landscap mode on larger iphones, then this secondary view will be shown. otherwise not shown at all. because it is secondary view
            WelcomeView()
        }
        //.phoneOnlyStackNavigationView()
        .environmentObject(favourites)
    }
    
   @State var allTypes: AllTypes
    var filteredResorts: [Resort] {
        if searchText.isEmpty && !isSortByName && !isSortByCountry {
            return resorts
        } else if isSortByCountry && searchText.isEmpty  {
            return resorts.sorted { $0.country < $1.country }
        } else if isSortByName && searchText.isEmpty {
            return resorts.sorted { $0.name < $1.name }
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    //using enum.
    var filteredResorts2: [Resort] {
        switch allTypes {
        case .none:
            return resorts
        case .sortbyName:
            return resorts.sorted { $0.name < $1.name }
        case .sortbyCountry:
            return resorts.sorted { $0.country < $1.country }
        case .searching:
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
}

enum AllTypes {
    case none, sortbyName, sortbyCountry, searching
}

//struct SS_HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SS_HomeView()
//    }
//}
