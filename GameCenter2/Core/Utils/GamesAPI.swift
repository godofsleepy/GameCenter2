//
//  GamesAPI.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
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

//enum GamesApi {
//    private static let call = Call()
//
//    static func gamePlatform(id: String = "18") -> AnyPublisher<Games<Game>, Error> {
//        let request = URLComponents(url: URL(string: "https://api.rawg.io/api/games?platforms=\(id)")!, resolvingAgainstBaseURL: true)!
//            .request
//        return call.run(request!)
//    }
//
//    static func detail(id: String) -> AnyPublisher<Detail, Error> {
//        print("id : \(id)")
//        let request = URLComponents(url: URL(string: "https://api.rawg.io/api/games/\(id)")!, resolvingAgainstBaseURL: true)!
//            .request
//        return call.run(request!)
//    }
//
//    static func gameSearch(query: String) -> AnyPublisher<Games<Game>, Error> {
//
//           let request = URLComponents(url: URL(string: "https://api.rawg.io/api/games?search=\(query.replacingOccurrences(of: " ", with: "&20", options: .literal, range: nil))s")!, resolvingAgainstBaseURL: true)!
//               .request
//           return call.run(request!)
//       }
//}
//
//private extension URLComponents {
//    var request: URLRequest? {
//        url.map { URLRequest.init(url: $0) }
//    }
//}



