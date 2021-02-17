//
//  FavoritePresenter.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/02/21.
//


import Foundation
import Combine
import SwiftUI

class FavoritePresenter : ObservableObject {
    private var router = FavoriteRouter()
    private var cancellables: Set<AnyCancellable> = []
    private let favoriteUsecase : FavoriteUseCase
    
    
    @Published var games: [DetailModel] = []
    @Published var errorMessage: String = ""
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUsecase = favoriteUseCase
    }
    
    func getGames() {
        self.favoriteUsecase.getListFav()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
            }, receiveValue: { value in
                print(value)
                self.games = value
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for game: DetailModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeFavoriteDetailView(for: game)) {content()}
    }
    
}

