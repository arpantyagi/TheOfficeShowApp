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
    
    public func fetchCharacters(page: Int) -> [RMCharchter] {
        //Todo
        return []
    }
    
    public func fetchEpisodes(page: Int) -> [RMEpisode] {
        // todo
        return []
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
    let image: String
}

struct RMEpisode: Codable {
    let id: Int
}
