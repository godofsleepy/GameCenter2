//
//  GameMapper.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

final class GameMapper {
    
    //  static func mapCategoryResponsesToEntities(
    //    input categoryResponses: [GamesResponse]
    //  ) -> [CategoryEntity] {
    //    return categoryResponses.map { result in
    //      let newCategory = CategoryEntity()
    //      newCategory.id = result.id ?? ""
    //      newCategory.title = result.title ?? "Unknow"
    //      newCategory.image = result.image ?? "Unknow"
    //      newCategory.desc = result.description ?? "Unknow"
    //      return newCategory
    //    }
    //  }
    
    //  static func mapCategoryEntitiesToDomains(
    //    input categoryEntities: [CategoryEntity]
    //  ) -> [CategoryModel] {
    //    return categoryEntities.map { result in
    //      return CategoryModel(
    //        id: result.id,
    //        title: result.title,
    //        image: result.image,
    //        description: result.desc
    //      )
    //    }
    //  }
    //
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
    
    static func mapDetailResponsesToDomains(
        input detailResponses : DetailResponse
    ) -> DetailModel {
        return DetailModel(
            id: detailResponses.id ?? 1,
            name: detailResponses.name ?? "",
            released: detailResponses.released ?? "",
            rating: detailResponses.rating ?? 0.0,
            description: detailResponses.description ?? "",
            background_image: detailResponses.background_image ?? "",
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

