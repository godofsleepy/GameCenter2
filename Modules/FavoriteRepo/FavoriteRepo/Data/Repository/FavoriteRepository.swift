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
        return _localeDataSource.get(id: request ?? 0)
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
    
    public typealias Request = DetailModel
    public typealias Response = Bool
    
    private let _localeDataSource: LocalDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: LocalDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        let data = _mapper.transformDomainToEntiry(domain: request!)
        return _localeDataSource.add(entities: [data])
            .eraseToAnyPublisher()
    }
}

public struct DeleteFavRepository<
    LocalDataSource: LocaleDataSource>: Repository
where
    LocalDataSource.Request == Any,
    LocalDataSource.Response == Bool {
    
    public typealias Request = Int
    public typealias Response = Bool
    
    private let _localeDataSource: LocalDataSource
    
    public init(localeDataSource: LocalDataSource) {
        _localeDataSource = localeDataSource
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return _localeDataSource.delete(id: request!)
            .eraseToAnyPublisher()
    }
}

