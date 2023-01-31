//
//  MissionView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 26/11/2022.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronuat: Astronaut
    }
    let mission: Mission
    let crew: [CrewMember]
    let missionDate: String
    
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
    //We’ll use GeometryReader to set the maximum width of the mission image, 
                        .frame(maxWidth: geo.size.width * 0.6)
                        .padding(.top)

                    VStack(alignment: .leading) {
                        Text("\(missionDate)")
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                    }
                    .padding(.horizontal)
                    
                    
                }
                .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                                AstronuatsView(astronuat: crewMember.astronuat)
                            } label: {
                                Image(crewMember.astronuat.id)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 104, height: 72)
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    )
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronuat.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    
                    
                }
                
                VStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding(.vertical)
                    Text("Image of \(mission.displayName)")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }.padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 104, height: 74)
                            .clipped()
                            .overlay(
                                Circle()
                                    .strokeBorder(.white, lineWidth: 1)
                            )
                        Text("\(mission.displayName) Image")
                    }
                }
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronuats: [String: Astronaut], missionDate: String) {
        self.missionDate = missionDate
        self.mission =  mission
        self.crew = mission.crew.map { member in //loop through the names in mission.crew
            print(member)
            if let astronuat = astronuats[member.name] {
                return CrewMember(role: member.role, astronuat: astronuat)
            } else {
                fatalError("Missing \(member.name) in the dictionary")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronuats: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronuats: astronuats, missionDate: "Date()")
            .preferredColorScheme(.dark)
    }
}
