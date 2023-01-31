//
//  FZ_HomeView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 28/01/2023.
//

import Foundation
import SwiftUI
extension View {
    func stacked(position: Int, total: Int) -> some View {
        let offset = Double(total * position)
        return self.offset(x: 0, y: offset)
    }
}

struct FZ_HomeView: View {
    //Array<FZ_Card>(repeating: FZ_Card.example, count: 10) ->create 10 cards with the example.
    @State private var cards = [FZ_Card]()
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State private var timeRamaining = 20
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //Take a look at the current value in the timer, Press Cmd+H to go back to the home screen, Wait about ten seconds, Now tap your app’s icon to go back to the app, What time is shown in the timer?
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    
    @State private var isWrong = true
    
    var body: some View {
        ZStack {
            Image(decorative: "background")// it won’t be read out as part of the accessibility layout.
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRamaining)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(cards, id: \.self) { card in
                        FZ_CardView(card: card) { result in
                            withAnimation(Animation.linear.delay(0.5)) {
                                print(result)
                                if !result {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        cards.insert(card, at: 0)
                                        isActive = true
                                    }
                                }
                                if let index = self.cards.firstIndex(of: card) {
                                    removeCard(at: index)
                                }
                                
                            }
                        }
                        .stacked(position: self.cards.firstIndex(of: card)!, total: self.cards.count)
                        .allowsHitTesting(self.cards.firstIndex(of: card)! == self.cards.count - 1)
                        .accessibility(hidden: self.cards.firstIndex(of: card)! < self.cards.count - 1 )
//                        .stacked(position: card, total: cards.count)//cards stack at climbing form.
//                        .allowsHitTesting(index == cards.count - 1) //allow only top to be dragged.
//                        .accessibilityHidden(index < cards.count - 1)
                           //index less than the top card should be hidden from the accessibility system.
                    }
                }
                .allowsHitTesting(timeRamaining > 0)//disable interactivity for a view by setting allowsHitTesting() to false.
                
                //start again button.
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .padding(.vertical)
                }
            }
            
            //add button.
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            //for differentiateWithoutColor and voiceOverEnabled.
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRamaining > 0 {
                timeRamaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if !cards.isEmpty { //check cards whether it is empty or have some cards.
                    isActive = true
                    isWrong = true
                }
            } else {
                isActive = false
                isWrong = false
            }
        }
        //syntactic sugar – we’re treating our view struct like a function, because Swift silently treats that as a call to the view’s initializer
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: FZ_AddView.init)//when you want to read the content for the sheet, call the EditCards initializer and it will send you back the view to use. Note EditCards has an initializer that accepts no parameters.
        .onAppear(perform: resetCards)//want to call it when the view first appears, so add this modifier below the previous one.
    }
    
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        cards.remove(at: index)
        
        if cards.isEmpty && isWrong { //stop the timer
            isActive = false
        }
    }
    func resetCards() {
        cards = Array(repeating: FZ_Card.example, count: 10)
        timeRamaining = 100
        isActive = true
        loadData()
    }
    func loadData() { //attempt to read data from userDefualt
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([FZ_Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    

}
