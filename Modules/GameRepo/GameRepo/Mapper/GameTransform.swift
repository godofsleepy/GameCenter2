//
//  GameTransrom.swift
//  GameRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation
import Core
import GameDomain

public struct GameTransform : Mapper {
    
    public typealias Response = [GameResponse]
    public typealias Entity = Any
    public typealias Domain = [GameModel]
    
    public func transformResponseToEntity(response: [GameResponse]) -> Any {
        fatalError()
    }
    
    public func transformResponseToDomain(response: [GameResponse]) -> [GameModel] {
        return response.map { result in
            return GameModel(
                id: result.id ?? 1 ,
                name: result.name ?? "",
                rating: result.rating ?? 0.0,
                released: result.released ?? "" ,
                background_image: result.background_image ?? ""
            )
            
        }
    }
    
    public func transformEntityToDomain(entity: Any) -> [GameModel] {
        fatalError()
    }
    

}
