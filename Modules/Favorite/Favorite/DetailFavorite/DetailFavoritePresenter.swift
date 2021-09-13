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
                              DeleteFavoriteUseCase: UseCase,
                              GetFavoriteUseCase: UseCase> : ObservableObject
where AddFavoriteUseCase.Request == DetailModel,
      AddFavoriteUseCase.Response == Bool,
      DeleteFavoriteUseCase.Request == Int,
      DeleteFavoriteUseCase.Response == Bool,
      GetFavoriteUseCase.Request == Int,
      GetFavoriteUseCase.Response == DetailModel  {
    
    private var cancellables: Set<AnyCancellable> = []
    private let addFavoriteUseCase : AddFavoriteUseCase
    private let deleteFavoriteUseCase : DeleteFavoriteUseCase
    private let getFavoriteUseCase : GetFavoriteUseCase
    
    @Published var game: DetailModel
    @Published var isFav : Bool = true
    @Published var errorMessage : String = ""
    @Published var detailFavStatus: PresenterStatus = PresenterStatus.initial
    
    public init(game: DetailModel, addFavoriteUseCase: AddFavoriteUseCase, deleteFavoriteUseCase: DeleteFavoriteUseCase, getFavoriteUseCase: GetFavoriteUseCase) {
        self.addFavoriteUseCase = addFavoriteUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
        self.getFavoriteUseCase = getFavoriteUseCase
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
    
    func checkIsFavorite(){
        getFavoriteUseCase.execute(request: game.id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
                self.isFav = false
            }, receiveValue: { value in
                //                if(value != nil){
                self.isFav = true
                //                }else {
                //                    self.isFav = false
                //                }
            }).store(in: &cancellables)
        
    }
    
    
}

