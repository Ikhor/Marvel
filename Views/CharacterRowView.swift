//
//  CharacterRowView.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 11/09/21.
//

import Foundation
import SwiftUI
import Kingfisher

struct CharacterRowView: View {

    var character: Results

    @EnvironmentObject var homeView: HomeViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            KFImage(character.thumbnailURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 150)
                .padding(.horizontal, 10)

            VStack (alignment: .leading, spacing: 8) {
                Text(character.name)
                    .bold()
                    .font(.title3)
                    .foregroundColor(.black)

                Text(character.resultDescription)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(4)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)

                HStack () {
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
                    SmallVerticalButton(text: "Detalhes",
                                        isOnImage: "info.circle",
                                        isOffImage: "info.circle",
                                        isOn: false) {
                        homeView.characterDetailToShow = character
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            CharacterRowView(character: exampleCharacter1)
        }
        .padding(.horizontal)
    }
}
