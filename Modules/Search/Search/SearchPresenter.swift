//
//  SearchPresenter.swift
//  Search
//
//  Created by Rumah Coding on 12/09/21.
//

import Combine
import GameDomain
import Core

public class SearchPresenter<SearchUseCase: UseCase>: ObservableObject
where
    SearchUseCase.Request == [String: String],
    SearchUseCase.Response == [GameModel] {
    
    private var cancellables: Set<AnyCancellable> = []
    private let searchUseCase : SearchUseCase
    
    @Published public var games: [GameModel] = []
    @Published public var errorMessage: String = ""
    @Published public var searchStatus: PresenterStatus = PresenterStatus.initial
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
    
    func getSearch(query : String) {
        searchStatus = PresenterStatus.loading
        searchUseCase.execute(request: ["query": query])
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [self] completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    self.searchStatus = PresenterStatus.error
                case .finished:
                    searchStatus = PresenterStatus.success
                }
            }, receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
    
}
