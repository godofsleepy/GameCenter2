//
//  HomeInteractor.swift
//  GameCenter2
//
//  Created by rifat khadafy on 05/12/20.
//

import Foundation
import Combine
import Core

class HomeInteractor: HomeUseCase {
    
    private let repository : GameRepositoryProtocol
    
    required init(repository : GameRepositoryProtocol) {
        self.repository = repository
    }
    func getGames(platformId: String) -> AnyPublisher<[GameModel], URLError> {
        return repository.getGames(platformId: platformId)
    }

        
}
