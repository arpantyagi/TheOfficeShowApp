//
//  CharacterViewModel.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import SwiftUI

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var errMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private let service: TheOfficeServiceProtocol = TheOfficeService()
    private var currentPage: Int = 1
    private var isLastPage: Bool = false
    
    func fetchCharacter() async {
        guard !isLoading && !isLastPage else { return }
        
        isLoading = true
        errMessage = nil
        
        do {
            print("Fetching character page: \(currentPage)")
            let dataPackage = try await service.fetchCharacters(page: currentPage)
            characters.append(contentsOf: dataPackage.results)
            isLastPage = dataPackage.meta.isLastPage
            currentPage += 1
        } catch {
            errMessage = error.localizedDescription
        }
        isLoading = false
    }
}

struct Character: Identifiable, Equatable, Codable, Hashable {
    let id: Int
    let name: String
    let gender: String?
    let marital: String?
    let job: [String]?
    let workplace: [String]?
    let firstAppearance: String?
    let lastAppearance: String?
    let actor: String?
}
