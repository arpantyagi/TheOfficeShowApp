//
//  CharacterScreenView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import SwiftUI

struct CharacterScreenView: View {
    @StateObject var viewModel = CharacterViewModel()
    var body: some View {
        NavigationStack {
            List(viewModel.characters) { character in
                NavigationLink("\(character.name)", value: character)
                    .onAppear {
                        if character == viewModel.characters.last {
                            onLastRowAppear()
                        }
                    }
            }
            .navigationDestination(for: Character.self, destination: CharacterDetailView.init)
            .navigationTitle("Character")
            .overlay(LoadingOverlay(viewModel: viewModel))
            if viewModel.isLoading && !viewModel.characters.isEmpty {
                ProgressView("Loading More")
                    .animation(.easeIn, value: viewModel.isLoading && !viewModel.characters.isEmpty)
                
                
            }
        }
        .task {
            if viewModel.characters.isEmpty {
                await viewModel.fetchCharacter()
            }
        }
    }
    
    fileprivate func onLastRowAppear() {
        Task {
            await viewModel.fetchCharacter()
        }
    }
}

struct LoadingOverlay: View {
    let viewModel: CharacterViewModel
    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.characters.isEmpty {
                ProgressView("Loading Characters")
            } else if let errorMessage = viewModel.errMessage {
                Text("Error: \(errorMessage)")
                    .foregroundStyle(.red)
                    .padding()
            }
        }
    }
}



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
