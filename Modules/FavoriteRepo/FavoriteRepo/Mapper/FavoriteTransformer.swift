//
//  FavoriteTransformer.swift
//  FavoriteRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation
import Core
import GameDomain

public struct FavoriteTransformer: Mapper {
    
    public init() {}
    
    public typealias Response = Any
    public typealias Entity = GameEntity
    public typealias Domain = DetailModel
    
    public func transformResponseToEntity(response: Any) -> Entity {
        fatalError()
    }
    
    public func transformResponseToDomain(response: Any) -> Domain {
        fatalError()
    }
    
    public func transformDomainToEntiry(domain: DetailModel) -> GameEntity {
        let gameEntity = GameEntity()
        gameEntity.id = domain.id
        gameEntity.name = domain.name
        gameEntity.rating = domain.rating
        gameEntity.released = domain.released ?? ""
        gameEntity.desc = domain.description ?? "No Description"
        gameEntity.image = domain.background_image ?? ""
        gameEntity.additionalImage = domain.background_image_additional ?? ""
        for platform in domain.parent_platforms {
            gameEntity.platforms.append(platform.platform.slug)
        }
        for genre in domain.genres {
            gameEntity.genre.append(genre.name)
        }
        return gameEntity
    }
    
    public func transformEntityToDomain(entity: Entity) -> Domain {
        return DetailModel(
            id: entity.id,
            name: entity.name,
            released: entity.released,
            rating: entity.rating,
            description: entity.desc,
            background_image: entity.image,
            background_image_additional: entity.additionalImage,
            parent_platforms: entity.platforms.map { result in
                return PlatformsModel(platform: PlatformModel(slug: result))
            },
            genres: entity.genre.map { result in
                return GenreModel(name: result)
            }
            
        )
    }
    
}
