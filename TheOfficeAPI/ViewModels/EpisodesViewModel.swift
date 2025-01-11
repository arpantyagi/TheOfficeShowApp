//
//  EpisodesViewModel.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import SwiftUI

@MainActor
class EpisodesViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    @Published var isLoading: Bool = false
    @Published var errMessage: String? = nil
    
    private let service: TheOfficeServiceProtocol
    private var currentPage: Int = 1
    private var isLastPage: Bool = false

    
    init(service: TheOfficeServiceProtocol = TheOfficeService()) {
        self.service = service
    }
    
    func fetchEpisodes() async {
        guard !isLoading && !isLastPage else { return }
        
        isLoading = true
        errMessage = nil
        
        do {
            print("Fetching Page \(currentPage)")
            let dataPackage = try await service.fetchEpisodes(page: currentPage)
            episodes.append(contentsOf: dataPackage.results)
            isLastPage = dataPackage.meta.isLastPage
            currentPage += 1
        } catch {
            errMessage = error.localizedDescription
        }
        isLoading = false
    }
}

struct Episode: Identifiable, Equatable, Codable {
    let id: Int
    let title: String
    let episode: String
    let seriesEpisodeNumber: Int
    let airDate: String
    let season: Season?
    let mainCharacters: [Character]?
    let supportingCharacters: [Character]?
    let recurringCharacters: [Character]?
}

struct Season: Identifiable, Equatable, Codable {
    let id: Int
    let number: Int
    let startDate: String
    let endDate: String
}
