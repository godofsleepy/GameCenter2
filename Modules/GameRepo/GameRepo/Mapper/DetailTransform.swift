//
//  DetailTransform.swift
//  GameRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation
import Core
import GameDomain

public struct DetailTransform : Mapper {
    
    public typealias Response = DetailResponse
    public typealias Entity = Any
    public typealias Domain = DetailModel
    
    public func transformResponseToEntity(response: DetailResponse) -> Any {
        fatalError()
    }
    
    public func transformResponseToDomain(response: DetailResponse) -> DetailModel {
        return DetailModel(
            id: response.id ?? 0,
            name: response.name ?? "",
            released: response.released ?? "",
            rating: response.rating ?? 0.0,
            description: response.description ?? "",
            background_image: response.background_image ?? "",
            background_image_additional: response.background_image_additional ?? "",
            parent_platforms: response.parent_platforms.map { result in
                return PlatformsModel(
                    platform: PlatformModel(slug: result.platform.slug ?? "")
                )
            },
            genres: response.genres.map{ result in
                return GenreModel (
                    name: result.name ?? ""
                )
            }
        )
    }
    
    public func transformEntityToDomain(entity: Any) -> DetailModel {
        fatalError()
    }
    
    public func transformDomainToEntiry(domain: DetailModel) -> Any {
        fatalError()
    }

}
