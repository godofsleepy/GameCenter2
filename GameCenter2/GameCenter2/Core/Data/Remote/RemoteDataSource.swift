//
//  RemoteDataSource.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
    func getGames(platformId : String) -> AnyPublisher<[GameResponse], Error>
    func getDetail(gameId : String) -> AnyPublisher<DetailResponse, Error>
    func getSearch(query : String) -> AnyPublisher<[GameResponse], Error>

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getSearch(query: String) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: "\(Endpoints.Gets.search.url)\(query.replacingOccurrences(of: " ", with: "&20", options: .literal, range: nil))&platforms=7,18,4,1"){
                AF.request(url)
                  .validate()
                  .responseDecodable(of: GamesResponse.self) { response in
                    switch response.result {
                    case .success(let value):
    //                    print(value.results)
                      completion(.success(value.results))
                    case .failure:
                      completion(.failure(URLError.invalidResponse))
                    }
                  }

            }
        }.eraseToAnyPublisher()
    }
    
    
    func getDetail(gameId: String) -> AnyPublisher<DetailResponse, Error> {
        return Future<DetailResponse, Error> { completion in
            if let url = URL(string:  Endpoints.Gets.gameDetail.url + gameId){
                AF.request(url)
                  .validate()
                  .responseDecodable(of: DetailResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure:
                      completion(.failure(URLError.invalidResponse))
                    }
                  }

            }
        }.eraseToAnyPublisher()
    }
    
    
    func getGames(platformId : String ) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
          if let url = URL(string: Endpoints.Gets.gamesPlatforms.url + platformId) {
            AF.request(url)
              .validate()
              .responseDecodable(of: GamesResponse.self) { response in
                switch response.result {
                case .success(let value):
//                    print(value.results)
                  completion(.success(value.results))
                case .failure:
                  completion(.failure(URLError.invalidResponse))
                }
              }
          }
        }.eraseToAnyPublisher()
    }
    
    
}

