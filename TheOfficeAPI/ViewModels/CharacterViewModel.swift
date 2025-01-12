//
//  CharacterViewModel.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//

class CharacterViewModel: BasePaginatedViewModel<Character> {
    private let service: TheOfficeServiceProtocol
    
    init(service: TheOfficeServiceProtocol) {
        self.service = service
        super.init()
    }
    
    func fetchCharacters() async {
        await fetchData { page in
            try await service.fetchCharacters(page: page)
        }
    }
    override func reset() async {
        await super.reset()
        await fetchCharacters()
    }
}
