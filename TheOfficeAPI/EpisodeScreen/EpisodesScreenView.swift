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
                            Task {
                                await viewModel.fetchEpisodes()
                            }
                        }
                    }
            }
            .padding(.top)
            .navigationDestination(for: Episode.self, destination: EpisodeDetailsView.init)
            .navigationTitle("Episodes")
            .overlay {
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
        .task {
            await viewModel.fetchEpisodes()
        }
    }
}

#Preview {
    EpisodesScreenView(viewModel: EpisodesViewModel())
}

