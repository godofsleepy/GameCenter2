//
//  Games.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import Foundation

struct GamesResponse: Codable {
    let results: [GameResponse]
    let count : Int?
    
    enum CodingKeys: String, CodingKey {
           case results = "results"
           case count = "count"
       }
}

struct GameResponse : Codable {
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
