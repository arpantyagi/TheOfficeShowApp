//
//  EpisodesScreenView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import SwiftUI

struct EpisodesScreenView: View {
    @StateObject var viewModel = EpisodesViewModel(service: TheOfficeService())
    
    var body: some View {
        NavigationStack {
            EpisodesList(viewModel: viewModel)
                .navigationDestination(for: Episode.self, destination: EpisodeDetailsView.init)
                .navigationTitle("Episodes")
                .overlay(loadingOverlay)
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
    }
    
    private var loadingOverlay: some View {
        LoadingOverlay(
            isLoading: viewModel.isLoading,
            items: viewModel.items,
            errorMessage: viewModel.errMessage
        )
    }
    
    private var loadingMoreIndicator: some View {
        Group {
            if viewModel.isLoading && !viewModel.items.isEmpty {
                ProgressView("Loading More")
                    .transition(.opacity)
            }
        }
    }
}

struct EpisodesList: View {
    @ObservedObject var viewModel: EpisodesViewModel
    
    var body: some View {
        List(viewModel.items) { episode in
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



