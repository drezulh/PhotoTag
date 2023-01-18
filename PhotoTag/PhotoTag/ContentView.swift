//
//  ContentView.swift
//  PhotoTag
//
//  Created by Gorkem Turan on 15.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @State private var showingAddPersons = false
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    ForEach(0 ..< viewModel.persons.count, id:\.self) { number in
                        NavigationLink {
                            DetailView(people: viewModel.persons, index: number)
                        } label: {
                            VStack {
                                Text(viewModel.persons[number].name)

                            }
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.removePerson(at: indexSet)
                    }
                }
            }
            .navigationBarTitle("PhotoTag")
            .navigationBarItems(trailing: Button(action: {
                viewModel.addPerson()
                self.showingAddPersons = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(item: $viewModel.selectedPerson) { person in
                AddPersonView(person: person) {
                    viewModel.update(person: $0)
                }
            }
        }
    }
}

    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
