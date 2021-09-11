//
//  HomePresenter.swift
//  Home
//
//  Created by Rumah Coding on 10/09/21.
//

import Combine
import Core
import GameDomain
import Foundation

public class HomePresenter<HomeUseCase: UseCase>: ObservableObject
where
    HomeUseCase.Request == [String: String],
    HomeUseCase.Response == [GameModel] {
    
    private var cancellables: Set<AnyCancellable> = []
    private let _homeUseCase: HomeUseCase
    
    @Published public var games: [GameModel] = []
    @Published public var errorMessage: String = ""
    @Published public var homeStatus: PresenterStatus = PresenterStatus.initial

    internal init(_homeUseCase: HomeUseCase) {
        self._homeUseCase = _homeUseCase
    }
    
    func getGames(platformId : String) {
        homeStatus = PresenterStatus.loading
        _homeUseCase.execute(request: ["platformId" : platformId])
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    self.homeStatus = PresenterStatus.error
                case .finished:
                    self.homeStatus = PresenterStatus.success
                }
            }, receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
    

}
