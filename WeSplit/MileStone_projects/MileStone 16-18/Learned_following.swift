//
//  Learned_following.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 31/01/2023.
//

import Foundation
//Here is the list of things we learned in project 16 - 18
/*
 While completing these projects, you also learned:

 Reading environment values using @EnvironmentObject.
 Creating tabs with TabView.
 Using Swift’s Result type to send back success or failure.
 Manually publishing ObservableObject changes using objectWillChange.send().
 Controlling image interpolation.
 Adding swipe actions to list rows,.
 Placing buttons in a ContextMenu.
 Creating local notifications with the UserNotifications framework.
 Using third-party code with Swift package dependencies.
 Using map() and filter() to create new arrays based on an existing one.
 How to create dynamic QR codes.
 Attaching custom gestures to a SwiftUI view.
 Using UINotificationFeedbackGenerator to make iPhones vibrate.
 Disabling user interactivity using allowsHitTesting().
 Triggering events repeatedly using Timer.
 Tracking scene state changes as our app moves between the background and foreground.
 Supporting color blindness, reduced motion, and more.
 SwiftUI’s three step layout system.
 Alignment, alignment guides, and custom alignment guides.
 Absolutely positioning views using the position() modifier.
 Using GeometryReader and GeometryProxy to make special effects.
 */

//Key points.
//1. functional programming - map(), filter() and Result.
//map and filter both let us specify what we want rather then how we can get there.
//filter() example: We want even nums.
//let nums = [1,3,4,5,3,2,8]
//let even = [Int]()
//
//for num in nums {
//    if num.isMultiple(of: 2) {
//        even.append(num)
//    }
//}
////Now we don’t need to spell out how things should happen, and instead focus on what we want to happen
//let evens = nums.filter { $0.isMultiple(of: 2) }


//compactMap ->
//1. Runs a transformation function over every item in an array, just like map().
//2. Unwraps any optionals returned by that transformation function, and puts the result into a new array to be returned.
//3. Any optionals that are nil get discarded.
//map and CompactMap example.
//let numbers = ["1", "2", "fish", "3"]
//let evenMap = numbers.map(Int.init) // 2? ints, then nil, then 1? int
//let evensMapCompact = numbers.compactMap(Int.init)// three real ints, then no nil. much better.
//That creates an array of strings, then converts it to an array of integers using map() then compactMap().



//Result: Result type as a simple way of returning a single value that either succeeded or failed.
/*
 First, if you think about it, Result is like a slightly more advanced form of optionals. Optionals either contain some sort of value – an integer, a string, etc – or they contain nothing at all, and Result also contains some sort of value, but now rather than nothing at all for the alternative case it must contain some sort of error.
 
 If you have a Result and want to get back to do/catch territory, just call the get() method of your Result – this will return the successful value if it exists, or throws its error otherwise. see example.
 */




//Example:
//enum NetworkError: Error {
//    case badURL
//}
//func creatResult() -> Result<String, NetworkError> {
//    return .failure(.badURL)
//}
//let result = creatResult()
//That defines some sort of error, creates a function that returns either a string or an error (but in practice always returns an error), then calls that function and puts its return value into result. If you wanted to use do/catch with that value, you could use get() like this:
//do {
//    let successfulString = try result.get()
//    print(successfulString)
//} catch {
//    print("Oops! There was an error.")
//}




//To go the other way – to create a Result value from throwing code – you’ll find that Result has an initializer that accepts a throwing closure. If the closure returns a value successfully that gets used for the success case, otherwise the thrown error is placed into the failure case.
//for example:
//let result22 = Result { try String(contentsOf: someUrl) }
//In that code, result will be a Result<String, Error> – it doesn’t have a specific kind of Error because String(contentsOf:) doesn’t send one back.




//Last thing about result
/*
 The last thing you should know about Result is that it has functional methods you’re already used to, including map() and mapError(). For example, the map() method looks inside the Result, and transforms the success value into a different kind of value using a closure you specify – for example, it might transform a string into an integer. However, if it finds failure instead, it just uses that directly and ignores your transformation. Alternatively, mapError() transforms the error from one type to another, which can be helpful if you want to homogenize error types in one place.

 This is one of the many things to love about functional programming: once you understand the “takes a closure and uses it to transform stuff” nature of map(), you’ll find it exists on arrays, Result, and even Optional!
 */
