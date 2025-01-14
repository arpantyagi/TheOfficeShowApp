//
//  CharacterScreenView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import SwiftUI

struct CharacterScreenView: View {
    @StateObject var viewModel = CharacterViewModel(
        service: TheOfficeService())
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            CharacterList(viewModel: viewModel)
                .navigationDestination(for: Character.self, destination: CharacterDetailView.init)
                .navigationTitle("Character")
                .overlay(loadingOverlay)
                .searchable(text: $viewModel.searchText, prompt: "Search Characters")
            if viewModel.isLoading && !viewModel.items.isEmpty {
                ProgressView("Loading More")
                    .animation(.easeIn, value: viewModel.isLoading && !viewModel.items.isEmpty)
            }
        }
        .task {
            if viewModel.items.isEmpty {
                await viewModel.fetchCharacters()
            }
        }
        .refreshable {
            await viewModel.reset()
        }
    }
    private var loadingOverlay: some View {
        LoadingOverlay(
            isLoading: viewModel.isLoading,
            items: viewModel.items,
            errorMessage: viewModel.errMessage
        )
    }
}

struct CharacterList: View {
    @ObservedObject var viewModel: CharacterViewModel
    
    var body: some View {
        List(viewModel.filteredItems) { character in
            NavigationLink(
                "\(character.name)",
                value: character
            )
            .onAppear {
                if character == viewModel.items.last {
                    onLastRowAppear()
                }
            }
        }
    }
    
    private func onLastRowAppear() {
        Task {
            await viewModel.fetchCharacters()
        }
    }
}
