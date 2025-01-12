//
//  CharacterDetailView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 12.01.2025.
//
import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        VStack {
            Text("Marital: \(character.marital ?? "Unknown")")
            Text("Gender: \(character.gender ?? "Unknown")")
            Text("Job: \(character.job?.description ?? "Unknown")")
            
        }
            .padding()
            .navigationTitle("\(character.name)")
    }
}
