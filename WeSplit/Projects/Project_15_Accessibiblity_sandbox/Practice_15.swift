//
//  Practice_15.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 16/01/2023.
//
import SwiftUI

struct Practice_15: View {
    let pictures = [
            "ales-krivec-15949",
            "galina-n-189483",
            "kevin-horstmann-141705",
            "nicolas-tissot-335096"
        ]
    @State private var selectedPicture = Int.random(in: 0...3)
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    
    @State private var photo = Image("apollo10")
    
    @State private var value = 10
    var body: some View {
        VStack {
            Image(pictures[selectedPicture])
                       .resizable()
                       .scaledToFit()
                       .onTapGesture {
                           selectedPicture = Int.random(in: 0...3)
                       }
                       .accessibilityLabel(labels[selectedPicture]) //This allows VoiceOver to read the correct label no matter what image is present
                       .accessibilityAddTraits(.isButton)//tell it that our image is also a button by adding this modifier.
                       .accessibilityRemoveTraits(.isImage)
            
            //With these changes in place our UI works much better: VoiceOver now reads a useful description of the image’s contents, and also makes users aware the image is also a button.
            
            Image(decorative: "character")
                .accessibilityHidden(true) //The image becomes invisible to VoiceOver
            
            //The last way to hide content from VoiceOver is through grouping
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }.accessibilityElement(children: .combine)
                .accessibilityLabel("Your score is 1000")
            
            
            VStack {
                Text("Value: \(value)")

                Button("Increment") {
                    value += 1
                }

                Button("Decrement") {
                    value -= 1
                }
            }.accessibilityElement()
                .accessibilityLabel("Value")
                .accessibilityValue(String(value))
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment:
                        value += 1
                    case .decrement:
                        value -= 1
                    default:
                        print("Not handled.")
                    }
                }
            
            LabeledContent("Title") {
                Text(44, format: .number)
            }
            LabeledContent("Total", value: 55, format: .number)
            
            //Method 1
            ShareLink("Share", item: "Nothing")
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
            
            //Method 2 + text of shareing
            ShareLink(item: photo, preview: SharePreview("Share Profile photo", image: photo))
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
            
            photo
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 100)
            
        }.padding(.horizontal)
    }
}

struct Practice_15_Previews: PreviewProvider {
    static var previews: some View {
        Practice_15()
    }
}

