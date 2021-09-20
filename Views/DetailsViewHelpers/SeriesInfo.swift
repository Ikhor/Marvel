//
//  SeriesInfo.swift
//  MarvelApp
//
//  Created by Luiz Felipe on 11/09/21.
//

import Foundation
import SwiftUI

struct SeriesInfo: View {
    var character: Results

    var body: some View {

        if let seriesItem = character.series, let series = seriesItem.items {

            HStack() {
                Text("Series:")
                Spacer()
            }

            Spacer()

            VStack(spacing: 3) {
                ForEach(0..<series.count) { index in
                    Text(series[index].name)
                }
            }.font(.caption)
            .foregroundColor(.gray)
            .padding(.vertical, 10)
        }
    }
}
