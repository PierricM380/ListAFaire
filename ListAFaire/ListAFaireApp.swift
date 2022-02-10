//
//  ListAFaireApp.swift
//  ListAFaire
//
//  Created by Pierric Marye on 19/12/2021.
//

import SwiftUI

@main
struct ListAFaireApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
