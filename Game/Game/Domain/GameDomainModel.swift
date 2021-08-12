//
//  GameDomainModel.swift
//  Game
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation
struct GameDomainModel: Equatable, Identifiable {
    let id : Int
    let name : String
    let rating : Double
    let released : String?
    let background_image : String?
    
    init(id: Int, name: String, rating: Double, released : String, background_image: String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
        self.background_image = background_image
    }
}
