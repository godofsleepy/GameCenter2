//
//  DetailFavoritePresenter.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/02/21.
//

import Foundation
import Combine

class DetailFavoritePresenter : ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let detailFavoriteUseCase : DetailFavoriteUseCase
    
    @Published var game: DetailModel
    @Published var isFav : Bool = true
    @Published var errorMessage : String = ""
    
    
    init(detailModel : DetailModel, detailFavoriteUsecase: DetailFavoriteUseCase) {
        self.game = detailModel
        self.detailFavoriteUseCase = detailFavoriteUsecase
    }
    
    func addToFavorite() {
        self.detailFavoriteUseCase.addToFavorite(game: self.game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                
                self.errorMessage = String(describing: error)
                
            }, receiveValue: { value in
                self.isFav = value
            }).store(in: &cancellables)
        
    }
    
    func deleteFavorite() {
        self.detailFavoriteUseCase.deleteFavorite(game: self.game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
            }, receiveValue: { value in
                self.isFav = false
            }).store(in: &cancellables)
        
    }
    
    func checkIsFavorite(){
        self.detailFavoriteUseCase.checkIsFav(game: self.game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
            }, receiveValue: { value in
                self.isFav = value
            }).store(in: &cancellables)
    }
    

}
