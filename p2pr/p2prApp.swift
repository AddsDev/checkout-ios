//
//  p2prApp.swift
//  p2pr
//
//  Created by Adrian Ruiz on 28/09/23.
//

import SwiftUI
import SwiftData

@main
struct p2prApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            History.self,
            WelcomePackage.self,
            Buyer.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
        .modelContainer(sharedModelContainer)
    }
}
