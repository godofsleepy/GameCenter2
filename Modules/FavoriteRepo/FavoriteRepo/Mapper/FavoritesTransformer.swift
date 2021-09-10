//
//  FavoriteTransformer.swift
//  FavoriteRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation
import Core
import GameDomain

public struct FavoritesTransformer: Mapper {
    public typealias Response = Any
    public typealias Entity = [GameEntity]
    public typealias Domain = [DetailModel]
    
    public func transformResponseToEntity(response: Any) -> Entity {
        fatalError()
    }
    
    public func transformResponseToDomain(response: Any) -> [DetailModel] {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: [GameEntity]) -> [DetailModel] {
        return entity.map { result in
            return DetailModel(
                id: result.id,
                name: result.name,
                released: result.released,
                rating: result.rating,
                description: result.desc,
                background_image: result.image,
                background_image_additional: result.additionalImage,
                parent_platforms: result.platforms.map { result in
                    return PlatformsModel(platform: PlatformModel(slug: result))
                },
                genres: result.genre.map { result in
                    return GenreModel(name: result)
                }
            
            )
        }
    }
    
}
