//
//  BasePaginatedViewModel.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 12.01.2025.
//
import SwiftUI

@MainActor
class BasePaginatedViewModel<T:Identifiable & Equatable & Codable>: ObservableObject {
    @Published var items: [T] = []
    @Published var isLoading: Bool = false
    @Published var errMessage: String?
    
    //private let service: TheOfficeServiceProtocol
    private var currentPage: Int = 1
    private var isLastPage: Bool = false
    
    var hasError: Bool { errMessage != nil }
    
    func fetchData(fetchBlock: (Int) async throws -> PaginatedData<T>) async {
        
        guard !isLoading && !isLastPage else { return }
        
        isLoading = true
        errMessage = nil
        defer { self.isLoading = false }
        
        do {
            print("Fetching page \(currentPage)")
            let dataPackage = try await fetchBlock(currentPage)
            
            // Filter out duplicates
            let newItems = dataPackage.results.filter { newItem in
                !items.contains(where: { $0.id == newItem.id })
            }
            items.append(contentsOf: newItems)
            isLastPage = dataPackage.meta.isLastPage
            currentPage += 1
        } catch {
            errMessage = error.localizedDescription
        }
    }
    
    func reset() async {
        currentPage = 1
        isLastPage = false
        items.removeAll()
    }
}
