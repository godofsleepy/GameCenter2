//
//  LocaleDataSource.swift
//  GameCenter2
//
//  Created by rifat khadafy on 11/02/21.
//

import Foundation
import  RealmSwift
import Combine

protocol LocaleDataSourceProtocol: class {
    
    func getList() -> AnyPublisher<[GameEntity], Error>
    func addGame(from game: GameEntity) -> AnyPublisher<Bool, Error>
    //    func deleteGame(from id : String) -> AnyPublisher<Bool, Error>
    
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
                        print("yes bisa")
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
    
    //    func deleteGame(from id: String) -> AnyPublisher<Bool, Error> {
    //
    //    }
    
    
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

