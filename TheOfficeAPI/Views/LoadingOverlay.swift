//
//  LoadingOverlay.swift
//  TheOfficeAPI
//
//  Created by Arpan Tyagi on 12.01.2025.
//
import SwiftUI

struct LoadingOverlay<T: Collection>: View {
    let isLoading: Bool
    let items: T
    let errorMessage: String?
    
    var body: some View {
        Group {
            if isLoading && items.isEmpty {
                ProgressView("Loading Characters")
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundStyle(.red)
                    .padding()
            }
        }
    }
}
