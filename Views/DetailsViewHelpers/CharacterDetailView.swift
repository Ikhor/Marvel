//
//  GlobalMockers.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 07/09/21.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {

    var character: Results

    let screen = UIScreen.main.bounds

    @EnvironmentObject var homeView: HomeViewModel

    var body: some View {
        VStack {
            HStack {
                Spacer()

                Button(action: {
                    homeView.characterDetailToShow = nil
                }, label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 28))
                })
            }.padding(.horizontal, 22)

            ScrollView(.vertical, showsIndicators: false) {
                VStack {

                    KFImage(character.thumbnailURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: screen.width / 2.5)

                    HStack(spacing: 60) {
                        let favorite = homeView.isFavorite(character: character)
                        SmallVerticalButton(text: "Favoritos", isOnImage: "star", isOffImage: "plus", isOn: favorite) {
                            print("Adding to favorites...")
                            if favorite {
                                homeView.deleteFavorite(character: character)
                            }
                            else {
                                homeView.addFavorite(character: character)
                            }
                        }
                    }
                    .padding(.horizontal, 20)

                    CurrentCharacterInformation(character: character)

                    Spacer()

                    ComicsInfo(character: character)

                    Spacer()

                    SeriesInfo(character: character)

                    Spacer()

                    StoriesInfo(character: character)
                }
                .padding(.horizontal, 10)
            }
            Spacer()
        }.foregroundColor(.black)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            CharacterDetailView(character: exampleCharacter1)
        }
    }
}


