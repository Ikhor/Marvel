//
//  StoriesInfo.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 11/09/21.
//

import Foundation
import SwiftUI

struct StoriesInfo: View {
    var character: Results

    var body: some View {

        if let storiesItem = character.stories, let stories = storiesItem.items {

            HStack() {
                Text("Stories:")
                Spacer()
            }

            Spacer()

            VStack(spacing: 3) {
                ForEach(0..<stories.count) { index in
                    Text(stories[index].name )
                }
            }.font(.caption)
            .foregroundColor(.gray)
            .padding(.vertical, 10)
        }
    }
}
