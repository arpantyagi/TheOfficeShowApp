//
//  ContentView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Episodes", systemImage: "house.fill") {
                EpisodesScreenView()
            }
            Tab("Characters", systemImage: "person.fill") {
                CharacterScreenView()
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsScreenView()
            }
        }
    }
}

#Preview {
    ContentView()
}





