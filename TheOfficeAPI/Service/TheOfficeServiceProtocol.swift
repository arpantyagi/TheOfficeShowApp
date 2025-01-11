//
//  TheOfficeServiceProtocol.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import Foundation

protocol TheOfficeServiceProtocol {
    
    func fetchEpisodes(page: Int) async throws -> DataPackage<Episode>
    
    func fetchCharacters(page: Int) async throws -> DataPackage<Character>
    
}

class TheOfficeService: TheOfficeServiceProtocol {
    
    func fetchEpisodes(page: Int) async throws -> DataPackage<Episode> {
        let url = URL(string: "https://theofficeapi.dev/api/episodes?page=\(page)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(DataPackage<Episode>.self, from: data)
    }
    
    func fetchCharacters(page: Int) async throws -> DataPackage<Character> {
        let url = URL(string: "https://theofficeapi.dev/api/characters?page=\(page)")!
        let (data,_) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(DataPackage<Character>.self, from: data)
    }
}

struct DataPackage<T: Codable>: Codable {
    let results: [T]
    let meta: Metadata
    
    struct Metadata: Codable {
        let isFirstPage: Bool
        let isLastPage: Bool
        let currentPage: Int
        let previousPage: Int?
        let nextPage: Int?
        let pageCount: Int
    }
}
