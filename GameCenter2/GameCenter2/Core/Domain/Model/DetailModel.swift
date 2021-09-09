//
//  DetailMap.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import Foundation

struct DetailModel : Equatable, Identifiable, Hashable{
    
    let id : Int
    let name : String
    let released : String?
    let rating : Double
    let description  : String?
    let background_image : String?
    let background_image_additional : String?
    let parent_platforms : [PlatformsModel]
    let genres : [GenreModel]
    
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

struct PlatformsModel : Equatable, Hashable {
    let platform : PlatformModel
}

struct PlatformModel : Equatable, Hashable {
    let slug : String
}

struct GenreModel : Equatable, Hashable {
    let name : String
}


