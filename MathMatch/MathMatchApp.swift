//
//  MathMatchApp.swift
//  MathMatch
//
//  Created by Gunes Akgun on 26.09.2024.
//

import SwiftUI
import SwiftData

@main
struct MathMatchApp: App {
    
    @StateObject var gameManager = GameManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Score.self,
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
            TitleScreen()
                .environmentObject(gameManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
