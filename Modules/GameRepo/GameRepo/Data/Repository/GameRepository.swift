//
//  GameRepository.swift
//  GameRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation
import Core
import Combine

public struct GetGameRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper> : Repository
where
    RemoteDataSource.Request == [String: String],
    RemoteDataSource.Response == [GameResponse],
    Transformer.Response == [GameResponse],
    Transformer.Domain == [GameModel] {
    
    public typealias Request = [String : String]
    public typealias Response = [GameModel]
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return _remoteDataSource.execute(request: request)
            .map {_mapper.transformResponseToDomain(response: $0)}
            .eraseToAnyPublisher()
    }
}
