//
//  EpisodesScreenView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import SwiftUI

struct EpisodesScreenView: View {
    @StateObject var viewModel = EpisodesViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.episodes) { episode in
                NavigationLink("S\(episode.seasonId)E\(episode.seriesEpisodeNumber): \(episode.title)", value: episode)
                    .onAppear {
                        if episode == viewModel.episodes.last {
                            onLastRowAppear()
                        }
                    }
                
            }
            .navigationDestination(for: Episode.self, destination: EpisodeDetailsView.init)
            .navigationTitle("Episodes")
            .overlay(LoadingOverlay2(viewModel: viewModel))
            if viewModel.isLoading && !viewModel.episodes.isEmpty {
                withAnimation(.easeInOut) {
                    ProgressView("Loading More")
                }
            }
        }
        .task {
            if viewModel.episodes.isEmpty {
                await viewModel.fetchEpisodes()
            }
        }
    }
    
    fileprivate func onLastRowAppear() {
        Task {
            await viewModel.fetchEpisodes()
        }
    }
}

struct LoadingOverlay2: View {
    let viewModel: EpisodesViewModel
    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.episodes.isEmpty {
                ProgressView("Loading Episodes")
            } else if let errorMessage = viewModel.errMessage {
                Text("Error: \(errorMessage)")
                    .foregroundStyle(.red)
                    .padding()
            }
        }
    }
}


#Preview {
    EpisodesScreenView(viewModel: EpisodesViewModel())
}

