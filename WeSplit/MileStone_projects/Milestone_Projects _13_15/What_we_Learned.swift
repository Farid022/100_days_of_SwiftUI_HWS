//
//  Milestone_Projects _13_15.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 17/01/2023.
//

import Foundation
//What i have learned in this:
/*
 How property wrappers become structs.
 Presenting confirmation dialogs with lots of buttons.
 Using Core Image to manipulate images.
 Integrating PHPickerViewController into SwiftUI.
 Writing coordinator classes that can act as delegates for image pickers.
 Integrating maps into SwiftUI.
 Dropping pins on maps.
 Saving images to the user’s photo library.
 Adding Comparable conformance to custom types.
 Finding and writing to the user’s documents directory.
 Enabling file encryption when writing.
 Authenticating users with Touch ID and Face ID.
 */


//Swift puts all integer types into a single protocol called BinaryInteger, and if we write an extension on that then Self (with a capital S) refers to whatever specific type is being used. So, if it’s used on an Int then Self means Int, and if it’s used on an Int16 then it means that instead.
extension BinaryInteger {
    static func *(lhs: Self, rhs: Double) -> Double {
        return Double(lhs) * rhs
    }

    static func *(lhs: Double, rhs: Self) -> Double {
        return lhs * Double(rhs)
    }
}
