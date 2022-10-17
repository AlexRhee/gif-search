//
//  gif_searchApp.swift
//  gif-search
//
//  Created by Lana Nguyen on 10/17/22.
//

import SwiftUI

@main
struct gif_searchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
