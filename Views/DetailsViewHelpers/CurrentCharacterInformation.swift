//
//  CurrentCharacterInformation.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 11/09/21.
//

import Foundation
import SwiftUI

struct CurrentCharacterInformation: View {
    var character: Results

    var body: some View {
        
        Group{
            HStack {
                Spacer()
                Text(character.name)
                    .bold()
                
                Spacer()
            }
            HStack {
                Text(character.resultDescription)
                    .font(.subheadline)

                Spacer()
            }
        }
    }
}
