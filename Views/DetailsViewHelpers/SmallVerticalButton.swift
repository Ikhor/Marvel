//
//  HomeView.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 07/09/21.
//

import SwiftUI

struct SmallVerticalButton: View {
    var text: String

    var isOnImage: String
    var isOffImage: String

    var isOn: Bool

    var imageName: String {
        if isOn {
            return isOnImage
        }
        else{
            return isOffImage
        }
    }

    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
            VStack{
                Image(systemName: imageName)
                    .foregroundColor(.black)

                Text(text)
                    .foregroundColor(.black)
                    .font(.system(size: 12))
                    .bold()
            }
        })
    }
}

struct SmallVerticalButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            SmallVerticalButton(text: "My List",
                                isOnImage: "checkmark",
                                isOffImage: "plus",
                                isOn: true) {
                print("Tapped")
            }
        }

    }
}
