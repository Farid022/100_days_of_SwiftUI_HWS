//
//  ImagePicker.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 05/01/2023.
//

import PhotosUI
import SwiftUI
//explaination.
/*
 1. UIView, which is the parent class of all views in the layouts. So, labels, buttons, text fields, sliders, and so on – those are all views.
 2. UIKit has a class called UIViewController, which is designed to hold all the code to bring views to life. Just like UIView, UIViewController has many subclasses that do different kinds of work.
 3. UIKit uses a design pattern called delegation to decide where work happens. So, when it came to deciding how to respond to a text field changing, we’d create a custom class with our functionality and make that the delegate of our text field.
 
 1. All this matters because asking the user to select a photo from their library uses a view controller called PHPickerViewController, and the delegate protocol PHPickerViewControllerDelegate.
 2. Conforming to UIViewControllerRepresentable does require us to fill in that struct with two methods: one called makeUIViewController(), which is responsible for creating the initial view controller, and another called updateUIViewController(), which is designed to let us update the view controller when some SwiftUI state changes.
 
Problem. We can not select nor the cancel button dissmiss the sheet, so swiftUI uses coordinators to handle these kind of problems. in swiftui, coordinators act like delegates -> Remember, “delegates” are objects that respond to events that occur elsewhere. For example, UIKit lets us attach a delegate object to its text field view, and that delegate will be notified when the user types anything, when they press return, and so on. So, to demonstrate this we’re going to upgrade our ImagePicker view so that it can report back when the user selects an image or presses Cancel.
 

 */
//Pop up a sheet and show the phots, enable selecetion, handle cancel etc.
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        /*
         That does three things:

         It makes the class inherit from NSObject, which is the parent class for almost everything in UIKit. NSObject allows Objective-C to ask the object what functionality it supports at runtime, which means the photo picker can say things like “hey, the user selected an image, what do you want to do?”
         It makes the class conform to the PHPickerViewControllerDelegate protocol, which is what adds functionality for detecting when the user selects an image. (NSObject lets Objective-C check for the functionality; this protocol is what actually provides it.)
         It stops our code from compiling, because we’ve said that class conforms to PHPickerViewControllerDelegate but we haven’t implemented the one method required by that protocol.
         */
        
        //Rather than just pass the data down one level, a better idea is to tell the coordinator what its parent is, so it can modify values there directly. That means adding an ImagePicker property and associated initializer to the Coordinator class, like this:
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            /*
             It’s our job to do three things:

             1.Tell the picker to dismiss itself.
             2.Exit if the user made no selection – if they tapped Cancel.
             3.therwise, see if the user’s results includes a UIImage we can actually load, and if so place it into the parent.image property.
             */
            // Tell the picker to go away
            picker.dismiss(animated: true)

            // Exit if no selection was made
            guard let provider = results.first?.itemProvider else { return }

            // If this has an image we can use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration() // what kind of things you want to work with.
        config.filter = .images //what kind, videos, images, yes only pics.
        
        let picker = PHPickerViewController(configuration: config) //put in the viewController.
        picker.delegate = context.coordinator //tell the PHPickerViewController that when something happens it should tell our coordinator.
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

//sum up the complete process:
//We created a SwiftUI view that conforms to UIViewControllerRepresentable.
//We gave it a makeUIViewController() method that created some sort of UIViewController, which in our example was a PHPickerViewController.
//We added a nested Coordinator class to act as a bridge between the UIKit view controller and our SwiftUI view.
//We gave that coordinator a didFinishPicking method, which will be triggered by iOS when an image was selected.
//Finally, we gave our ImagePicker an @Binding property so that it can send changes back to a parent view.
//For what it’s worth, after you’ve used coordinators once, the second and subsequent times are easier, but I wouldn’t blame you if you found the whole system quite baffling for now.
//
//Don’t worry too much – we’ll be coming back to this again soon, so you’ll have more than enough time to practice. It also means you shouldn’t delete your ImagePicker.swift file, because that’s another useful component you’ll use in this project and in others you make.

//Save images to photo library.
class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhoto_Album(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}

/*
 1.Mark the method using a special compiler directive called #selector, which asks Swift to make sure the method name exists where we say it does.
 2. Add an attribute called @objc to the method, which tells Swift to generate code that can be read by Objective-C.
 */

//We can ask the user to select a photo from their library using PHPickerViewController.
//Coordinators act as bridges between SwiftUI's views and UIKit's view controllers.
// Core Image lets us apply graphical filters to an image.
