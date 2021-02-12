//
//  FavoriteInteractor.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/02/21.
//

import Foundation
import Combine

protocol FavoriteUseCase  {
    func getListFav() -> AnyPublisher<[DetailModel], Error> 
}

class FavoriteInteractor : FavoriteUseCase {
    private let repository : GameRepositoryProtocol
    
    
    required init(repository : GameRepositoryProtocol) {
        self.repository = repository
        
    }
    
    func getListFav() -> AnyPublisher<[DetailModel], Error> {
        return repository.getListFav()
    }
    
}
