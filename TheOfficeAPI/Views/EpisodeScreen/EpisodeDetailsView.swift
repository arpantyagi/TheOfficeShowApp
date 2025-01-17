//
//  EpisodeDetailsView.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 11.01.2025.
//
import SwiftUI

struct EpisodeDetailsView: View {
    let episode: TOEpisode
    
    var body: some View {
        VStack {
            Text(episode.title)
                .font(.title)
            Text("Air Date: \(episode.airDate)")
                .font(.caption)
            Text(episode.summary)
                .font(.body)
                .padding()
            Spacer()
            Text("")
        }
    }
}

