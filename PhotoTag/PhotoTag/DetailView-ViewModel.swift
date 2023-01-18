//
//  DetailView-ViewModel.swift
//  PhotoTag
//
//  Created by Gorkem Turan on 16.01.2023.
//

import Foundation
import PhotosUI
import SwiftUI

extension DetailView {
    @MainActor class DetailViewModel: ObservableObject {
        
        @Published var people : [Person]
        
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var index: Int
        
        init(people: [Person], index: Int) {
            self.people = people
            self.index = index
        }
     
        func loadImage() {
            if let inputImage = UIImage(data: people[index].jpegData) {
                image = Image(uiImage: inputImage)
            }
        }
        func nextPerson() {
            if index < people.count {
                index = index + 1
            }
        }
        func prevPerson() {
            if index > 0 {
                index = index - 1
            }
        }
        
    }
    
}
