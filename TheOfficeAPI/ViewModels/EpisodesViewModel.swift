//
//  EpisodesViewModel.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//

class EpisodesViewModel: BasePaginatedViewModel<TOEpisode> {
    private let service: TheOfficeServiceProtocol
    
    init(service: TheOfficeServiceProtocol) {
        self.service = service
    }

    func fetchEpisodes() async {
        await fetchData { currentPage in
            try await service.fetchEpisodes(page: currentPage)
        }
    }
    
    override func reset() async {
        await super.reset()
        await fetchEpisodes()
    }
}

