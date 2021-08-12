//
//  GetGameRepository.swift
//  Game
//
//  Created by rifat khadafy on 18/02/21.
//

import Core
import Combine

final class GameModuleRepository: NSObject {
    
    typealias GameInstance = (RemoteDataSource) -> GameModuleRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = {  remoteRepo in
        return GameModuleRepository(remote: remoteRepo)
    }
    
}

extension GameModuleRepository: RepositoryProtocol {    
    
    func getSearch(query: String) -> AnyPublisher<[GameModel], Core.URLError> {
        return self.remote.getSearch(query: query)
            .map { GameMapper.mapGamesResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    
    
    func getDetail(gameId: String) -> AnyPublisher<DetailModel, Core.URLError> {
        return  self.remote.getDetail(gameId: gameId)
            .map { GameMapper.mapDetailResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    
    func getGames(platformId : String) -> AnyPublisher<[GameModel], Core.URLError> {
        return self.remote.getGames(platformId: platformId)
            .map { GameMapper.mapGamesResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
}


