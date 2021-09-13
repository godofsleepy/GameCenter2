//
//  FavoritePresenter.swift
//  Favorite
//
//  Created by Rumah Coding on 12/09/21.
//

import Core
import Combine
import GameDomain

public class FavoritesPresenter<FavoriteUseCase: UseCase> : ObservableObject
where
    FavoriteUseCase.Request == Any,
    FavoriteUseCase.Response == [DetailModel]   {
    private var cancellables: Set<AnyCancellable> = []
    private let favoriteUsecase : FavoriteUseCase
    
    @Published var games: [DetailModel] = []
    @Published var errorMessage: String = ""
    @Published var favoriteStatus: PresenterStatus = PresenterStatus.initial
    
    public init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUsecase = favoriteUseCase
    }
    
    func getGames() {
        self.favoriteUsecase.execute(request: [])
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
                self.favoriteStatus = PresenterStatus.error
            }, receiveValue: { value in
                self.games = value
                self.favoriteStatus = PresenterStatus.success
            })
            .store(in: &cancellables)
    }
    
}
