//
//  GamesAPI.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api/games"
    static let key = "915260f2cb5041538cdedbc5c3b37a18"
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
