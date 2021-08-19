//
//  QRAppApp.swift
//  QRApp
//
//  Created by than.duc.huy on 19/08/2021.
//

import SwiftUI

@main
struct QRAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
