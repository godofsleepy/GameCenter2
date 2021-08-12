//
//  GameRepository.swift
//  Core
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation
import Combine

public protocol RepositoryProtocol {
    func getGames(platformId : String) -> AnyPublisher<[GameModel], URLError>
    func getDetail(gameId : String) -> AnyPublisher<DetailModel, URLError>
    func getSearch(query : String) -> AnyPublisher<[GameModel], URLError>
//    func getListFav() -> AnyPublisher<[DetailModel], Error>
//    func addFav(game : DetailModel) -> AnyPublisher<Bool, Error>
//    func deleteFav(game : DetailModel) -> AnyPublisher<Bool, Error>
//    func checkIsFav(game : DetailModel) -> AnyPublisher<Bool, Error>
}
