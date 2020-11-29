//
//  GameAPI.swift
//  GameCenter
//
//  Created by rifat khadafy on 14/08/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import Foundation
import Combine

enum GamesApi {
    private static let call = Call()
    
    static func gamePlatform(id: String = "18") -> AnyPublisher<Games<Game>, Error> {
        let request = URLComponents(url: URL(string: "https://api.rawg.io/api/games?platforms=\(id)")!, resolvingAgainstBaseURL: true)!
            .request
        return call.run(request!)
    }
    
    static func detail(id: String) -> AnyPublisher<Detail, Error> {
        print("id : \(id)")
        let request = URLComponents(url: URL(string: "https://api.rawg.io/api/games/\(id)")!, resolvingAgainstBaseURL: true)!
            .request
        return call.run(request!)
    }
    
    static func gameSearch(query: String) -> AnyPublisher<Games<Game>, Error> {
            
           let request = URLComponents(url: URL(string: "https://api.rawg.io/api/games?search=\(query.replacingOccurrences(of: " ", with: "&20", options: .literal, range: nil))&platforms=7,18,4,1")!, resolvingAgainstBaseURL: true)!
               .request
           return call.run(request!)
       }
}

private extension URLComponents {
    var request: URLRequest? {
        url.map { URLRequest.init(url: $0) }
    }
}

