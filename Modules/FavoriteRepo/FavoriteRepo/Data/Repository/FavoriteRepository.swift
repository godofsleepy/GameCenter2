//
//  FavoriteRepository.swift
//  FavoriteRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation
import Core
import Combine
import GameDomain

public struct getFavsRepository<
    LocalDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    LocalDataSource.Request == Any,
    LocalDataSource.Response == GameEntity,
    Transformer.Domain == [DetailModel],
    Transformer.Entity == [GameEntity] {
    
    public typealias Request = Any
    public typealias Response = [DetailModel]
    
    private let _localeDataSource: LocalDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: LocalDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[DetailModel], Error> {
        return _localeDataSource.list(request: request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}

public struct GetFavRepository<
    LocalDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    LocalDataSource.Request == Any,
    LocalDataSource.Response == GameEntity,
    Transformer.Domain == DetailModel,
    Transformer.Entity == GameEntity {
    
    public typealias Request = Int
    public typealias Response = DetailModel
    
    private let _localeDataSource: LocalDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: LocalDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return _localeDataSource.get(id: request!)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}

public struct AddFavRepository<
    LocalDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    LocalDataSource.Request == Any,
    LocalDataSource.Response == GameEntity,
    Transformer.Domain == DetailModel,
    Transformer.Entity == GameEntity {
    
    public typealias Request = Int
    public typealias Response = DetailModel
    
    private let _localeDataSource: LocalDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: LocalDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return _localeDataSource.get(id: request!)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}

