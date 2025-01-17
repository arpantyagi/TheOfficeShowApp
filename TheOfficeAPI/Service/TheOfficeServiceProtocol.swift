//
//  TheOfficeServiceProtocol.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import Foundation

protocol TheOfficeServiceProtocol {
    
    func fetchEpisodes(page: Int) async throws -> PaginatedData<TOEpisode>
    
    func fetchCharacters(page: Int) async throws -> PaginatedData<Character>
    
}

class TheOfficeService: TheOfficeServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchEpisodes(page: Int) async throws -> PaginatedData<TOEpisode> {
        return try await fetchData(endpoing: "episodes", page: page)
    }
    
    func fetchCharacters(page: Int) async throws -> PaginatedData<Character> {
        return try await fetchData(endpoing: "characters", page: page)
    }
    
    private func fetchData<T: Codable>(endpoing: String, page: Int) async throws -> PaginatedData<T> {
        guard let url = URL(string: "https://theofficeapi.dev/api/\(endpoing)?page=\(page)")
        else {
            throw ServiceError.invalidURL
        }
        do {
            let (data, _) = try await session.data(from: url)
            return try JSONDecoder().decode(PaginatedData<T>.self, from: data)
        } catch let decodingError as DecodingError {
            throw ServiceError.decodingError(decodingError)
        } catch let networkError as URLError {
            throw ServiceError.networkError(networkError)
        }
    }
}

