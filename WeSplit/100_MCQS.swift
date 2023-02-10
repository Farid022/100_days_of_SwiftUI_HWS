//
//  100_MCQS.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 03/02/2023.
//

import Foundation
//Here are the 100 MCQS:
/*
 Option 1: As it's a container, VStack can't have accessibility data.
 VStack is a view, so it can have accessibility data of its own like any other view.

 Option 2: Three text fields in the same VStack are considered to be separate elements if they aren't specifically combined.
 This means users can select them individually.
 
 Option 1: The alignmentGuide() modifier lets us write custom code to calculate a view's alignment guide.
 This should be used together with whatever alignment its container is using.

 Option 2: Views come with a built-in dismiss() method that lets us hide the view.
 If you want to dismiss a view, you need to use the environment to read the correct dismiss action for however the view is being shown.
 
 
 Option 1: We can create a rounded rectangle shape using SwiftUI's Capsule shape.
 Rounded rectangles and capsules are different shapes.

 Option 2: We can place optional views directly into a SwiftUI view hierarchy.
 SwiftUI will only render them if they have a value.
 
 
 Option 1: SwiftUI lets us animate changes that occur as a result of modifying a Boolean's value.
 It evaluates your view state before the change and after, and animates the differences.

 Option 2: Alert messages cannot include string interpolation.
 Alert messages are just text; you can create them however you want.
 
 Option 1: Properties wrapped in @EnvironmentObject must have a value before the view is shown.
 If their view is shown without the value right, your app crashes.

 Option 2: MVVM stands for Multiple Views, Varying Models.
 MVVM stands for Model View ViewModel.
 
 
 Option 1: Shapes must be able to create a path.
 This is the only requirement of the Shape protocol: to be able to create a path in a rectangle.

 Option 2: SwiftUI coordinator classes must always be nested inside a struct.
 They don't need to be nested, it's just nice to have.
 
 
 Option 1: SwiftUI's Color.red is not a pure red color.
 It's actually a custom color blend that looks better in light and dark mode.

 Option 2: A VStack can have an alignment or spacing, but not both.
 You can use either, both, or none depending on your needs.
 
 
 Option 1: We can attach onChanged() and onEnded() modifiers to a DragGesture.
 This lets us update our view state every time the user's finger moves, or when they end the gesture.

 Option 2: @EnvironmentObject only works with structs.
 @EnvironmentObject only works with classes.
 
 
 Option 1: We can create a List directly from an array.
 We can also create one directly from a range.

 Option 2: @NSManaged is a property wrapper.
 @NSManaged pre-dates property wrappers in Swift.
 
 
 Option 1: Apple recommends @State properties should use public access control.
 It's the opposite: Apple recommends they should use private access control.

 Option 2: To make a SwiftUI view wrap a UIKit view controller, we must make it conform to UIViewControllerRepresentable.
 UIViewControllerRepresentable already conforms to View.
 
 
 Option 1: Once a Timer has started, it can't be stopped.
 You can stop a timer whenever you want.

 Option 2: We can use the dynamicTypeSize() modifier to declare which Dynamic Type sizes a view supportsd.
 It's a good idea to support all of them, but it's also okay to add limits if you don't have a better option.
 
 
 Option 1: JSON stands for JavaScript Object Networking.
 JSON stands for JavaScript Object Notation.

 Option 2: EditButton will automatically switch between Edit and Done when tapped.
 It will also toggle editing mode on any lists that are loaded.
 
 
 Option 1: If we create an NSManagedObject subclass, make changes to it, then ask Xcode to create the subclass again, it will add our changes back to the class.
 Xcode will simply overwrite our modifications.

 Option 2: The Codable protocol is actually a combination of Encodable and Decodable.
 You can use these two protocols individually if you prefer.
 
 
 
 Option 1: If a VStack has a foreground color and some text inside also has a foreground color, the VStack's foreground color is used.
 Local modifiers always override environment modifiers from the parent.

 Option 2: Decorative images are images that are merely there to make the UI look nicer.
 These can mostly be ignored with VoiceOver.
 
 
 Option 1: When creating a custom alignment guide we must provide a default value.
 This will be used if we don't attach the alignmentGuide() modifier to a view.

 Option 2: Arrays cannot be used with @State.
 Arrays work perfectly fine with @State.
 
 
 
 Option 1: Ease in animations start slow and end fast.
 Ease out animations start fast and end slow.

 Option 2: SwiftUI's views cannot be created as @State properties.
 SwiftUI's views work great as @State properties.
 
 
 
 Option 1: Images from SF Symbols can be shown larger or small by using the font() modifier.
 SF Symbols automatically adapts to the text around it, so you can render them as large or small as you need.

 Option 2: Each modifier can be applied only once to a given view.
 You can apply one modifier multiple times to the same view if you want to.
 
 
 Option 1: We always need to bind text fields to strings.
 Although text fields use strings by default, we can also bind them to numbers.

 Option 2: SwiftUI can animate several properties changing at the same time.
 It will animate them all simultaneously.
 
 
 
 Option 1: The Identifiable protocol has no requirements.
 This protocol has only one requirement: a property called id that should be unique.

 Option 2: Creating a property using @Environment(\.horizontalSizeClass) will keep the value updated when the size class changes.
 This allows us to create a UI that updates itself as the size class changes.
 
 
 
 Option 1: The NavigationBar view lets us show new views and also place text at the top of the screen.
 This functionality is provided by NavigationView, not NavigationBar.

 Option 2: We can send nil to the animation() modifier.
 This disables animation.
 
 
 
 Option 1: QR codes are just barcodes with more colors.
 QR codes are quite different, but they also use two colors just like barcodes.

 Option 2: Using scaledToFill() with an image might mean parts of an image lie outside its container's frame.
 It does however mean that no part of the image view is empty.
 
 
 Option 1: The sequenced(before:) modifier lets us create chains of gestures.
 The first gesture must succeed in order for the second to be recognized.

 Option 2: @Binding cannot be used with a private property.
 @Binding works great with private properties.
 
 
 Option 1: SwiftUI allows us to group views into a single accessibility element.
 This lets us control the way those groups are read.

 Option 2: We can use @Environment only once per view.
 It's a regular property wrapper, so you can use it as many times as you need.
 
 
 Option 1: We can bind an alert() modifier to an optional value.
 We also need to provide a Boolean to determine when the alert is shown, but the optional does get unwrapped for us.

 Option 2: SF Symbols don't have any default accessibility labels.
 SF Symbols have their string name read by default
 
 
 
 
 Option 1: Swift's arrays use generics.
 This means we make arrays of strings or integers – we can't make an untyped array.

 Option 2: "Conic gradient" is another name for a radial gradient.
 Conic gradients are angular gradients, not radial gradients.
 
 
 Option 1: ImagePaint lets us tile an image as a fill or border.
 It has parameters that let us customize how much of the image is used and at what size.

 Option 2: The createCoordinate() modifier lets us create a custom coordinate space.
 You should use the coordinateSpace() modifier for this.
 
 
 
 Option 1: A view is always and exactly the same size as its body.
 When we apply size rules to a view, we are just applying those rules to whatever is in its body.

 Option 2: Child views must always use less than or equal to the amount of space the parent offers them.
 Child views are welcome to request more space than was proposed, and the parent must respect that.
 
 
 Option 1: Changing any @State property of a view causes SwiftUI to reinvoke the body property.
 This allows us to change what our views show over time.

 Option 2: Arrays cannot use the @Published property wrapper.
 Arrays certainly can use the @Published property wrapper.
 
 
 
 Option 1: contentShape() allows us to control the tap area for a view.
 This is particularly useful for stacks that have layout "holes".

 Option 2: We can show an alert by calling its show() method.
 We show alerts by making their isPresented condition true
 
 
 
 Option 1: Custom view modifiers must conform to the ViewModifier protocol.
 This has one requirement: a body() method that returns some View.

 Option 2: ForEach views can't loop over more than 10 items, because SwiftUI doesn't allow it.
 SwiftUI doesn't allow more than 10 hard-coded items inside a parent, but views created using ForEach don't count towards that limit.
 
 
 
 Option 1: If we place views inside a Group the parent view decides how those views should be laid out.
 This happens because Group is layout neutral.

 Option 2: We can have only one @Published property in a class.
 You can have as many @Published properties in a class as you need.
 
 
 
 Option 1: SwiftUI stores view positions and sizes as integers.
 Although SwiftUI rounds off its numbers when rendering, those numbers are stored as floating-point values for accuracy.

 Option 2: SwiftUI allows no more than 10 child views inside each parent.
 If you want to add more you should place your views inside groups.
 
 
 
 Option 1: View modifiers must return the same view struct they were given.
 View modifiers always return a new instance of a struct, and may create lots of new views if needed.

 Option 2: Context menus are triggered when users long press on a view.
 This used to be done using a hard press, but long press is the standard now.
 
 
 
 
 Option 1: A GeometryReader always takes up all available space in its parent.
 We can change the size just like any other view.

 Option 2: Coordinator classes help us respond to actions in a UIViewController.
 We can use them as delegates for those objects.
 
 
 
 Option 1: Before trying to stretch the contents of an image view, we should use aspectRatio(contentMode: .resize).
 The correct modifier is resizable().

 Option 2: We can align text in a HStack using the baseline of the first or last text views.
 This is important for creating visual alignment when working with different font sizes.
 
 
 
 Option 1: One environment object can be shared in up to two views.
 There is no limit to the number of views that can share a single environment object.

 Option 2: When a URLSession download completes, it will send back the downloaded data plus any additional metadata.
 These values are passed back in a tuple, and you can use _ to ignore either of them.
 
 
 
 Option 1: We can use a ForEach view inside a List.
 This lets us mix dynamic rows alongside static rows.

 Option 2: By default, SwiftUI uses a scale of 1 to 10 for the accessibility values of sliders.
 SwiftUI uses the slider's values by default.
 
 
 
 Option 1: Calling data(from:) on a URLSession must be done with await.
 Networking takes some time to complete, so you should never let it block your UI work.

 Option 2: Parent views can force a size on one of their chidren.
 Parents must always respect the size requested by their children.
 
 
 
 Option 1: Unless we ask for a custom alignment, most parents always place their child views in the top-left corner of their available space.
 Without further information, most parents place their child views in the center.

 Option 2: Text views automatically fit the size required to display all their lines.
 If you want them to be larger you should use padding or a custom frame
 
 
 Option 1: We can ask the user to enter multiple lines of text using TextEditor.
 If you only want a single line of text, use TextField instead.

 Option 2: If we want to modify a property, we need to use a SwiftUI property wrapper such as @Property.
 @Property is not a SwiftUI property wrapper; we should use @State instead.
 
 
 
 Option 1: We must always return some View from a SwiftUI view body.
 You can return an explicit type if you want, but it's not recommended.

 Option 2: We can call objectWillChange.send() to notify SwiftUI that an observable object is about to change.
 This allows us to add custom functionality to changes before triggering the notification.
 
 
 
 
 Option 1: We can't use onDelete(perform:) with views backed by Core Data objects.
 onDelete(perform:) doesn't care what data it works with, so it works fine with Core Data.

 Option 2: We can attach swipe actions to one or both sides of a list row.
 These are buttons, so we need to provide a label and an action.
 
 
 
 Option 1: The [C] modifier for NSPredicate marks the predicate as being case-sensitive.
 [C] makes an NSPredicate case-insensitive.

 Option 2: All SwiftUI views must have a body property.
 This body must always return precisely one view. That view might contain more views inside it, but you still need to return precisely one from the computed property.
 
 
 
 
 Option 1: Accessibility labels must always be a single hard-coded string.
 You can create them however you want, such as from JSON downloaded from the internet.

 Option 2: The InsettableShape protocol builds on the Shape protocol.
 This means we don't need to make our custom shapes conform to both.
 
 
 
 Option 1: iOS can take care of file encryption for using the .completeFileProtection option.
 This stops anyone from reading the file unless the device has been unlocked.

 Option 2: To read when return is pressed for a text view we should add an onReturnPressed() modifier.
 We should handle this using the onSubmit() modifier.
 
 
 
 Option 1: We can create a new task at any time using Task { … }.
 This is the best way to run an asynchronous function from a synchronous one, such as a button action.

 Option 2: SwiftUI has five built-in coordinate spaces.
 SwiftUI only has two built-in coordinate spaces: global and local.
 
 
 
 Option 1: NavigationView lets us push a new custom view, or a basic type such as Text.
 Pushing basic views is an easy way to prototype a layout.

 Option 2: SwiftUI's lists cannot work with computed properties.
 SwiftUI's lists work great with computed properties.
 
 
 Option 1: Buttons must be given a function or closure to be run when they are tapped.
 Without some sort of action to run, the button would be pointless. The only small exception here is the action for alert buttons, but even though it's empty you still need to provide it.

 Option 2: Fetch requests must be created using the @FetchRequest property wrapper.
 We can create fetch requests without the property wrapper using the FetchRequest struct.
 
 
 Option 1: Alerts are created with a title, but you can also add an extra message if you want one.
 The message part is provided using a second trailing closure.

 Option 2: Swift's Result type is designed for use with throwing functions.
 It can be used with throwing functions, but it doesn't need to be.
 
 
 
 Option 1: onDelete(perform:) cannot be attached directly to a List view.
 We must attach onDelete(perform:) to a ForEach view instead.

 Option 2: Timers automatically pause as soon as our app moves to the background.
 Timers will pause at some point, but it won't be immediately.
 
 
 Option 1: We can receive values from a Combine publisher using onReceive().
 This can be a Timer, a notification from Notification Center, or something else.

 Option 2: We can animate views, but we can't animate view overlays.
 You can animate view overlays just like views.
 
 
 
 Option 1: Stacks can have unlimited numbers of views inside them.
 Stacks are subject to the same 10-child limit as other SwiftUI views.

 Option 2: A GeometryReader is given one value inside its layout closure, which is a GeometryProxy containing layout information.
 We can use this to read our proposed size, our frame, and more.
 
 
 
 
 Option 1: Rotating then translating a transform gives the same result as translating then rotating.
 They give different results. Imagine walking forward 10 paces then turning right, compared to turning right then walking forward 10 paces.

 Option 2: If we want to animate a shape changing, we should add an animatableData property.
 What this does is down to us; SwiftUI just cares that it exists and is something that can be interpolated smoothly.
 
 
 
 Option 1: The clipped() modifier lets us specify a shape for a view should to be drawn inside.
 You should use the clipShape() modifier for this purpose.

 Option 2: Swift's Result type can contain either success or failure, but not both.
 This lets us reduce complexity in our code by eliminating impossible program states.
 
 
 
 
 Option 1: Asymmetric transitions let us combine transitions with explicit animations.
 Asymmetric transitions let us specify one transition for insertion and another for removal.

 Option 2: If we want to programmatically set the active tab for a TabView, we must set a tag on the views inside it.
 The tag can be anything that conforms to the Hashable protocol, such as an integer or a string.
 
 
 
 
 Option 1: To enable swipe to delete for list rows, we should add an onSwipeToDelete() modifier.
 This modifier does not exist.

 Option 2: To remove the label from a date picker, we should use labelsHidden().
 This is much better than using an empty label, which causes problems for screen readers.
 
 
 
 Option 1: Using withAnimation() always uses a spring animation.
 You can specify exactly which animation to use.

 Option 2: We can pass data to views inside their initializer.
 This means we can be sure all data exists by the time the view's body is loaded.
 
 
 
 Option 1: Classes that are used with @ObservableObject must conform to the ObservedObject protocol.
 @ObservedObject is the property wrapper, and ObservableObject is the protocol.

 Option 2: Asynchronous functions are able to sleep while their work completes.
 This allows our app to perform other work at the same time.
 
 
 
 
 Option 1: Swift has a built-in type for handling dates.
 It's called Date and stores year, month, day, hour, minute, second, and more.

 Option 2: It's a good idea to use drawingGroup() for all your drawing.
 You should only use drawingGroup() when you really need it.
 
 
 
 Option 1: SwiftUI's buttons require a function that accepts the button that got tapped as its only parameter.
 Buttons require a function that accepts no parameters and returns nothing.

 Option 2: @Binding lets us share one value in two places.
 It's mainly used for creating custom UI components.
 
 
 
 Option 1: We can check whether one or both of a Boolean is true using OR, for example booleanA OR booleanB
 We need to use the || operator for this purpose.

 Option 2: Writing data atomically means that iOS writes to a temporary file then performs a rename.
 This stops another piece of code from reading the file part-way through a write.
 
 
 
 Option 1: We should mark all our properties as @ViewBuilder.
 This attribute is useful in a handful of places, but you shouldn't use it a lot and certainly not for all properties.

 Option 2: We can add a search bar to any view using searchable().
 Bind its text to a property and you can automatically reload your view as the user's search changes.
 
 
 
 
 Option 1: In Core Data, Integer 16 is designed to hold 16 different numbers.
 Integer 16 holds one 16-bit number.

 Option 2: When creating a text field we need to provide some placeholder text.
 This helps users see what should be entered, and is also useful to screen readers.
 
 
 
 
 Option 1: The order in which we apply modifiers affects the result we get.
 For example, setting the frame then applying a background color is different from applying a background color then setting the frame.

 Option 2: sheet() requires a NavigationView to work.
 Sheets are presented above the current screen, and so don't require a navigation view.
 
 
 
 Option 1: Gradients must never be used outside the safe area.
 You can place them anywhere you like, including outside the safe area.

 Option 2: We can ask the user to select a photo from their library using PHPickerViewController.
 They can browse for whatever picture they want, or press Cancel.
 
 
 
 Option 1: The @Binding property wrapper creates a Binding struct.
 This is all that property wrappers do behind the scenes.

 Option 2: SwiftUI coordinators cannot act as delegates for another class.
 SwiftUI coordinators are specifically designed to act as delegates for another class
 
 
 
 Option 1: Alerts and confirmation dialogs look the same on iPhone.
 Alerts appear in the center of the screen, whereas confirmation dialogs slide up from the bottom.

 Option 2: Breaking SwiftUI views into smaller views has little to no performance impact.
 SwiftUI does an excellent job of optimizing this behavior.
 
 
 
 Option 1: When creating views in a loop, SwiftUI needs to know how to identify each view uniquely.
 This lets it understand which views were added or removed.

 Option 2: Decoding data from JSON will always succeed.
 Decoding data from JSON might fail, for example if the JSON was invalid or contained the wrong type of data.
 
 
 Option 1: The @Published property wrapper places our properties inside a Published struct.
 Behind the scenes, this is actually similar to how optionals work.

 Option 2: An @ObservedObject struct will notify all views that use it when one of its @Published properties change.
 Structs cannot be used with @ObservedObject.
 
 
 Option 1: We can detect when a sheet is closed by setting its onClose parameter.
 We should use onDismiss for this purpose.

 Option 2: We can embed a HStack inside a VStack.
 This lets us make grid structures fairly easily.
 
 
 
 Option 1: %@ in an NSPredicate is dynamically replaced with a sort order.
 %@ is dynamically replaced with some sort of value in quote marks; sorting is controlled through SortDescriptor.

 Option 2: The offset() modifier changes where a view is rendered without actually changing its original dimensions.
 This subsequent modifiers will use the view's original dimensions.
 
 
 
 Option 1: We can let users delete items from a List by adding the onDelete() modifier to it.
 The onDelete() modifier exists only on ForEach.

 Option 2: If we write Text("Hello, World!").background(.red), the text view is a child of the background.
 The background view becomes the outermost view, with our text inside.
 
 
 
 Option 1: @EnvironmentObject properties must conform to ObservableObject.
 They use exactly the same protocol, which means @Published and more works.

 Option 2: The disabled() modifier can read any kind of property, but must not be used with methods.
 You can use a method if you want, as long as it returns a Boolean.
 
 
 Option 1: By default, a NavigationView doesn't work in landscape.
 NavigationView works fine in landscape, but you should remember to provide a second view to use as the default detail view.

 Option 2: Classes that are used with @StateObject must conform to the ObservableObject protocol.
 @ObservedObject is a property wrapper, and ObservableObject is the protocol.
 
 
 
 Option 1: Views with an onTapGesture() modifier automatically have the isButton trait.
 You need to add this trait by hand.

 Option 2: It's possible to mix static and dynamic rows in a List.
 You can have static rows then dynamic, then more static, then more dynamic, and so on.
 
 
 
 
 Option 1: All paths are also shapes.
 Paths are not shapes; they are different things.

 Option 2: GeometryReader lets us read the size of a view's container.
 This is helpful for making sure images are created at the right size.
 
 
 
 Option 1: We can detect when an @State property changes using a property observer.
 This doesn't always work; we need to use the onChange() modifier instead.

 Option 2: GeometryReader tells us the size that was proposed by our parent.
 This lets us create relative layouts easily.
 
 
 
 Option 1: Semantic colors are colors that are named according to their use rather than according to their hue.
 For example, Color.primary might be light or dark depending on the device theme.

 Option 2: SwiftUI view previews shouldn't have properties of their own.
 SwiftUI view previews can have as many properties as they need to work.
 
 
 
 
 Option 1: AnimatablePair lets us animate any two kinds of data.
 AnimatablePair can only animate values that are animatable, which excludes integers.

 Option 2: ForEach views let us loop over ranges and arrays.
 They are used to create many instances of something very quickly.
 
 
 
 Option 1: If we use .accessibilityElement(children: .ignore) the entire view becomes invisible to VoiceOver.
 The things inside the view aren't accessible individually, but the parent view is.

 Option 2: When we import a Core ML model into Xcode, it will automatically generate a Swift class for us to use.
 This lets us create an instance of the model and request a prediction in only two lines of code.
 
 
 
 Option 1: We can draw borders with a custom shape by using the overlay() modifier.
 We can apply separate modifiers to that overlay, such as a border.

 Option 2: We can control the visual appearance of a list using the listViewStyle() modifier.
 The modifier is listStyle().
 
 
 
 op1. the disable if is false then no response to user.
 
 op2 Colors are views in swiftui
 
 
 
 Option 1: The @Published property wrapper watches an observed object for changes.
 @Published announces changes from a property; @ObservedObject watches an observed object for changes.

 Option 2: A coordinator class lets us handle communication back from a UIKit view controller.
 Coordinators act as bridges between SwiftUI's views and UIKit's view controllers.
 
 
 
 Option 1: When allowsHitTesting() is false, a view cannot be tapped.
 Any taps simply pass through to whatever is stacked below.

 Option 2: SwiftUI disables image interpolation by default.
 SwiftUI enables high-quality interpolation by default.
 
 
 
 
 
 Option 1: Using a value of 100 with the scaleEffect() modifier makes a view its natural size.
 That will make the view 100x its natural size.

 Option 2: We can attach an animation() modifier to a binding.
 This causes changes in the binding to trigger an animation. Remember to add the value parameter so SwiftUI knows which value to watch for changes!
 
 
 
 
 Option 1: If all the properties of a type conform to the Hashable protocol, the type itself can also conform just by adding Hashable to its list of conformances.
 This works just the same as Codable.

 Option 2: When creating a custom alignment guide, it's recommended to use structs rather than enums.
 The opposite is true: it's a good idea to use enums.
 
 
 
 
 Option 1: The @MainActor attribute should be used on all classes.
 Classes that conform to the ObservableObject protocol should have this attribute, but it's not required on all classes.

 Option 2: Segmented controls are created using picker views in SwiftUI.
 Pickers adopt segmented styling when we apply the .pickerStyle(.segmented) modifier on them.
 
 
 
 Option 1: Asynchronous function calls will always sleep for some amount of time.
 An asynchronous function might sleep, but doesn't need to.

 Option 2: Images built from SF Symbols icons have a customizable foreground color.
 This lets us display the icons in whatever color we want.
 
 
 
 rotation3DEffect() can rotate around more than one axis
 
 
 
 
 Option 1: Every VStack must include one Spacer view.
 Spacers aren't required, and are often not needed at all.

 Option 2: Trailing toolbar buttons appear on the right in left-to-right languages.
 This is automatically flipped for right-to-left languages.
 
 
 
 Option 1: We can pop a view from a NavigationView using the same dismiss action we use for sheets.
 Popping a view is the equivalent of tapping Back or swiping from the left edge.

 Option 2: Using the multiply blend mode usually results in a lighter image.
 Using multiply nearly always results in a darker image, and at its brightest it still cannot produce images that are lighter than the original.
 
 
 
 
 Option 1: The destination of a NavigationLink is always shown in the current view.
 If we have two views in a navigation view, NavigationLink presents destinations in the secondary view.

 Option 2: SwiftUI's previews aren't included in our app if we send it to the App Store.
 Swift automatically strips out the previews; they are just there to help us design our UI.
 
 
 
 Option 1: NavigationLink requires a NavigationView to work.
 Without a navigation view around it, navigation links have no way of pushing new views onto the screen.

 Option 2: Color is both a view and a shape.
 Color is a view, but not a shape.
 
 
 
 
 
 Option 1: The blur() modifier applies a Gaussian blur to a view, using a radius we specify.
 This is all done on the GPU, so it's really fast.

 Option 2: We can use implicit animation or explicit animation, but not both.
 You can mix and match however much you want.
 
 */
