//
//  EpisodesViewModel.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//

class EpisodesViewModel: BasePaginatedViewModel<Episode> {
    private let service: TheOfficeServiceProtocol
    
    init(service: TheOfficeServiceProtocol) {
        self.service = service
    }

    func fetchEpisodes() async {
        await fetchData { currentPage in
            try await service.fetchEpisodes(page: currentPage)
        }
    }
}

