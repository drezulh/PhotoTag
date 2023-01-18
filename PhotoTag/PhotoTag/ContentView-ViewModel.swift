//
//  ContentView-ViewModel.swift
//  PhotoTag
//
//  Created by Gorkem Turan on 15.01.2023.
//

import Foundation
import PhotosUI
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var persons: [Person]
        @Published var sortedPeople = [Person]()

        @Published var image: Image?
        @Published var showingImagePicker = false
        @Published var selectedName = ""
        @Published var selectedImage : UIImage?
        @Published var selectedPerson : Person?
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPersons")
        
        init() {
            
            do {
                let data = try Data(contentsOf: savePath)
                persons = try JSONDecoder().decode([Person].self, from: data)
                persons = persons.sorted()
            } catch {
                persons = []
            }
        }
        func addPerson() {
            let newPerson = Person(jpegData: Data(), name: "")
            selectedPerson = newPerson
            persons.append(newPerson)
            save()
        }
        
        func save() {
            do {
                persons = persons.sorted()
                let data = try JSONEncoder().encode(persons)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func update(person: Person) {
            guard let selectedPerson = selectedPerson else { return }

            if let index = persons.firstIndex(of: selectedPerson) {
                persons[index] = person
                save()
            }
        }
        
        func removePerson(at offsets: IndexSet) {
                print(offsets)
                persons.remove(atOffsets: offsets)
                save()
        }
    }
}
