//
//  ContentView.swift
//  gif-search
//
//  Created by Rhee on 10/17/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        Main(searchTerm: "")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
