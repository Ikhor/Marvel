//
//  ComicsInfo.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 11/09/21.
//

import Foundation
import SwiftUI

struct ComicsInfo: View {
    var character: Results

    var body: some View {

        if let comicItem = character.comics, let comics = comicItem.items {

            HStack() {
                Text("Quadrinhos:")
                Spacer()
            }

            Spacer()

            VStack(spacing: 3) {
                ForEach(0..<comics.count) { index in
                    Text(comics[index].name)
                }

            }.font(.caption)
            .foregroundColor(.gray)
            .padding(.vertical, 10)
        }
    }
}

