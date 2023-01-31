//
//  MCQS.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 23/01/2023.
//

import Foundation
/*
 Option 1: We can display local notifications without asking permission, as long as they don't play sounds.
 All notifications require permission.

 Option 2: Properties wrapped in @EnvironmentObject must have a value before the view is shown.
 If their view is shown without the value right, your app crashes.
 
 Option 1: Local notifications can show alerts and play sounds
 Try to limit how many notifications you show, to avoid annoying your user.

 Option 2: Encapsulation means placing all our code into individual Swift modules.
 Encapsulation limits how much external objects can read and write values inside a class or a struct.
 
 Option 1: One environment object can be shared in up to two views.
 There is no limit to the number of views that can share a single environment object.

 Option 2: The map() method transforms items in a sequence using a closure we specify.
 map() always transforms every item.
 
 Option 1: @EnvironmentObject properties must conform to ObservableObject.
 They use exactly the same protocol, which means @Published and more works.

 Option 2: Swift's Result type is designed for use with throwing functions.
 It can be used with throwing functions, but it doesn't need to be.
 
 Option 1: We can attach images to context view buttons, but they don't have any color.
 It's generally best to use line art such as the SF Symbols icons.

 Option 2: QR codes are just barcodes with more colors.
 QR codes are quite different, but they also use two colors just like barcodes.
 
 Option 1: It's a good idea to attach a context menu to every view.
 This is A Very Bad Idea Indeed.

 Option 2: Context menus are triggered when users long press on a view.
 This used to be done using a hard press, but long press is the standard now.
 
 Option 1: We can add multiple swipe actions to either side of a list row.
 iOS lets us add as many as we want, although in practice any more than three is likely to be hard to use.

 Option 2: The filter() method sorts a sequence based on a closure we specify.
 The filter() method creates a new array by running each element in a sequence through a predicate.
 
 Option 1: Swift Package Dependencies let us easily import third-party code.
 There are thousands of packages out there to draw on!

 Option 2: We can queue up to three notifications at a time.
 You can queue more than three, but remember not to annoy your user!
 
 Option 1: If we want to programmatically set the active tab for a TabView, we must set a tag on the views inside it.
 The tag can be an integer or a string.

 Option 2: SwiftUI's lists cannot work with computed properties.
 SwiftUI's lists work great with computed properties.
 
 Option 1: We can call objectWillChange.send() to notify SwiftUI that an observable object is about to change.
 This allows us to add custom functionality to changes before triggering the notification.

 Option 2: We can call objectDidChange.send() to notify SwiftUI that an observable object has changed.
 You should use objectWillChange.send() for this purpose.
 
 Option 1: Swift's Result type can contain either success or failure, but not both.
 This lets us reduce complexity in our code by eliminating impossible program states.

 Option 2: @EnvironmentObject only works with structs.
 @EnvironmentObject only works with classes.
 
 Option 1: SwiftUI disables image interpolation by default.
 SwiftUI enables high-quality interpolation by default.

 Option 2: SwiftUI smooths out the pixels in an image if we stretch it larger than its original size.
 We can control interpolation using the interpolation() modifier.
 */
