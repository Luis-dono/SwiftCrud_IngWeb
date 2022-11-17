//
//  SwiftCrud_LuisDonoApp.swift
//  SwiftCrud_LuisDono
//
//  Created by CCDM16 on 17/11/22.
//

import SwiftUI

@main
struct SwiftCrud_LuisDonoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
