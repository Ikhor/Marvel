//
//  ContentView.swift
//  Marvel
//
//  Created by Luiz Felipe on 19/09/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @StateObject var homeView = HomeViewModel()

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            NavigationView {
                CharacterView()
                   .environmentObject(homeView)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Personagens")
            }

            NavigationView {
                List {
                    if let characters = homeView.fetchedFavoriteCharacter {
                        if characters.isEmpty {
                            Text("Nenhum personagem marcado como favorito")
                        }
                        else {
                            ForEach(0..<characters.count, id: \.self) { index in
                                FavoriteView(character: characters[index])
                                    .environmentObject(homeView)
                            }
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favoritos")
            }
        }
        .edgesIgnoringSafeArea(.all)

        if homeView.characterDetailToShow != nil {
            CharacterDetailView(character: homeView.characterDetailToShow!)
                .animation(.easeIn)
                .transition(.opacity)
                .environmentObject(homeView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
