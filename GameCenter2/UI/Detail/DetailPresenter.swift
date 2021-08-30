//
//  DetailPresenter.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase : DetailUseCase
    
    @Published var detail: DetailModel?
    @Published var errorMessage: String = ""
    @Published var isFav : Bool = false
    @Published var loadingState: Bool = false
    
    
    init(detailUseCase : DetailUseCase, gameId : String) {
        print("get Detail \(gameId)")
        self.detailUseCase = detailUseCase
        self.getDetail(gameId: gameId)
    }
    
    func getDetail(gameId : String)   {
        print("get detail")
        loadingState = true
        detailUseCase.getDetail(gameId: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [self] completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    print(self.errorMessage)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { value in
                self.detail = value
                print(value)
                
            })
            .store(in: &cancellables)
        
    }
    
    func addToFavorite() {
        detailUseCase.addToFavorite(game: self.detail!)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                
                self.errorMessage = String(describing: error)
                
            }, receiveValue: { value in
                self.isFav = value
            }).store(in: &cancellables)
        
    }
    
    func deleteFavorite() {
        detailUseCase.deleteFavorite(game: self.detail!)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
            }, receiveValue: { value in
                self.isFav = false
            }).store(in: &cancellables)
        
    }
    
    func checkIsFavorite(game : DetailModel){
        detailUseCase.checkIsFav(game: game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
            }, receiveValue: { value in
                self.isFav = value
            }).store(in: &cancellables)
    }

}
