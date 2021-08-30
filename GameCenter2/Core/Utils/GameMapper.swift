//
//  GameMapper.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

final class GameMapper {
    
    static func mapGamesResponsesToDomains(
        input gameResponses: [GameResponse]
    ) -> [GameModel] {
        
        return gameResponses.map { result in
            return GameModel(
                id: result.id ?? 1 ,
                name: result.name ?? "",
                rating: result.rating ?? 0.0,
                released: result.released ?? "" ,
                background_image: result.background_image ?? ""
            )
            
        }
    }
    
    static func mapDetailDomainToEntitiy (input detailGame : DetailModel) -> GameEntity {
        let gameEntity = GameEntity()
        gameEntity.id = detailGame.id
        gameEntity.name = detailGame.name
        gameEntity.rating = detailGame.rating
        gameEntity.released = detailGame.released ?? ""
        gameEntity.desc = detailGame.description ?? "No Description"
        gameEntity.image = detailGame.background_image ?? ""
        gameEntity.additionalImage = detailGame.background_image_additional ?? ""
        for platform in detailGame.parent_platforms {
            gameEntity.platforms.append(platform.platform.slug)
        }
        for genre in detailGame.genres {
            gameEntity.genre.append(genre.name)
        }
        return gameEntity
    }
    
    static func mapGameEntitiesToDomains (input favGames : [GameEntity]) -> [DetailModel] {
        return favGames.map { result in
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
    
    static func mapDetailResponsesToDomains(
        input detailResponses : DetailResponse
    ) -> DetailModel {
        return DetailModel(
            id: detailResponses.id ?? 0,
            name: detailResponses.name ?? "",
            released: detailResponses.released ?? "",
            rating: detailResponses.rating ?? 0.0,
            description: detailResponses.description ?? "",
            background_image: detailResponses.background_image ?? "",
            background_image_additional: detailResponses.background_image_additional ?? "",
            parent_platforms: detailResponses.parent_platforms.map { result in
                return PlatformsModel(
                    platform: PlatformModel(slug: result.platform.slug ?? "")
                )
            },
            genres: detailResponses.genres.map{ result in
                return GenreModel (
                    name: result.name ?? ""
                )
            }
        )
    }
    
}

