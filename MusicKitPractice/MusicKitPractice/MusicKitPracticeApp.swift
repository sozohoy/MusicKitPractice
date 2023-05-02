//
//  MusicKitPracticeApp.swift
//  MusicKitPractice
//
//  Created by 한지석 on 2023/04/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct MusicKitPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: SearchMusic1.State(), reducer: SearchMusic1()))
        }
    }
}
