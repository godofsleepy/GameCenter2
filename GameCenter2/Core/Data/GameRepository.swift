//
//  GameRepository.swift
//  GameCenter2
//
//  Created by rifat khadafy on 02/12/20.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
    func getGames(platformId : String) -> AnyPublisher<[GameModel], Error>
    func getDetail(gameId : String) -> AnyPublisher<DetailModel, Error>
    func getSearch(query : String) -> AnyPublisher<[GameModel], Error>
    func getListFav() -> AnyPublisher<[DetailModel], Error>
    func addFav(game : DetailModel) -> AnyPublisher<Bool, Error>
    func deleteFav(game : DetailModel) -> AnyPublisher<Bool, Error>
    func checkIsFav(game : DetailModel) -> AnyPublisher<Bool, Error>
}

final class GameRepository: NSObject {
    
    typealias GameInstance = (RemoteDataSource, LocaleDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = {  remoteRepo, localeRepo in
        return GameRepository(remote: remoteRepo, locale: localeRepo)
    }
    
}

extension GameRepository: GameRepositoryProtocol {
    func checkIsFav(game: DetailModel) -> AnyPublisher<Bool, Error> {
        return self.locale
            .checkIsFav(from: game.id)
            .eraseToAnyPublisher()
    }
    
    func getListFav() -> AnyPublisher<[DetailModel], Error> {
        return self.locale.getList()
            .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func addFav(game: DetailModel) -> AnyPublisher<Bool, Error> {
        return self.locale
            .addGame(from : GameMapper.mapDetailDomainToEntitiy(input: game))
            .eraseToAnyPublisher()
    }
    
    func deleteFav(game: DetailModel) -> AnyPublisher<Bool, Error> {
        return self.locale
            .deleteGame(from: game.id)
            .eraseToAnyPublisher()
    }
    
    func getSearch(query: String) -> AnyPublisher<[GameModel], Error> {
        return self.remote.getSearch(query: query)
            .map { GameMapper.mapGamesResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    
    
    func getDetail(gameId: String) -> AnyPublisher<DetailModel, Error> {
        return  self.remote.getDetail(gameId: gameId)
            .map { GameMapper.mapDetailResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    
    func getGames(platformId : String) -> AnyPublisher<[GameModel], Error> {
        return self.remote.getGames(platformId: platformId)
            .map { GameMapper.mapGamesResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
}


