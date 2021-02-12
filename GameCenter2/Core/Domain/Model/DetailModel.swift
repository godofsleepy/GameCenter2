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
    let clip : String?
    
    public func getGenre() -> [String] {
        var genreArray : [String] = []
        for i in genres {
            genreArray.append(i.name)
        }
        return genreArray
    }
    
    public func getPlatform() -> [String] {
        var platformArray : [String] = []
        for i in parent_platforms {
            platformArray.append(i.platform.slug)
        }
        return platformArray
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


