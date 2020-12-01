//
//  APICall.swift
//  GameCenter2
//
//  Created by rifat khadafy on 01/12/20.
//

import Foundation

struct API {

  static let baseUrl = "https://api.rawg.io/api/"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  
  enum Gets: Endpoint {
    case gamesByPlatform
    case detail
    case search
    
    public var url: String {
      switch self {
      case .gamesByPlatform: return "\(API.baseUrl)games?platform="
      case .detail: return "\(API.baseUrl)games/"
      case .search: return "\(API.baseUrl)games?platforms=7,18,4,1&search="
      }
    }
  }
  
}
