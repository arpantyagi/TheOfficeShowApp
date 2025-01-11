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
            EpisodesScreenView(viewModel: EpisodesViewModel())
                .tabItem {
                    Label("Episodes", systemImage: "house.fill")
                }
            
            // Character Tab
            CharacterScreenView()
                .tabItem {
                    Label("Characters", systemImage: "person.fill")
                }
            
            // Settings Tab
            SettingsScreenView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}





