//
//  DetailInteractor.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/12/20.
//

import Foundation
import Combine


protocol DetailUseCase {
    func getDetail(gameId: String) -> AnyPublisher<DetailModel, Error>
    func AddToFavorite(game: DetailModel) -> AnyPublisher<Bool, Error>
}


class DetailInteractor : DetailUseCase  {
    
    private let repository : GameRepositoryProtocol
    
    
    required init(repository : GameRepositoryProtocol) {
        self.repository = repository
        
    }
    
    func AddToFavorite(game: DetailModel) -> AnyPublisher<Bool, Error> {
        return repository.addFav(game: game)
    }
    
    
    func getDetail(gameId: String) -> AnyPublisher<DetailModel, Error> {
        return repository.getDetail(gameId: gameId)
    }
    
    
    
}
