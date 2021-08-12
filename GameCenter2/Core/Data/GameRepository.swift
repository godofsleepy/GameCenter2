//
//  GameRepository.swift
//  GameCenter2
//
//  Created by rifat khadafy on 02/12/20.
//

import Foundation
import Combine
import Core

protocol GameRepositoryProtocol {
    func getListFav() -> AnyPublisher<[DetailModel], Error>
    func addFav(game : DetailModel) -> AnyPublisher<Bool, Error>
    func deleteFav(game : DetailModel) -> AnyPublisher<Bool, Error>
    func checkIsFav(game : DetailModel) -> AnyPublisher<Bool, Error>
}

final class GameRepository: NSObject {
    
    typealias GameInstance = ( LocaleDataSource) -> GameRepository
    
    fileprivate let locale: LocaleDataSource
    
    private init( locale: LocaleDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { localeRepo in
        return GameRepository(locale: localeRepo)
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
    
}
