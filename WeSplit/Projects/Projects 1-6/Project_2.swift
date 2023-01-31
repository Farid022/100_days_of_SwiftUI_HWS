//
//  Project_2.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 12/11/2022.
//

import SwiftUI
/*
 points:
 1: use two spacer() below to have 1/3 widget on screen and one above
 2: shift+command A = light or dark mode.
 */

//Guess the flag project
struct Project_2: View {
    @State private var countries = ["Estonia","France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var score: Int = 0
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var showingScrore_alert = false
    @State private var scoreTitle = ""
    @State private var animate = false
    
    
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.heavy))
                        .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    
                    VStack {
                        Text("Tap the card of")
                            .font(.headline.weight(.semibold))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundStyle(.secondary)
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation(.easeInOut(duration: 2)) {
                                flagTapped(number: number)
                            }
                        } label: {
                            Image("\(countries[number])")
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .rotation3DEffect(
                                    .degrees(number == self.correctAnswer && self.animate ? 360 : 0.0),
                                    axis: (x: 0, y: 1, z: 0))
                                //.opacity(number == self.correctAnswer && self.animate ? 0.25 : 1)
                                //.animation(.default, value: showingScrore_alert)
                        }
                        

                    }
                }
                
                .frame(maxWidth: .infinity)
                .padding(.vertical, 33)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()

            }
            .padding()
            .padding(.top,50)
        }
        .alert(scoreTitle, isPresented: $showingScrore_alert) {
            Button("Continue", action: {
            })
        } message: {
            Text("Your Score is \(score)")
        }
        
    }
    
    func flagTapped(number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that is the flag of \(countries[number]), The correct answer is \(countries[correctAnswer])"
            score -= 1
        }
        askQuestion()
        showingScrore_alert = true
    }
    //reset the game
    func askQuestion() {
        countries.shuffle()
        animate = true
        correctAnswer = Int.random(in: 0...2)
    }
}

struct GradientttColors: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
//                LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .top, endPoint: .bottom)
//                RadialGradient(gradient: Gradient(colors: [.red, .purple]), center: .center, startRadius: 20, endRadius: 200)
//                AngularGradient(gradient: Gradient(colors: [.yellow, .red,.blue,.purple,.brown, .black, .white, .gray]), center: .center)
//                LinearGradient(gradient: Gradient(stops: [
//                        .init(color: .white, location: 0.45),
//                        .init(color: .black, location: 0.55),
//                    ]), startPoint: .top, endPoint: .bottom)
            }
            
            Text("Gues the flag")
                .bold()
                .foregroundStyle(.secondary)// iOS calls this effect vibrancy.
                .padding(55)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
            
            
            
            
            
        }.ignoresSafeArea()
    }
}
struct Project_2_Previews: PreviewProvider {
    static var previews: some View {
        Project_2()
    }
}

struct alerts: View {
    @State private var showAlert: Bool = false
    var body: some View {
        VStack{
            Button("Show Alert") {
                showAlert = true
            }.alert("Important message for you!", isPresented: $showAlert) {
                Button("Delete", role: .destructive) { showAlert = false }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Hello it is a simple message")
            }
        }
    }
}

//struct alerts_Previews: PreviewProvider {
//    static var previews: some View {
//        alerts()
//    }
//}


struct CornerRotateModifier_1: ViewModifier {
    let amount: Double
    let ancher: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: ancher)
            .clipped()
    }
}
extension AnyTransition {
    static var pivot_1: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: 160, ancher: .topLeading),
            identity: CornerRotateModifier(amount: 0, ancher: .topLeading))
    }
}
