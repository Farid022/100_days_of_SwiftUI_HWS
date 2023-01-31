//
//  Practice_Flashzilla.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 24/01/2023.
//

import SwiftUI
import CoreHaptics

struct Practice_Flashzilla: View {
    @State private var text = ""
    
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    
    @State private var currentAmount_r = Angle.zero
    @State private var finalAmount_r = Angle.zero
    
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    // whether it is currently being dragged or not
    @State private var isDragging = false
    
    @State private var engine: CHHapticEngine?
    
    //Timer. it is a publisher, to catch the announcement we need to use the .onRevieve() This accepts a publisher as its first parameter and a function to run as its second, and it will make sure that function is called whenever the publisher sends its change notification.
    /*
     That does several things all at once:

     It asks the timer to fire every 1 second.
     It says the timer should run on the main thread.
     It says the timer should run on the common run loop, which is the one you’ll want to use most of the time. (Run loops let iOS handle running code while the user is actively doing something, such as scrolling in a list.)
     It connects the timer immediately, which means it will start counting time.
     It assigns the whole thing to the timer constant so that it stays alive.
     */
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var count = 0
    
    //How to be notified when your SwiftUI app moves to the background
    @Environment(\.scenePhase) var scenPhase
    
    //Supporting specific accessibility needs with SwiftUI
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State private var scaleeAm = 0.0
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        VStack {
            //1. Gestures
            VStack {
                Text("Press Me")
                    .padding()
                    .background(.purple)
                    .onTapGesture(count: 2) {
                        text = "Pressed Well"
                    }
                
                Text("Long Press")
                    .padding()
                    .background(.purple)
                    .onLongPressGesture(minimumDuration: 3) {
                        text = "Long Pressed Well"
                    } onPressingChanged: { inProgress in
                        print("Value is: \(inProgress)")
                    }
                
                Text(text)
                
                Text("Zoom with Magnificant gesture!")
                    .scaleEffect(finalAmount + currentAmount)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { amount in
                                currentAmount = amount - 1
                            }
                            .onEnded { amount in
                                finalAmount += currentAmount
                                currentAmount = 0
                            }
                    )
                
                Text("Zoom with Rotation gesture")
                    .rotationEffect(finalAmount_r + currentAmount_r)
                    .gesture(
                        RotationGesture()
                            .onChanged { angle in
                                currentAmount_r = angle
                            }
                            .onEnded { amount in
                                finalAmount_r += currentAmount_r
                                currentAmount_r = .zero
                            }
                    )
                
                //high priority gesture
                VStack {
                    Text("Child View")
                        .onTapGesture {
                            print("Child is tapped")
                        }
                }
                .padding()
                .background(.green)
                //.onTapGesture { print("VStack view is tapped") } //by defualt child tap will be done
    //            .highPriorityGesture(
    //                TapGesture()
    //                    .onEnded {
    //                        print("VStack tap is tapped")
    //                    }
    //            ) //prefere to one over other
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            print("VStack tap is tapped")
                        }
                ) //do both
                
                
                Circle()
                    .fill(.purple)
                    .frame(width: 64, height: 64)
                    .scaleEffect(isDragging ? 1.5 : 1)  //zoom amount
                    .offset(offset)
                    .gesture(combined)
                
                
            }
            
            //2. Making vibrations with UINotificationFeedbackGenerator and Core Haptics
            VStack {
                //simple
                Text("Check the haptic when you long press")
                    .onLongPressGesture {
                        simpleSuccess()
                    }
                
                //Complex
                Text("Check the complex haptic")
                    .onAppear(perform: prepareHaptics)
                    .onTapGesture(perform: complexSuccess)
            }
            
            //Disabling user interactivity with allowsHitTesting()
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 10, height: 10)
                        .onTapGesture {
                            print("Rectangle is tapped!")
                        }
                    
                    Circle()
                        .fill(.red)
                        .frame(width: 10, height: 10)
                        .contentShape(Rectangle())//contentShape() modifier, which lets us specify the tappable shape for something.
                        .onTapGesture {
                            print("Circle is tapped!")
                        }
                        //.allowsHitTesting(false)//allowsHitTesting() modifier. When this is attached to a view with its parameter set to false, the view isn’t even considered tappable
                }
                
                //contentShape example
                VStack {
                    Text("Hello")
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("World")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Vstack is tapped")
                }
            }
            
            //timer
            VStack {
                Text("Time")
                    .onReceive(timer) { time in
                        if count == 4 {
                            timer.upstream.connect().cancel()
                        } else {
                            print("Time is \(time)")
                        }
                        
                        count += 1
                    }
            }
            
            //scenPahse.
            Text("hello World")
                .padding()
                .onChange(of: scenPhase) { newPhase in
                    if newPhase == .active {
                        print("Active state")
                    } else if newPhase == .inactive {
                        print("inActive state")
                    } else if newPhase == .background {
                        print("Background State")
                    }
                }
            
            //Supporting specific accessibility needs with SwiftUI
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? .black : .green)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            //restrict the use of withAnimation() when it involves movement,
            Text("ReduceMotion")
                .scaleEffect(scaleeAm)
                .onTapGesture {
                    if reduceMotion {
                        scaleeAm *= 1.5
                    } else {
                        withOptionalAnimation {
                            scaleeAm *= 1.5
                        }
                    }
                }
            
            // this code uses a solid black background when Reduce Transparency is enabled, otherwise using 50% transparency:
            Text("Hello, World!")
                .padding()
                .background(reduceTransparency ? .black : .black.opacity(0.5))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
        
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator() //A concrete feedback generator subclass that creates haptics(touch feeling) to communicate successes,failures, and warnings.
        generator.notificationOccurred(.success)
        
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
        
        //if you replace those three lines with this next code you’ll get several taps of increasing then decreasing intensity and sharpness
        /*
         for i in stride(from: 0, to: 1, by: 0.1) {
             let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
             let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
             let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
             events.append(event)
         }

         for i in stride(from: 0, to: 1, by: 0.1) {
             let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
             let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
             let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
             events.append(event)
         }
         */
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct Practice_Flashzilla_Previews: PreviewProvider {
    static var previews: some View {
        Practice_Flashzilla()
    }
}
