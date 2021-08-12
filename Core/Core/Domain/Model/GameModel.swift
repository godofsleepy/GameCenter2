//
//  GameModel.swift
//  Core
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation

public struct GameModel: Equatable, Identifiable {
    public let id : Int
    public let name : String
    public  let rating : Double
    public  let released : String?
    public let background_image : String?
    
    public init(id: Int, name: String, rating: Double, released : String, background_image: String) {
            self.id = id
            self.name = name
            self.rating = rating
            self.released = released
            self.background_image = background_image
        }
}
