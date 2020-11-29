//
//  GameCenter2App.swift
//  GameCenter2
//
//  Created by rifat khadafy on 16/11/20.
//

import SwiftUI

@main
struct GameCenter2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
