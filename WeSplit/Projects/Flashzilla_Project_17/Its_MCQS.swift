//
//  Its_MCQS.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 28/01/2023.
//

import Foundation
//MCQS
/*
 Option 1: Several gestures have both onChanged() and onEnded() modifiers for us to use.
 These let us track the gesture's progress and completion respectively.

 Option 2: UINotificationFeedbackGenerator is part of Core Haptics.
 The "UI" prefix means this is actually from UIKit.
 
 
 Option 1: The sequenced(before:) modifier lets us create chains of gestures.
 The first gesture must succeed in order for the second to be recognized.

 Option 2: When Reduce Motion is enabled, we should disable all animations.
 You should disable animations that use motion, but fades are still OK.
 
 
 Option 1: The Combine framework is built into SwiftUI.
 Although SwiftUI uses some parts of Combine, they are two separate frameworks.

 Option 2: When allowsHitTesting() is false, a view cannot be tapped.
 Any taps simply pass through to whatever is stacked below.
 
 
 Option 1: Reading the .accessibilityDifferentiateWithoutColor key lets us add extra accessibility support for color blind users.
 You should use shapes, icons, and textures instead.

 Option 2: By default, a NavigationView doesn't work in landscape.
 NavigationView does work, although SwiftUI's definition of "work" might not match yours.
 
 
 Option 1: We should create important images using the Image(decorative:) initializer, so that VoiceOver knows to read them extra loud.
 Images marked as decorative won't be read by VoiceOver at all.

 Option 2: We can call prepare() on UIFeedbackGenerator subclasses as often as we need.
 If we never call play(), iOS reserves the right to start ignoring our prepare() calls.
 
 
 Option 1: The willResignActiveNotification notification is sent when an app is moving to the background.
 This is our opportunity to pause any ongoing work.

 Option 2: The willResignActiveNotification notification is sent when an app is moving to the foreground.
 Our app resigns active when it's moving from the foreground to the background.
 
 
 Option 1: Struct initializers can contain closures as parameters.
 If they are the last property in the struct Swift will enable trailing closure syntax automatically.

 Option 2: Once a Timer has started, it can't be stopped.
 You can stop a timer whenever you want.
 
 
 Option 1: In Xcode, projects and targets are the same thing.
 One project can have multiple targets.

 Option 2: We can receive values from a Combine publisher using onReceive().
 This can be a Timer, a notification from Notification Center, or something else.
 
 
 Option 1: contentShape() allows us to control the tap area for a view.
 This is particularly useful for stacks that have layout "holes".

 Option 2: Timers automatically pause as soon as our app moves to the background.
 Timers will pause at some point, but it won't be immediately.
 
 
 Option 1: Timer tolerance allows iOS to delay a timer for better energy efficiency.
 There is zero tolerance by default, but that still doesn't guarantee exact timings.

 Option 2: The abs() function returns true if its input number is absolutely zero.
 The abs() function technically describes how far away a number is from zero, without taking into account whether it is positive or negative.
 
 
 Option 1: init(repeating:count:) repeats the same value many times to make an array.
 If you pass it a function to call, it will only be called once.

 Option 2: It's a good idea to attach haptics to every button in our app.
 You should use haptics sparingly so that you don't confuse or desensitize users.
 */
