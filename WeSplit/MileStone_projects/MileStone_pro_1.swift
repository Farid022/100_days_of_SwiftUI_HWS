//
//  MileStone_pro_1.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 12/11/2022.
//

import SwiftUI

struct Milestone_pro3: View {
    let myMoves: [String] = ["rock", "paper", "scissors"]
    var body: some View {
        VStack{
            Form {
                Section {
                    Text("Your score: ")
                        
                }
            }
        }
    }
}


struct My_titleModiefier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.red)
            .background(.green)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(My_titleModiefier())
    }
}

struct NewGroupwork: View {
    let text_is = Text("Jemmy")
    var myNewText: some View {
        Text("Here is my new text")
    }
    var spellls: some View {
        Group {
            Text("Text 1")
            Text("Text 2")
        }
    }
    @State var isCorrect = false
    
    //ViewBuilder does the same thing that the body does.
    @ViewBuilder var mybuilder: some View {
        Text("Hello my dear viewBuilder")
    }
    
    var body: some View {
        VStack{
            text_is
                .titleStyle()
            myNewText
                .modifier(My_titleModiefier())
                
            
            spellls
                .titleStyle()
            mybuilder
                .modifier(My_titleModiefier())
            
            Button {
                isCorrect.toggle()
            } label: {
                Text("Change Color of the button")
                    .padding()
                    .background(isCorrect ? .green : .red)
            }
            
            Text(isCorrect.description)

        }
    }
}

//struct NewGroupwork_Previews: PreviewProvider {
//    static var previews: some View {
//        NewGroupwork()
//    }
//}


//Create an Ontology of your own choice in protege. That give us atleast 2 inferred information after applying reasoner.

struct ContentView222: View {
    @State private var selection = 0

    var body: some View {
        let binding = Binding(
            get: { selection },
            set: { selection = $0 }
        )

        return VStack {
            Picker("Select a number", selection: binding) {
                ForEach(0..<3) {
                    Text("Item \($0)")
                }
            }
            .pickerStyle(.segmented)
        }
    }
}
//So, that binding is effectively just acting as a passthrough – it doesn’t store or calculate any data itself, but just acts as a shim between our UI and the underlying state value that is being manipulated.
//
//However, notice that the picker is now made using selection: binding – no dollar sign required. We don’t need to explicitly ask for the two-way binding here because it already is one.


struct ContentView_challenge_25: View {

    var choice = ["Rock", "Paper", "Scissors"]
    @State var score = 0

    @State private var computerChoice = Int.random(in: 0 ..< 3)
    @State private var shouldWin = Bool.random()

    var body: some View {

        Form {
            Text("Score: \(score)")
            Text("Computer has choosen:")
            Text("\(choice[computerChoice])").bold().padding()
            Text("You have to \(shouldWin ? "WIN" : "LOOSE")")
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 40) {
                ForEach(0 ..< 3) { item in
                    Button(action: {
                        self.checkChoice(item)
                        self.next()
                    }) {
                        Text("\(choice[item])").padding()
                    }
                }
            }
        }
    }

    func checkChoice(_ item: Int) {
        if shouldWin == true {
            if computerChoice == item {
                score -= 1
            }
            else if computerChoice == 0 && item == 2 {
                print("you loose, you choose Scissors and computeur Rock")
            }
            else if computerChoice == 1 && item == 0 {
                print("you loose, you choose Rock and computeur Paper")
            }
            else if computerChoice == 2 && item == 1 {
                print("you loose, you choose Paper and computeur Scissors")
            } else {
                score += 1
            }
        } else {
            if computerChoice == 0 && item == 2 {
                print("you win, you choose Scissors and computeur Rock")
                score += 1
            }
            else if computerChoice == 1 && item == 0 {
                print("you win, you choose Rock and computeur Paper")
                score += 1
            }
            else if computerChoice == 2 && item == 1 {
                print("you win, you choose Paper and computeur Scissors")
                score += 1
            } else {
                score -= 1
            }

        }

    }

    func next() {
        computerChoice = Int.random(in: 0 ..< 3)
        shouldWin = Bool.random()
    }
}

    struct ContentView_challenge_25_Previews: PreviewProvider {
        static var previews: some View {
            ContentView_challenge_25()
        }
    }
