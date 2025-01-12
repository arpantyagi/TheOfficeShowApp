//
//  Models.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 12.01.2025.
//
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


struct Episode: Identifiable, Equatable, Codable, Hashable {
    let id: Int
    let title: String
    let episode: String
    let summary: String
    let seriesEpisodeNumber: Int
    let airDate: String
    let season: Season?
    let seasonId: Int
    let mainCharacters: [Character]?
    let supportingCharacters: [Character]?
    let recurringCharacters: [Character]?
}

struct Season: Identifiable, Equatable, Codable, Hashable {
    let id: Int
    let number: Int
    let startDate: String
    let endDate: String
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
