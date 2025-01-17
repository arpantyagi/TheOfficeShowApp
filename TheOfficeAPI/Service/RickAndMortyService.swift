//
//  RickAndMortyService.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 16.01.2025.
//
import Foundation

class RMService {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func fetchCharacters(page: Int) async throws -> [RMCharchter] {
        let urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
        guard let url = URL(string: urlString) else {
            throw ServiceError.invalidURL
        }
        return []
    }
    
    public func fetchEpisodes(page: Int) async throws -> RMPaginatedData<RMEpisode> {
        
        let urlString = "https://rickandmortyapi.com/api/episode?page=\(page)"
        guard let url = URL(string: urlString) else {
            throw ServiceError.invalidURL
        }
        
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(RMPaginatedData<RMEpisode>.self , from: data)
    }
    
}

struct RMPaginatedData<T: Codable>: Codable {
    let info: RMInfo
    let results: [T]
}

struct RMInfo : Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct RMCharchter: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: Int
    let url: String
    let created: String
}
