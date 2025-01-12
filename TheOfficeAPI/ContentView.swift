//
//  ContentView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .episodes
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        //appearance.backgroundColor = UIColor.systemBackground // Set your desired color
        // UITabBar.appearance().standardAppearance = appearance
        // UITabBar.appearance().scrollEdgeAppearance = appearance // Prevent transparency
    }
    
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
       }
   }

enum Tab {
    case episodes, characters
}

#Preview {
    ContentView()
}





