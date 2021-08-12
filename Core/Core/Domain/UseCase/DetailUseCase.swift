//
//  DetailUseCase.swift
//  Core
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation
import Combine

public protocol DetailUseCase {
    func getDetail(gameId: String) -> AnyPublisher<DetailModel, URLError>
//    func addToFavorite(game: DetailModel) -> AnyPublisher<Bool, Error>
//    func deleteFavorite(game: DetailModel) -> AnyPublisher<Bool, Error>
//    func checkIsFav(game: DetailModel) -> AnyPublisher<Bool, Error>
}


