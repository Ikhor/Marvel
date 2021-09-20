//
//  CharacterView.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 07/09/21.
//

import SwiftUI
import Kingfisher

struct CharacterView: View {
    
    @EnvironmentObject var homeView: HomeViewModel

    var body: some View {

        ScrollView(.vertical, showsIndicators: false,
                   content: {
                    // Search bar
                    VStack() {
                        HStack(){
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)

                            TextField("Procurar personagem", text: $homeView.searchQuery)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .disableAutocorrection(true)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(Color.white)
                        .shadow(color: .black.opacity(0.06), radius: 5, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.06), radius: 5, x: -5, y: -5)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)

                    if let characters = homeView.fetchedCharacter {
                        if characters.isEmpty {
                            // Loading Screen
                            ProgressView()
                                .padding(.top, 20)

                            Spacer()

                            Text("Nenhum personagem encontrado")
                        }
                        else {
                            // Display results
                            VStack (spacing: 15) {

                                ForEach(0..<characters.count, id: \.self) { index in
                                    CharacterRowView(character: characters[index])
                                }

                                // Infinity Scroll
                                if homeView.offset == characters.count {
                                    ProgressView()
                                        .padding(.vertical)
                                        .onAppear(perform: {
                                            print("Fetching")
                                            if homeView.searchQuery == "" {
                                                homeView.searchCharactersAPIList()
                                            }
                                            else {
                                                homeView.searchCharactersAPI()
                                            }
                                        })
                                }
                                else {
                                    GeometryReader{ reader -> Color in
                                        let minY = reader.frame(in: .global).minY
                                        let height = UIScreen.main.bounds.height / 1.3

                                        if !characters.isEmpty && minY < height {
                                            DispatchQueue.main.async {
                                                homeView.offset = characters.count
                                            }
                                        }
                                        return Color.clear
                                    }
                                    .frame(width: 20, height: 20)
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    else {
                        if homeView.searchQuery != "" {
                            // Loading Screen
                            ProgressView()
                                .padding(.top, 20)
                        }
                    }
                   })
    }
}
