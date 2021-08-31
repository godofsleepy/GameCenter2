//
//  HomePresenter.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import Foundation
import SwiftUI
import Combine

enum HomeStatus {
    case initial
    case loading
    case success
    case error
}

class HomePresenter: ObservableObject {
    private let router = HomeRouter()
    private var cancellables: Set<AnyCancellable> = []
    private let homeUseCase : HomeUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var homeStatus: HomeStatus = HomeStatus.initial
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGames(platformId : String) {
        homeStatus = HomeStatus.loading
        homeUseCase.getGames(platformId: platformId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    self.homeStatus = HomeStatus.error
                case .finished:
                    self.homeStatus = HomeStatus.success
                }
            }, receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for gameId: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: gameId)) {content()}
    }
}
