//
//  FZ_CardView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 28/01/2023.
//

import SwiftUI

import SwiftUI

struct FZ_CardView: View {
    let card: FZ_Card
    //@State var count: Int
    var onRemove: ((Bool) -> Void)? = nil
    
    @State private var feedBack = UINotificationFeedbackGenerator()
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled//to read the answer to the cards as well as the questions.
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor ? nil :
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width >= 0 ? .green : .red)//challenge 2. a little red glich while draging to right and release.
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    //If you try that out with VoiceOver you’ll hear that it works much better – as soon as the card is double-tapped the answer is read out.
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                } else {
                    HStack {
                        Text("Count")
                            .font(.title3)
                            .bold()
                        Spacer()
                    }
                    Spacer()
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5))) //rotate the card as user drags.
        .offset(x: offset.width * 5, y: 0)//apply our movement, so the card slides relative to the horizontal drag amount.
        .opacity(2 - Double(abs(offset.width / 50))) //to make the card fade out as it’s dragged further away.
        .accessibilityAddTraits(.isButton)// our cards are tappable buttons.
        .gesture(
            DragGesture()
                .onChanged { gesture in //when we move our fingure on screen, how far the move their finger from start to end.
                    offset = gesture.translation
                    feedBack.prepare()// prepare the generator to trigger feedback. changes with fingers.
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        var isCorrect: Bool
                        //feel the haptic when the offset.width goes > 0. there is always the risk that the haptic will be delayed. So we use prepare() in onChange.
                        if offset.width > 0 {
                            feedBack.notificationOccurred(.success)
                            isCorrect = true
                        } else {
                            feedBack.notificationOccurred(.error)
                            isCorrect = false
                        }
                        //remove the card
                        onRemove?(isCorrect)
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer = true
        }
        .animation(.spring(), value: offset)
        
    }
}
