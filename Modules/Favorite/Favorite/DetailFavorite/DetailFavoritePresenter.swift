//
//  DetailFavoritePresenter.swift
//  Favorite
//
//  Created by Rumah Coding on 12/09/21.
//

import Core
import Combine
import GameDomain

public class DetailFavoritePresenter<AddFavoriteUseCase: UseCase,
                              DeleteFavoriteUseCase: UseCase> : ObservableObject
where AddFavoriteUseCase.Request == DetailModel,
      AddFavoriteUseCase.Response == Bool,
      DeleteFavoriteUseCase.Request == Int,
      DeleteFavoriteUseCase.Response == Bool {
    
    private var cancellables: Set<AnyCancellable> = []
    private let addFavoriteUseCase : AddFavoriteUseCase
    private let deleteFavoriteUseCase : DeleteFavoriteUseCase
    
    @Published var game: DetailModel
    @Published var isFav : Bool = true
    @Published var errorMessage : String = ""
    @Published var detailFavStatus: PresenterStatus = PresenterStatus.initial
    
    public init(game: DetailModel, addFavoriteUseCase: AddFavoriteUseCase, deleteFavoriteUseCase: DeleteFavoriteUseCase) {
        self.addFavoriteUseCase = addFavoriteUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
        self.game = game
    }
    
    
    func addToFavorite() {
        self.addFavoriteUseCase.execute(request: self.game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
            }, receiveValue: { value in
                self.isFav = value
            }).store(in: &cancellables)
    }
    
    func deleteFavorite() {
        self.deleteFavoriteUseCase.execute(request: self.game.id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
            }, receiveValue: { value in
                self.isFav = false
            }).store(in: &cancellables)
    }
    
    
    
}

