//
//  TheOfficeServiceProtocol.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//
import Foundation

protocol TheOfficeServiceProtocol {
    
    func fetchEpisodes(page: Int) async throws -> PaginatedData<Episode>
    
    func fetchCharacters(page: Int) async throws -> PaginatedData<Character>
    
}

class TheOfficeService: TheOfficeServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchEpisodes(page: Int) async throws -> PaginatedData<Episode> {
        return try await fetchData(endpoing: "episodes", page: page)
    }
    
    func fetchCharacters(page: Int) async throws -> PaginatedData<Character> {
        return try await fetchData(endpoing: "characters", page: page)
    }
    
    private func fetchData<T: Codable>(endpoing: String, page: Int) async throws -> PaginatedData<T> {
        guard let url = URL(string: "https://theofficeapi.dev/api/\(endpoing)?page=\(page)")
        else {
            throw TheOfficeAPIError.invalidURL
        }
        do {
            let (data, _) = try await session.data(from: url)
            return try JSONDecoder().decode(PaginatedData<T>.self, from: data)
        } catch let decodingError as DecodingError {
            throw TheOfficeAPIError.decodingError(decodingError)
        } catch let networkError as URLError {
            throw TheOfficeAPIError.networkError(networkError)
        }
    }
}

struct PaginatedData<T: Codable>: Codable {
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

enum TheOfficeAPIError: Error {
    case invalidURL
    case decodingError(Error)
    case networkError(Error)
}
