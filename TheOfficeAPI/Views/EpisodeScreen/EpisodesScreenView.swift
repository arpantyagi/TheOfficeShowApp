//
//  EpisodesScreenView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import SwiftUI

struct EpisodesScreenView: View {
    @StateObject var viewModel = EpisodesViewModel(service: TheOfficeService())
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            EpisodesList(viewModel: viewModel)
                .navigationDestination(for: Episode.self, destination: EpisodeDetailsView.init)
                .navigationTitle("Episodes")
                .overlay(loadingOverlay)
                .searchable(text: $viewModel.searchText, prompt:  "Search Episode")
            if viewModel.isLoading && !viewModel.items.isEmpty {
                Spacer()
                ProgressView("Loading More")
                    .animation(.easeIn, value: viewModel.isLoading && !viewModel.items.isEmpty)
                    .padding()
                Spacer()
            }
        }
        .task {
            if viewModel.items.isEmpty {
                await viewModel.fetchEpisodes()
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

struct EpisodesList: View {
    @ObservedObject var viewModel: EpisodesViewModel
    
    var body: some View {
        List(viewModel.filteredItems) { episode in
            NavigationLink(
                "S\(episode.seasonId)E\(episode.seriesEpisodeNumber): \(episode.title)",
                value: episode
            )
            .onAppear {
                if episode == viewModel.items.last {
                    onLastRowAppear()
                }
            }
        }
    }
    
    private func onLastRowAppear() {
        Task {
            await viewModel.fetchEpisodes()
        }
    }
}



