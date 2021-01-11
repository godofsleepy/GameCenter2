//
//  Detail.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import Foundation

struct DetailResponse : Codable {
    let id : Int?
    let name : String?
    let released : String?
    let rating : Double?
    let description  : String?
    let background_image : String?
    let parent_platforms : [platforms]
    let genres : [genre]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case released = "released"
        case rating = "rating"
        case description = "description"
        case background_image = "background_image"
        case parent_platforms = "parent_platforms"
        case genres = "genres"
    }
}

struct platforms : Codable {
    let platform : platform
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }
}

struct platform :Codable {
    let slug : String?
    
    enum CodingKeys: String, CodingKey {
        case slug = "slug"
    }
}

struct genre : Codable {
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
}
