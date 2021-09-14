//
//  DetailResponse.swift
//  GameRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation

public struct DetailResponse : Codable {
    public init(id: Int?, name: String?, released: String?, rating: Double?, description: String?, background_image: String?, background_image_additional: String?, parent_platforms: [platforms], genres: [genre]) {
        self.id = id
        self.name = name
        self.released = released
        self.rating = rating
        self.description = description
        self.background_image = background_image
        self.background_image_additional = background_image_additional
        self.parent_platforms = parent_platforms
        self.genres = genres
    }
    
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
    public init(platform: platform) {
        self.platform = platform
    }
    
    let platform : platform
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }
}

public struct platform :Codable {
    public init(slug: String?) {
        self.slug = slug
    }
    
    let slug : String?
    
    enum CodingKeys: String, CodingKey {
        case slug = "slug"
    }
}

public struct genre : Codable {
    public init(name: String?) {
        self.name = name
    }
    
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}



