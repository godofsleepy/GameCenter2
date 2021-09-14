//
//  GamesReponse.swift
//  GameRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation

public struct GamesResponse: Codable {
    public init(results: [GameResponse], count: Int?) {
        self.results = results
        self.count = count
    }
    
    public let results: [GameResponse]
    let count : Int?
    
    enum CodingKeys: String, CodingKey {
           case results = "results"
           case count = "count"
       }
}


public struct GameResponse : Codable {
    public init(id: Int?, name: String?, rating: Double?, released: String?, background_image: String?) {
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
        self.background_image = background_image
    }
    
    let id : Int?
    let name : String?
    let rating : Double?
    let released : String?
    let background_image : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case released = "released"
        case rating = "rating"
        case background_image = "background_image"
    }
}
