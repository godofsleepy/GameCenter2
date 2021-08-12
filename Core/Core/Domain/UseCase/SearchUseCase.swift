//
//  SearchUseCase.swift
//  Core
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation
import Combine

public protocol SearchUseCase {
    func getSearch(query : String) -> AnyPublisher<[GameModel], URLError>
}
