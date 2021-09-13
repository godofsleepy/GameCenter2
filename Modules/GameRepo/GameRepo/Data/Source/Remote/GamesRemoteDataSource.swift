//
//  GetGameRemoteDataSource.swift
//  GameRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation
import Core
import Combine
import Alamofire

public struct GetGamesRemote : DataSource {
    
    public typealias Request = [String: String]
    public typealias Response = [GameResponse]
    private let _endpoint: String
    private let _key: String
    
    public init(endpoint: String, key: String) {
        _endpoint = endpoint
        _key = key
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: _endpoint + (request?["platformId"])!) {
                if !_key.isEmpty{
                    let parameters: Parameters = [
                        "key": _key
                    ]
                    AF.request(url, parameters: parameters)
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
                } else {
                    print("Doesn't Have API KEY")
                }
            }
        }.eraseToAnyPublisher()
    }
}

public struct GetDetailRemote : DataSource {
    
    public typealias Request = [String : String]
    public typealias Response = DetailResponse
    private let _endpoint: String
    private let _key: String
    
    public init(endpoint: String, key: String) {
        _endpoint = endpoint
        _key = key
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<Response, Error> { completion in
            if !_key.isEmpty {
                if let url = URL(string:  _endpoint + (request?["id"])!){
                    let parameters: Parameters = [
                        "key": _key
                    ]
                    AF.request(url, parameters: parameters)
                        .validate()
                        .responseDecodable(of: Response.self) { response in
                            switch response.result {
                            case .success(let value):
                                completion(.success(value))
                            case .failure:
                                completion(.failure(URLError.invalidResponse))
                            }
                        }
                }
            }
            else {
                print("Doesn't Have API KEY")
            }
        }.eraseToAnyPublisher()
    }
    
}

public struct SearchRemote : DataSource {
    
    public typealias Request = [String : String]
    public typealias Response = [GameResponse]
    private let _endpoint: String
    private let _key: String
    
    public init(endpoint: String, key: String) {
        _endpoint = endpoint
        _key = key
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<Response, Error> { completion in
            if !_key.isEmpty {
                if let url = URL(string: "\(_endpoint)\((request?["query"])!.replacingOccurrences(of: " ", with: "&20", options: .literal, range: nil))&platforms=7,18,4,1"){
                    let parameters: Parameters = [
                        "key": _key
                    ]
                    AF.request(url, parameters: parameters)
                        .validate()
                        .responseDecodable(of: Response.self) { response in
                            switch response.result {
                            case .success(let value):
                                completion(.success(value))
                            case .failure:
                                completion(.failure(URLError.invalidResponse))
                            }
                        }
                }
            }
            else {
                print("Doesn't Have API KEY")
            }
        }.eraseToAnyPublisher()
    }
    
}

