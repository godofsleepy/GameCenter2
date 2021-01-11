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

}

final class GameRepository: NSObject {

  typealias GameInstance = (RemoteDataSource) -> GameRepository

  fileprivate let remote: RemoteDataSource
//  fileprivate let locale: LocaleDataSource

  private init(remote: RemoteDataSource) {
//    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: GameInstance = { remoteRepo in
    return GameRepository(remote: remoteRepo)
  }

}

extension GameRepository: GameRepositoryProtocol {
    func getDetail(gameId: String) -> AnyPublisher<DetailModel, Error> {
        self.remote.getDetail(gameId: gameId)
            .map { GameMapper.mapDetailResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    

    func getGames(platformId : String) -> AnyPublisher<[GameModel], Error> {
        self.remote.getGames(platformId: platformId)
            .map { GameMapper.mapGamesResponsesToDomains(input: $0) }
        .eraseToAnyPublisher()
  }
}

