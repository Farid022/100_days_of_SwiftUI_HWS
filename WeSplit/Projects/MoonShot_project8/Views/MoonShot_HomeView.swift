//
//  MoonShot_HomeView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 29/01/2023.
//

import SwiftUI

struct MoonShot_pro8: View {
    let astronuats: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    //And that is the power of generics: we can use the same decode() method to load any JSON from our bundle into any Swift type that conforms to Codable – we don’t need half a dozen variants of the same method.
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid: Bool = false
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    Grid_layout(missions: missions, astronuats: astronuats)
                }else {
                    List_layout(missions: missions, astronuats: astronuats)
                }
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark) //force to keep the scrollview be in dark
            .toolbar {
                Button {
                    showingGrid.toggle()
                } label: {
                    Image(systemName: showingGrid ? "square.grid.2x2" : "list.bullet")
                }

            }
        }
    }
}

struct List_layout_Previews: PreviewProvider {
    static var previews: some View {
        MoonShot_pro8()
    }
}


struct List_layout: View {
    let missions: [Mission]
    let astronuats: [String: Astronaut]
    
    var body: some View {
            List() {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronuats: astronuats, missionDate: mission.myOwnFormatedDate)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formatedLunchedDate)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain)
    }
}
struct Grid_layout: View {
    let missions: [Mission]
    let astronuats: [String: Astronaut]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronuats: astronuats, missionDate: mission.myOwnFormatedDate)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formatedLunchedDate)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                        
                    }

                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}
