//
//  GifListViewModel.swift
//  gif-search
//
//  Created by Rhee on 10/17/22.
//


import Foundation
import Combine
import SwiftUI

class GifListViewModel: ObservableObject {
    @Published var gifCalls = GIPHYCalls()
    @Published var gifCellVM = [GifCellViewModel]()
    var changingItemIndex = -1
    var isChanging = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        gifCalls.$gifCollection
            .map { gifs in
                gifs.map { singleGif in
                    GifCellViewModel(singleGif: singleGif)
                }
            }
            .assign(to: \.gifCellVM, on: self)
            .store(in: &cancellables)
    }
    
    func searchGifs(searchTerm: String) {
        gifCalls.searchGifsApi(searchTerm: searchTerm)
    }
    
    func randomGifs() {
        gifCalls.trendingGifsApi()
    }
}

