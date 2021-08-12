//
//  DetailResponse.swift
//  Core
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation

public struct DetailResponse : Codable {
    public let id : Int?
    public  let name : String?
    public let released : String?
    public  let rating : Double?
    public let description  : String?
    public  let background_image : String?
    public let background_image_additional : String?
    public let parent_platforms : [platforms]
    public let genres : [genre]
    public let clip : clip
    
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

public struct platforms : Codable {
    public let platform : platform
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }
}

public struct platform :Codable {
    public let slug : String?
    
    enum CodingKeys: String, CodingKey {
        case slug = "slug"
    }
}

public struct genre : Codable {
    public  let name : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

public struct clip : Codable {
    public  let clip : String?
    enum CodingKeys: String, CodingKey {
        case clip = "clip"
    }
}


