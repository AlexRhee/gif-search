//
//  Main.swift
//  gif-search
//
//  Created by Rhee on 10/17/22.
//

import SwiftUI

struct Main: View {
    @State var searchTerm: String
    @ObservedObject var gifListVM = GifListViewModel()
    
    //Variable to set columns
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        
        VStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: columns) {
                        ForEach(gifListVM.gifCellVM) { gifCellVM in
                            ZStack {
                                GifCell(gifCellVM: gifCellVM, openModal: false, singleGif: gifCellVM.singleGif)
                                    .contentShape(Rectangle())
                                    .frame(width: 20)
                            }
                        }
                    }
                }
                    .searchable(text: $searchTerm)
                    .navigationTitle("Search GIFs")
            }
            .onSubmit(of: .search, runSearch)
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
    
    //Call the search api with the searchTerm param
    func runSearch() {
        gifListVM.searchGifs(searchTerm: self.searchTerm)
    }
}
