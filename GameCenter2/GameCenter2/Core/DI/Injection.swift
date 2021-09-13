//
//  Injection.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import Core
import RealmSwift
import GameDomain
import GameRepo
import FavoriteRepo

final class Injection: NSObject {
    func provideHome<U: UseCase>() -> U where U.Request == [String: String], U.Response == [GameModel] {
        let remote = GetGamesRemote(endpoint: Endpoints.Gets.gamesPlatforms.url, key: API.key)
        let mapper = GameTransform()
        let repository = GetGameRepository(
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideDetail<U: UseCase>() ->  U where U.Request == [String: String], U.Response == DetailModel {
        let remote = GetDetailRemote(endpoint: Endpoints.Gets.gameDetail.url, key: API.key)
        let mapper = DetailTransform()
        let repository = GetDetailRepository(
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideSearch<U: UseCase>() -> U where U.Request == [String: String], U.Response == [GameModel] {
        let remote = SearchRemote(endpoint: Endpoints.Gets.search.url, key: API.key)
        let mapper = GameTransform()
        let repository = SearchRepository(
            remoteDataSource: remote,
            mapper: mapper)

        return Interactor(repository: repository) as! U
    }
    
    func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [DetailModel] {
        let realm = try? Realm()
        let local = FavoriteLocalDataSource(realm: realm!)
        let mapper = FavoritesTransformer()
        let repository = GetFavsRepository(
            localeDataSource: local,
            mapper: mapper)

        return Interactor(repository: repository) as! U
    }
    
    func provideDetailFavorite<U: UseCase>() -> U where U.Request == Int, U.Response == DetailModel {
        let realm = try? Realm()
        let local = FavoriteLocalDataSource(realm: realm!)
        let mapper = FavoriteTransformer()
        let repository = GetFavRepository(
            localeDataSource: local,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    
}
