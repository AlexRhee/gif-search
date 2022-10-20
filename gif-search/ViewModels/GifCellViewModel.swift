//
//  GifCellViewModel.swift
//  gif-search
//
//  Created by Rhee on 10/17/22.
//

import Foundation
import Combine

class GifCellViewModel: ObservableObject, Identifiable {
    @Published var gifCalls = GIPHYCalls()
    @Published var singleGif: dataStructure
    
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(singleGif: dataStructure) {
        self.singleGif = singleGif
        
        $singleGif
            .compactMap { singleGif in
                singleGif.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}

