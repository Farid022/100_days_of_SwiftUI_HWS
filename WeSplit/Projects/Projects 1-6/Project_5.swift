//
//  Project_5.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 12/11/2022.
//

import SwiftUI

//We will learn: List, onAppear(), Bundle, fatalError(), UITextChecker
//Put a text view somewhere so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.
struct Project_5_practice: View {
    var body: some View {
        List(0..<6) { item in
            Text("Static Row: \(item)")
//
//            ForEach(1..<4) {
//                Text("Dynamic Row: \($0)")
//            }
//
//            Text("Static Row")
        }.listStyle(.grouped)
    }
    func load_file() {
        if let loadFile = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContent = try? String(contentsOf: loadFile) {
                //
            }
        }
    }
    
    func test() {
        let input = "a b c"
        let letters = input.components(separatedBy: " ") //converts a single string into an array of strings
        
        let input22 = """
                    a
                    b
                    c
                    """
        let letters2 = input22.components(separatedBy: "\n")
        
        let letter = letters2.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)//cut whitespaces etc
        
        
        let word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
        
    }
}

struct Project_5_practice_Previews: PreviewProvider {
    static var previews: some View {
        WordScramble()
    }
}


//here is the project
struct WordScramble: View {
    @State private var newWord = ""
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter a word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section("Used Words") {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
                
                Section {
                    Button {
                        addNewWord()
                        startGame()
                    } label: {
                        Text("Check the word")
                    }
                    

                }
            }
            .navigationTitle(rootWord)
                .onAppear(perform: startGame)//We can use onAppear() to run a closure when a view is shown.
                .alert(errorTitle, isPresented: $showingError) {
                    Button("Generate New Word", role: .cancel) { startGame() }
                } message: {
                    Text(errorMessage)
                }
                .toolbar {
                    Button("Reset", action: startGame)
                }
        }
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
            let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

            // exit if the remaining string is empty
            guard answer.count > 0 else { return }

            // extra validation to come
        guard isOrignal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        withAnimation(.easeIn(duration: 0.5)) {
            if answer.count > 3 {
                usedWords.insert(answer, at: 0)
            } else {
                wordError(title: "Short Answer", message: "Sorry, your answer is shorter than 3 words")
            }
        }
        newWord = ""
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWord_URl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWord_URl) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silKworn"
                
                // If we are here everything has worked, so we can exit
                return
            }
        }
        
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOrignal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String ) -> Bool {
        var tempWord = rootWord //copy of the rootWord.
        
        for letter in word { //loop over user inputs if that letter exist in our copy, if it does exist, remove it(so it can’t be used twice)
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()//instance, responsible for scanning strings for misspelled words
        let range = NSRange(location: 0, length: word.utf16.count) //scan the entire length of our string,where the misspelled word was found
        let misSpelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en") // it looks for wrong words
        
        return misSpelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String )  {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
  
}










