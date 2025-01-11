//
//  CharacterViewModel.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 10.01.2025.
//

struct Character: Identifiable, Equatable, Codable {
    let id: Int
    let name: String
    let gender: String
    let marital: String
    let job: [String]
    let workspace: [String]
    let firstAppearance: String
    let lastAppearance: String
    let actor: String
    let episodes: [String]
}
