//
//  RemoteDataSource.swift
//  Game
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation
import Core
import Combine
import Alamofire

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteModuleDataSourceProtocol {
    
    
    func getGames(platformId: String) -> AnyPublisher<[Core.GameResponse],  Core.URLError> {
        return Future<[GameResponse], Core.URLError> { completion in
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
    
    func getDetail(gameId: String) -> AnyPublisher<DetailResponse, Core.URLError> {
        
        return Future<DetailResponse, Core.URLError> { completion in
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
    
    func getSearch(query: String) -> AnyPublisher<[GameResponse],  Core.URLError> {
        return Future<[GameResponse], Core.URLError> { completion in
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
    
    

    
    
    
    
    
    
}

