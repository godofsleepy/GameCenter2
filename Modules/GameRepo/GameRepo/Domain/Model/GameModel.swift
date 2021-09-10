//
//  GameModel.swift
//  GameRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation

public struct GameModel: Equatable, Identifiable {
    public let id : Int
    public let name : String
    public let rating : Double
    public let released : String?
    public let background_image : String?
}

