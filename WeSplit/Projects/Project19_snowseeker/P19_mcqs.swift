//
//  P19_mcqs.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 03/02/2023.
//

import Foundation
//Here are the list of MCQS:
/*
 Option 1: All iPhones have a compact width size class in portrait.
 In landscape some have compact width and others regular width.

 Option 2: alert() does not support optional data.
 alert() works just fine with optional data, but you still need to bind a Boolean to determine whether the alert is showing or not.
 
 
 Option 1: One static let property can reference another in the same type.
 Be careful not to make a reference chain by accident, because it can cause your code to crash.

 Option 2: iPads have an identical size class configuration to iPhones.
 They have very different size class configurations, affected by the screen size, orientation, and how much of the screen is allocated to your app.
 
 
 Option 1: Images built from SF Symbols icons have a customizable foreground color.
 This lets us display the icons in whatever color we want.

 Option 2: We can't add computed properties to SwiftUI views.
 Computed properties work just fine in SwiftUI views.
 
 
 Option 1: The user interface idiom of a device can tell us whether we're running in portrait or landscape.
 User interface idiom tells us whether the device is a tablet, phone, or TV.

 Option 2: The largest iPhones – Max and Plus sizes – use a regular horizontal size class in landscape.
 On iPhone the story is mostly simple, but make sure you experiment on iPad because its more complicated there.
 
 
 Option 1: static let properties are always created lazily.
 This means they are only initialized when first accessed.

 Option 2: Marking a property as private means only other code in the same file can use it.
 This is what fileprivate does, not private.
 
 
 Option 1: SwiftUI can show four views side by side in a single NavigationView.
 SwiftUI supports up to three views side by side in a single NavigationView.

 Option 2: We can use the dynamicTypeSize() modifier to declare which Dynamic Type sizes a view supports.
 It's a good idea to support all of them, but it's also okay to add limits if you don't have a better option.
 
 
 Option 1: We can force a navigation view to show only one view using navigationViewStyle().
 This makes our UI simpler, but might look odd on iPad.

 Option 2: There are five distinct text sizes available with Dynamic Type, and we need to support them all.
 There are far more than five text sizes available, and we don't need to support them all – please do your best, though!
 
 
 
 Option 1: Adding a search bar is done using the searchable() modifier.
 We can bind values for the user's search text and the prompt to show in the search bar.

 Option 2: Adding a search bar is done using the searching() modifier.
 We need to use the searchable() modifier.
 
 
 
 Option 1: SwiftUI can't show string arrays inside Text views.
 SwiftUI is perfectly capable of doing this – just remember to use the format parameter.

 Option 2: We can bind an alert() modifier to an optional value.
 The alert will be shown as soon as the optional value is set to something.
 
 
 
 Option 1: All iOS devices have horizontal and vertical size classes.
 The exact configuration depends on the device size and orientation, but all devices have both size classes.

 Option 2: A Group view can contain more than 10 subviews.
 No view can contain more than 10 subviews.
 
 
 Option 1: If we place views inside a Group the parent view decides how those views should be laid out.
 This happens because Group is layout neutral.

 Option 2: The destination of a NavigationLink is always shown in the current view.
 If we have two views in a navigation view, NavigationLink presents destinations in the secondary view.
 
 
 Option 1: Creating a property using @Environment(\.horizontalSizeClass) will keep the value updated when the size class changes.
 This allows us to create a UI that updates itself as the size class changes.

 Option 2: A VStack can have an alignment or spacing, but not both.
 You can use either, both, or none depending on your needs.
 */
