//
//  DetailFavoriteInteractor.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/02/21.
//

import Foundation
import Combine


//protocol DetailFavoriteUseCase {
//    func getDetail(gameId: String) -> AnyPublisher<DetailModel, Error>
//    func addToFavorite(game: DetailModel) -> AnyPublisher<Bool, Error>
//    func deleteFavorite(game: DetailModel) -> AnyPublisher<Bool, Error>
//    func checkIsFav(game: DetailModel) -> AnyPublisher<Bool, Error>
//}
//
//
//class DetailFavoriteInteractor : DetailFavoriteUseCase  {
//    private let repository : GameRepositoryProtocol
//    
//    
//    required init(repository : GameRepositoryProtocol) {
//        self.repository = repository
//        
//    }
//    
//    func deleteFavorite(game: DetailModel) -> AnyPublisher<Bool, Error> {
//        return repository.deleteFav(game: game)
//    }
//    
//    func checkIsFav(game: DetailModel) -> AnyPublisher<Bool, Error> {
//        return repository.checkIsFav(game: game)
//    }
//    
//    func addToFavorite(game: DetailModel) -> AnyPublisher<Bool, Error> {
//        return repository.addFav(game: game)
//    }
//    
//    
//    func getDetail(gameId: String) -> AnyPublisher<DetailModel, Error> {
//        return repository.getDetail(gameId: gameId)
//    }
//}
