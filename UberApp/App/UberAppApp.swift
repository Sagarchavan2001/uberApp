//
//  UberAppApp.swift
//  UberApp
//
//  Created by STC on 22/12/24.
//

import SwiftUI

@main
struct UberAppApp: App {
    @StateObject var locationViewModel = LocationSearchVM()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
