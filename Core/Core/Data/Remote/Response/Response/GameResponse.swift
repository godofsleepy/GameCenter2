//
//  GameResoponse.swift
//  Core
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation
public struct GamesResponse: Codable {
    public let results: [GameResponse]
    public let count : Int?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case count = "count"
    }
}

public struct GameResponse : Codable {
    public let id : Int?
    public let name : String?
    public let rating : Double?
    public let released : String?
    public let background_image : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case released = "released"
        case rating = "rating"
        case background_image = "background_image"
    }
}
