//
//  AddPersonView-ViewModel.swift
//  PhotoTag
//
//  Created by Gorkem Turan on 15.01.2023.
//

import Foundation
import PhotosUI
import SwiftUI

extension AddPersonView {
    @MainActor
    class AddPersonViewModel : ObservableObject {
        @Published var person: Person
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var showingImagePicker = false
        @Published var name = ""
        @Published var jpegData : Data
        
        @Published var loadingState = LoadingState.loading
        enum LoadingState {
            case loading, loaded, failed
        }
        
        init(person: Person) {
            self.person = person
            
            _name = Published(initialValue: person.name)
            _jpegData = Published(initialValue: person.jpegData)
        }
        
        func savePersonInfo() -> Person {
            
            var newPerson = person
            newPerson.id = UUID()
            newPerson.name = name
            newPerson.jpegData = jpegData
            
            return newPerson
        }
        func loadImage() {
            guard let inputImage = inputImage else {
                loadingState = .failed
                return
            }
            jpegData = inputImage.jpegData(compressionQuality: 0.8)!
            image = Image(uiImage: inputImage)
            loadingState = .loaded
        }
        
        
    }
    
    
}
