//
//  Gymer.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 17/01/2023.
//

import Foundation
import SwiftUI
import UIKit

struct Gymer: Codable, Identifiable, Equatable, Comparable {
    var id: UUID
    var name: String
    var avatar: Data
    
    init(name: String, avatar: Data) {
        self.id = UUID()
        self.name = name
        self.avatar = avatar
    }
    
    //convert UIImage to image
    func convertUIimage_to_Image() -> Image {
        let uiImageData = avatar
        if let uiImage = UIImage(data: uiImageData) {
            return Image(uiImage: uiImage)
        }
        
        return Image(systemName: "questionmark.square.dashed")
    }
    
    //you need to convert your UIImage to Data by calling its jpegData() method like this:
    static let exampleAvatarData = UIImage(named: "Steve_Jobs")!.jpegData(compressionQuality: 0.8)
    static let example = Gymer(name: "Steve Jobs", avatar: exampleAvatarData!)
    
    //Sorting the array by name
    static func <(lhs: Gymer, rhs: Gymer) -> Bool { lhs.name < rhs.name }
}
//The compressionQuality parameter can be any value between 0 (very low quality) and 1 (maximum quality); something like 0.8 gives a good trade off between size and quality.
