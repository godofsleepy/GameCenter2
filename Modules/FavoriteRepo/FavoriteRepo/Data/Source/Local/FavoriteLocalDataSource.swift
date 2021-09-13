//
//  LocalDataSource.swift
//  FavoriteRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct FavoriteLocalDataSource : LocaleDataSource {    
    
    public typealias Request = Any
    public typealias Response = GameEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            let games: Results<GameEntity> = {
                _realm.objects(GameEntity.self)
                    .sorted(byKeyPath: "id", ascending: true)
            }()
            completion(.success(games.toArray(ofType: GameEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    _realm.add(entities[0], update: .all)
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            do {
                if let entity = _realm.object(ofType: GameEntity.self, forPrimaryKey: id){
                    completion(.success(entity))
                }else {
                    completion(.failure(DatabaseError.requestFailed))
                }
                
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: GameEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func delete(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    _realm.delete(_realm.object(ofType: GameEntity.self, forPrimaryKey: id)!)
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
}
