//
//  DetailModel.swift
//  GameRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation

public struct DetailModel : Equatable, Identifiable, Hashable{
    
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
    public let platform : PlatformModel
}

public struct PlatformModel : Equatable, Hashable {
    public let slug : String
}

public struct GenreModel : Equatable, Hashable {
    public let name : String
}
