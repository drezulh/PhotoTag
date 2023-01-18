//
//  DetailView.swift
//  PhotoTag
//
//  Created by Gorkem Turan on 15.01.2023.
//

import SwiftUI

struct DetailView: View {


    let people : [Person]
    let index : Int
    @StateObject private var detailViewModel : DetailViewModel
    
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Photo of \(detailViewModel.people[index].name)")
                    .font(.title)
                    .foregroundColor(.red)
                if detailViewModel.image != nil {
                    detailViewModel.image?
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                } else {
                    Text("Image not found")
                }
                Spacer()
            }
            .onAppear {
                detailViewModel.loadImage()
            }
                .navigationBarItems(trailing: Button(action: {
                    detailViewModel.nextPerson()
                    detailViewModel.loadImage()
                }, label: { Text("Next Person")
                        .disabled(detailViewModel.index == detailViewModel.people.count-1)
                }))
                .navigationBarItems(leading: Button(action: {
                    detailViewModel.prevPerson()
                    detailViewModel.loadImage()
                }, label: { Text("Previous Person")
                        .disabled(detailViewModel.index == 0)
                }))
        }
        
    }
    init(people: [Person], index: Int) {
        self.people = people
        self.index = index
        _detailViewModel = StateObject(wrappedValue: DetailViewModel(people: people, index: index))
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
