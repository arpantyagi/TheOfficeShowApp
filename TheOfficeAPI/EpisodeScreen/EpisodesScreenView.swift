//
//  EpisodesScreenView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import SwiftUI

struct EpisodesScreenView: View {
    @StateObject var viewModel: EpisodesViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.episodes) { episode in
                Text(episode.title)
                    .onAppear {
                        if episode == viewModel.episodes.last {
                            Task {
                                await viewModel.fetchEpisodes()
                            }
                        }
                    }
            }
            .navigationTitle("Episodes")
            .overlay {
                Group {
                    if viewModel.isLoading && viewModel.episodes.isEmpty {
                        ProgressView("Loading")
                    } else if let errorMessage = viewModel.errMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchEpisodes()
        }
    }
}

//#Preview {
//    EpisodesScreenView(viewModel: EpisodesViewModel())
//}
