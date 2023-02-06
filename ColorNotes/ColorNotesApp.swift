//
//  ColorNotesApp.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI

@main
struct ColorNotesApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(colorListViewModel: ColorListViewModel())
                .preferredColorScheme(.light)
        }
    }
}
