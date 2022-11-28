//
//  SwiftCrud_LuisDonoApp.swift
//  SwiftCrud_LuisDono
//
//  Created by CCDM16 on 17/11/22.
//

import SwiftUI

@main
struct SwiftCrudApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}

