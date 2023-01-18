//
//  AddPersonView.swift
//  PhotoTag
//
//  Created by Gorkem Turan on 15.01.2023.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss

    var onSave: (Person) -> Void

    
    @StateObject private var addPersonViewModel : AddPersonViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name Field", text: $addPersonViewModel.name)
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.orange, lineWidth: 3))
                    .multilineTextAlignment(.center)
                Section {
                    switch addPersonViewModel.loadingState {
                    case .loaded:
                        addPersonViewModel.image?
                            .resizable()
                            .scaledToFit()
                    case .loading:
                        ZStack {
                            Rectangle()
                                .fill(.secondary)
                            
                            Text("Tap to add photo")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    case .failed:
                        ZStack {
                            Rectangle()
                                .fill(.secondary)
                            
                            Text("Failed to load photo. Try to add different photo")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                }
                .onTapGesture {
                    addPersonViewModel.showingImagePicker = true
                }
                
                
            }
            .padding([.horizontal, .bottom])
            .sheet(isPresented: $addPersonViewModel.showingImagePicker) {
                ImagePicker(image: $addPersonViewModel.inputImage)
            }
            .onChange (of: addPersonViewModel.inputImage, perform: { _ in addPersonViewModel.loadImage() })
//            .onChange(of: addPersonViewModel.inputImage, perform: { _ in
//              Task {
//              await addPersonViewModel.loadImage()
//              }
//              })
//            .task(id:addPersonViewModel.inputImage){
//             await addPersonViewModel.loadImage() }
            .toolbar {
                Button("Save") {
                    let newPerson = addPersonViewModel.savePersonInfo()
                    onSave(newPerson)
                    dismiss()
                }
                .disabled(addPersonViewModel.inputImage == nil || addPersonViewModel.name == "")
            }
        }
    }
    init(person: Person, onSave: @escaping (Person) -> Void) {
        _addPersonViewModel = StateObject(wrappedValue: AddPersonViewModel(person: person))
        self.onSave = onSave
    }

}

//struct AddPersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPersonView(image: nil)
//    }
//}
