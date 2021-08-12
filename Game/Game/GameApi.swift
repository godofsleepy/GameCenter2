//
//  GameApi.swift
//  Game
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api/games"
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case gamesPlatforms
        case gameDetail
        case search
        
        public var url: String {
            switch self {
            case .gamesPlatforms: return "\(API.baseUrl)?platforms="
            case .gameDetail: return "\(API.baseUrl)/"
            case .search: return "\(API.baseUrl)?search="
            }
        }
    }
    
}
