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
    let background_image_additional : String?
    let parent_platforms : [platforms]
    let genres : [genre]
    let clip : clip
    
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
        case clip = "clip"
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

struct clip : Codable {
    let clip : String?
    enum CodingKeys: String, CodingKey {
        case clip = "clip"
    }
}


