//
//  MCQS.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 29/01/2023.
//

import Foundation
//All Mqcs
/*
 Option 1: SwiftUI uses a three step layout process.
 The parent proposes a size, the child chooses its own size, and the parent positions it.

 Option 2: A GeometryReader always takes up all available space in its parent.
 We can change the size just like any other view.
 
 
 Option 1: When creating a custom alignment guide we must provide a default value.
 This will be used if we don't attach the alignmentGuide() modifier to a view.

 Option 2: SwiftUI has five built-in coordinate spaces.
 SwiftUI only has two built-in coordinate spaces: global and local.
 
 
 Option 1: If we write Text("Hello, World!").background(.red), the text view is a child of the background.
 The background view becomes the outermost view, with our text inside.

 Option 2: If we write Text("Hello, World!").background(.red), the background is a child of the text.
 The background view becomes the outermost view, with our text inside.
 
 
 Option 1: The Color view is layout neutral.
 This means it asks its child how much space to use, or occupies whatever size the parent suggested.

 Option 2: Parent views can force a size on one of their chidren.
 Parents must always respect the size requested by their children.
 
 
 Option 1: We can align text in a HStack using the baseline of the first or last text views.
 This is important for creating visual alignment when working with different font sizes.

 Option 2: Child views must always use less than or equal to the amount of space the parent offers them.
 Child views are welcome to request more space than was proposed, and the parent must respect that.
 
 
 Option 1: SwiftUI stores view positions and sizes as integers.
 Although SwiftUI rounds off its numbers when rendering, those numbers are stored as floating-point values for accuracy.

 Option 2: The offset() modifier changes where a view is rendered without actually changing its original dimensions.
 This subsequent modifiers will use the view's original dimensions.
 
 
 
 Option 1: The baseline of text is the very bottom of the lowest letter.
 Baselines exclude parts of the letter that go below the line, such as "g" or "y".

 Option 2: A view is always and exactly the same size as its body.
 When we apply size rules to a view, we are just applying those rules to whatever is in its body.
 
 
 Option 1: A GeometryReader is given one value inside its layout closure, which is a GeometryProxy containing layout information.
 We can use this to read our proposed size, our frame, and more.

 Option 2: Unless we ask for a custom alignment, most parents always place their child views in the top-left corner of their available space.
 Without further information, most parents place their child views in the center.
 
 
 Option 1: Text views automatically fit the size required to display all their lines.
 If you want them to be larger you should use padding or a custom frame.

 Option 2: It's a bad idea to create custom alignment guides.
 There's nothing bad about creating custom alignment guides; they are helpful.
 
 
 Option 1: GeometryReader tells us the size that was proposed by our parent.
 This lets us create relative layouts easily.

 Option 2: The createCoordinate() modifier lets us create a custom coordinate space.
 You should use the coordinateSpace() modifier for this.
 
 
 Option 1: The alignmentGuide() modifier lets us write custom code to calculate a view's alignment guide.
 This should be used together with whatever alignment its container is using.

 Option 2: We can't absolutely position views in SwiftUI.
 This is what the position() modifier is for.
 
 
 Option 1: Frames provided by GeometryReader are automatically updated as a view moves.
 We can use this approach to create modifiers that change as the view moves.

 Option 2: When creating a custom alignment guide, it's recommended to use structs rather than enums.
 The opposite is true: it's a good idea to use enums.
 
 
 Option 1: One instance of a class can be used in many SwiftUI views.
 This allows us to share data between views.

 Option 2: We can't absolutely position views in SwiftUI.
 This is what the position() modifier is for.
 
 
 
 Option 1: We can use multiple animation() modifiers on a single view.
 Using several animation modifiers lets us animate a view's state in different ways.

 Option 2: We can apply no more than three modifiers to a single view.
 You can apply as many modifiers as you want.
 
 
 Option 1: Classes that are used with @ObservableObject must conform to the ObservedObject protocol.
 @ObservedObject is the property wrapper, and ObservableObject is the protocol.

 Option 2: Asynchronous functions are able to sleep while their work completes.
 This allows our app to perform other work at the same time.
 
 
 Option 1: If we specify the width of an image, we must also specify its height.
 We can specify the width, the height, both, or neither – all will work.

 Option 2: One NavigationView can show two or three views inside it.
 This allows us to create a split view layout.
 
 
 
 Option 1: Materials let us apply a frosted glass-style blur effect for our view backgrounds.
 When combined with foregroundStyle(.secondary) this helps ensure UI elements stand out well from the background.

 Option 2: We can make a view take up all available screen width by using frame(maxWidth: .fill).
 We should use frame(maxWidth: .infinity) for this purpose
 
 */
