//
//  ContentView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .episodes
    @State private var selectedShow: TVShow = .office
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: toggleShow){
                        Text(selectedShow == .office ? "Switch to Rick and Morty" : "Switch to The Office")
                    }
                }
            }
            .navigationTitle("The Office")
        }
    }
    private func toggleShow(){
        if selectedShow == .office {
            selectedShow = .rickAndMorty
        } else {
            selectedShow = .office
        }
    }
    
}
enum Tab {
    case episodes, characters
}

enum TVShow  {
    case office, rickAndMorty
}

//#Preview {
//    ContentView()
//}





