//
//  MarvelApp.swift
//  Marvel
//
//  Created by Luiz Felipe on 19/09/21.
//

import SwiftUI

@main
struct MarvelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
