//
//  RemoteDataSourceProtocol.swift
//  Core
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation
import Combine

//public protocol RemoteDataSourceProtocol {
//    func geModuleGames(platformId : String) -> AnyPublisher<[GameResponse], URLError>
//    func getModuleDetail(gameId : String) -> AnyPublisher<DetailResponse, URLError>
//    func getModuleSearch(query : String) -> AnyPublisher<[GameResponse], URLError>
//}

public protocol RemoteModuleDataSourceProtocol {
    func getGames(platformId : String) -> AnyPublisher<[GameResponse], URLError>
    func getDetail(gameId : String) -> AnyPublisher<DetailResponse, URLError>
    func getSearch(query : String) -> AnyPublisher<[GameResponse], URLError>
    //    func getListFav() -> AnyPublisher<[DetailModel], Error>
    //    func addFav(game : DetailModel) -> AnyPublisher<Bool, Error>
    //    func deleteFav(game : DetailModel) -> AnyPublisher<Bool, Error>
    //    func checkIsFav(game : DetailModel) -> AnyPublisher<Bool, Error>
}

