//
//  DetailResponse.swift
//  GameRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation

public struct DetailResponse : Codable {
    let id : Int?
    let name : String?
    let released : String?
    let rating : Double?
    let description  : String?
    let background_image : String?
    let background_image_additional : String?
    let parent_platforms : [platforms]
    let genres : [genre]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case released = "released"
        case rating = "rating"
        case description = "description"
        case background_image = "background_image"
        case background_image_additional = "background_image_additional"
        case parent_platforms = "parent_platforms"
        case genres = "genres"
    }
}

public struct platforms : Codable {
    let platform : platform
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }
}

public struct platform :Codable {
    let slug : String?
    
    enum CodingKeys: String, CodingKey {
        case slug = "slug"
    }
}

public struct genre : Codable {
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}



