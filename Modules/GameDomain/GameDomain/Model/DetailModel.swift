//
//  DetailModel.swift
//  GameDomain
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation

public struct DetailModel : Equatable, Identifiable, Hashable{
    public init(id: Int, name: String, released: String?, rating: Double, description: String?, background_image: String?, background_image_additional: String?, parent_platforms: [PlatformsModel], genres: [GenreModel]) {
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
    
    
    public let id : Int
    public let name : String
    public let released : String?
    public let rating : Double
    public let description  : String?
    public let background_image : String?
    public let background_image_additional : String?
    public let parent_platforms : [PlatformsModel]
    public let genres : [GenreModel]
    
    public func getGenre() -> [String] {
        return genres.map {
            $0.name
        }   }
    
    public func getPlatform() -> [String] {
        return parent_platforms.map {
            $0.platform.slug
        }
    }
    
}

public struct PlatformsModel : Equatable, Hashable {
    public init(platform: PlatformModel) {
        self.platform = platform
    }
    
    public let platform : PlatformModel
}

public struct PlatformModel : Equatable, Hashable {
    public init(slug: String) {
        self.slug = slug
    }
    
    public let slug : String
}

public struct GenreModel : Equatable, Hashable {
    public init(name: String) {
        self.name = name
    }
    
    public let name : String
}
