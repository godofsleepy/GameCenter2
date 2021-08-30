//
//  LocaleDataSource.swift
//  GameCenter2
//
//  Created by rifat khadafy on 11/02/21.
//

import Foundation
import  RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getList() -> AnyPublisher<[GameEntity], Error>
    func addGame(from game: GameEntity) -> AnyPublisher<Bool, Error>
    func deleteGame(from id : Int) -> AnyPublisher<Bool, Error>
    func checkIsFav(from id :Int) -> AnyPublisher<Bool, Error>
    
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource : LocaleDataSourceProtocol {
    func checkIsFav(from id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let isExist =  realm.object(ofType: GameEntity.self, forPrimaryKey: id)
                    completion(.success((isExist != nil)))
                    
                }            } else {
                    completion(.failure(DatabaseError.invalidInstance))
                }
        }.eraseToAnyPublisher()
        
    }
    
    func deleteGame(from id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.delete(realm.object(ofType: GameEntity.self, forPrimaryKey: id)!)
                        print("yess")
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getList() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .sorted(byKeyPath: "id", ascending: true)
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGame(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        
                        realm.add(game, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}

