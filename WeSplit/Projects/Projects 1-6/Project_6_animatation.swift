//
//  Project_5_animatation.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 15/11/2022.
//

import SwiftUI
//Topics:  animations, gesture animations, transitions, and more., offset= move by x and y
//Here is the summary. Not well understood-> Bundle, UITextChecker, fetalError
/*
 How to read numbers from users with Stepper, including using its shorter form when your label is a simple text view.
 Letting the user enter dates using DatePicker, including using the displayedComponents parameter to control dates or times.
 Working with dates in Swift, using Date, DateComponents, and DateFormatter
 How to bring in machine learning to leverage the full power of modern iOS devices.
 Building scrolling tables of data using List, in particular how it can create rows directly from arrays of data.
 Running code when a view is shown, using onAppear().
 Reading files from our app bundle by looking up their path using the Bundle class, including loading strings from there.
 Crashing your code with fatalError(), and why that might actually be a good thing.
 How to check whether a string is spelled correctly, using UITextChecker.
 Creating animations implicitly using the animation() modifier.
 Customizing animations with delays and repeats, and choosing between ease-in-ease-out vs spring animations.
 Attaching the animation() modifier to bindings, so we can animate changes directly from UI controls.
 Using withAnimation() to create explicit animations.
 Attaching multiple animation() modifiers to a single view so that we can control the animation stack.
 Using DragGesture() to let the user move views around, then snapping them back to their original location.
 Using SwiftUI’s built-in transitions, and creating your own.
 */
//rotation3DEffect() can rotate around more than one axis. Try using (x: 1, y: 1, z: 0), for example.
struct Project_5_animatation: View {
    @State private var animationAmount = 1.0
    //@State private var animationAmount2 = 0.0
    
    @State private var enabled = false
    
    @State private var dragAmount = CGSize.zero
    
    let letters = Array("Hello, Twifty")
    
    @State private var isShowing = false
    var body: some View {
        VStack {
//            Button("Tap me") {
//                //animationAmount += 1
//            }
//            .padding(50)
//            .foregroundColor(.white)
//            .background(.red)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//            .blur(radius: (animationAmount - 1) * 3)
//            .animation(
//                //.interpolatingSpring(stiffness: 50, damping: 0),
//                //.delay(2)
//                .easeInOut(duration: 1)
//                //.repeatCount(2, autoreverses: true),
//                    .repeatForever(autoreverses: true),
//                value: animationAmount
//            )
            
            
            
//            Button("Searching") {
//                //animationAmount += 1
//            }
//            .padding(50)
//            .foregroundColor(.white)
//            .background(.mint)
//            .clipShape(Circle())
//            .overlay(
//                Circle()
//                    .stroke(.black)
//                    .scaleEffect(animationAmount)
//                    .opacity(2 - animationAmount)
//                    .animation(.easeInOut(duration: 1)
//                        .repeatForever(autoreverses: false),
//                               value: animationAmount)
//
//            )
//            .overlay(
//                Circle()
//                    .stroke(.red)
//                    .scaleEffect(animationAmount2 + 1.5)
//                    .opacity(1 - animationAmount2)
//                    .animation(.easeInOut(duration: 1)
//                        .repeatForever(autoreverses: false),
//                               value: animationAmount2)
//
//            )
//            .onAppear {
//                //animationAmount2 = 1
//                //animationAmount = 2
//            }
            
            
            
//            Stepper("Increament",
//                    value: $animationAmount.animation(
//                        .easeInOut(duration: 1)
//                        //.repeatForever(autoreverses: false)
//                            .repeatCount(3, autoreverses: false)
//                    ),
//                    in: 1...10,
//                    format: .number)
//                .padding()
//
//            Spacer()
//
//            Button("Tap Me!") {
//                animationAmount += 1
//            }
//            .padding(40)
//            .foregroundColor(.white)
//            .background(.red)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
            
            
            //Explicit animation
            Button("Tap Me!") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    animationAmount += 360
                }
            }
            .padding(56)
            .bold()
            .foregroundColor(.white)
            .background(.purple)
            .clipShape(Circle())
            //.scaleEffect(animationAmount)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            .animation(.easeIn)
            
            
            Button("Tap Me!") {
                enabled.toggle()
            }
            .frame(width: 100, height: 100)
            .foregroundColor(.white)
            //.animation(.easeInOut, value: enabled)
            .animation(nil, value: enabled)
            .background(enabled ? .purple : .red)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 30 : 0))
            .animation(.interpolatingSpring(stiffness: 20, damping: 1), value: enabled)
            
            
            
//            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .frame(width: 300, height: 200)
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .offset(dragAmount)
//                .gesture(
//                    DragGesture()
//                        .onChanged {
//                            dragAmount = $0.translation
//                        } //adds an action to perform when the gesture value changes
//                        .onEnded { _ in
//                            withAnimation { //explicit animation
//                                dragAmount = .zero
//                            }
//                        }//adds an action to perform when the gesture value ends
//                )
//                //.animation(.spring(), value: dragAmount)//implicit animation
            
            //snake animation
//            HStack(spacing: 0) {
//                ForEach(0..<letters.count) { num in
//                    Text(String(letters[num]))
//                        .padding(5)
//                        .foregroundColor(.white)
//                        .font(.title)
//                        .background(enabled ? .blue : .red)
//                        .offset(dragAmount)
//                        .animation(.default.delay(Double(num) / 20), value: dragAmount)
//                }
//            }
//            .gesture(
//                DragGesture()
//                    .onChanged{ dragAmount = $0.translation }
//                    .onEnded{_ in
//                        dragAmount = .zero
//                        enabled.toggle()
//                    }
//            )
            
            
            //transition, showing and hiding view
//            Button("Tap me!") {
//                withAnimation {
//                    isShowing.toggle()
//                }
//            }
//            if isShowing {
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.scale)
//                    //.transition(.asymmetric(insertion: .scale, removal: .opacity))
//            }
                
            ZStack {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .overlay {
                        Text("Nothing")
                    }

                if isShowing {
                    Rectangle()
                        .fill(.mint)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                        .overlay {
                            Text("You got it")
                        }
                }
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) {
                    isShowing.toggle()
                }
            }
            
        }
        
        
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let ancher: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: ancher)
            .clipped()
    }
}
extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: 160, ancher: .topLeading),
            identity: CornerRotateModifier(amount: 0, ancher: .topLeading))
    }
}

struct Project_5_animatation_Previews: PreviewProvider {
    static var previews: some View {
        Project_5_animatation()
    }
}
