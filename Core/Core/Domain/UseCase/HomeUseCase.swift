//
//  HomeUseCase.swift
//  Core
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation
import Combine

public protocol HomeUseCase {
    func getGames(platformId : String) -> AnyPublisher<[GameModel], URLError>
}
