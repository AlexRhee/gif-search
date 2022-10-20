//
//  GiphyAPICalls.swift
//  gif-search
//
//  Created by Rhee on 10/17/22.
//

import Foundation

class GIPHYCalls: ObservableObject {
    
    @Published var gifCollection = [dataStructure]()
    
    //Config variables for the API calls
    let apiKey = "zdwyrs41SHgJoJUGqeyNTFarGqN2uMvP"
    let rating = "g"
    let limit = 50
    
    init() {
        //Pull in the trending gifs when initialized
        trendingGifsApi()
    }
    
    //Call to pull in the trending gifs
    func trendingGifsApi() {
        let url = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=\(apiKey)&limit=\(limit)&rating=\(rating)")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                if let decodedGIF = try? JSONDecoder().decode(GIPHYStructure.self, from: data) {
                    DispatchQueue.main.async {
                        self.gifCollection = decodedGIF.data
                    }
                }
            }
        }
        .resume()
    }
    
    //Search gifs based on the searchTerm param
    func searchGifsApi(searchTerm: String) {
        let url = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(searchTerm)&limit=\(limit)&offset=0&rating=\(rating)&lang=en")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                if let decodedGIF = try? JSONDecoder().decode(GIPHYStructure.self, from: data) {
                    DispatchQueue.main.async {
                        self.gifCollection = decodedGIF.data
                    }
                }
            }
        }.resume()
    }
}

//Models for the API JSON data
struct GIPHYStructure: Decodable {
    var data: [dataStructure]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct dataStructure: Decodable {
    var id: String
    var gifSources: imageStructure
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case gifSources = "images"
    }
    
    func getGifURL() -> String {
        return gifSources.original.url
    }
}

struct imageStructure: Decodable {
    let original: originalStructure
    
    enum CodingKeys: String, CodingKey {
        case original = "original"
    }
}

struct originalStructure: Decodable {
    let url: String
    let mp4: String
}

