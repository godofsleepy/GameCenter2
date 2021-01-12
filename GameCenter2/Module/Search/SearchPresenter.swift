//
//  SearchPresenter.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/01/21.
//

import Foundation
import SwiftUI
import Combine

class SearchPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let searchUseCase : SearchUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
    
    func getSearch(query : String) {
        loadingState = true
        searchUseCase.getSearch(query: query)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
}
