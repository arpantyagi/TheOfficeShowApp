//
//  ContentView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .episodes
    
    var body: some View {
           TabView(selection: $selectedTab) {
               EpisodesScreenView()
                   .tabItem {
                       Label("Episodes", systemImage: "house.fill")
                   }
                   .tag(Tab.episodes)

               CharacterScreenView()
                   .tabItem {
                       Label("Characters", systemImage: "person.fill")
                   }
                   .tag(Tab.characters)
           }
           .toolbarBackground(Color.blue.opacity(0.8), for: .tabBar)
       }
   }

enum Tab {
    case episodes, characters
}

#Preview {
    ContentView()
}





