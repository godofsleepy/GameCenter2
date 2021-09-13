//
//  DetailPresenter.swift
//  Detail
//
//  Created by Rumah Coding on 12/09/21.
//

import Combine
import Core
import GameDomain

public class DetailPresenter<
    GetDetailUseCase: UseCase,
    AddFavoriteUseCase: UseCase,
    DeleteFavoriteUseCase: UseCase,
    GetFavoriteUseCase: UseCase> : ObservableObject
where
    GetDetailUseCase.Request == [String: String],
    GetDetailUseCase.Response == DetailModel,
    AddFavoriteUseCase.Request == DetailModel,
    AddFavoriteUseCase.Response == Bool,
    DeleteFavoriteUseCase.Request == Int,
    DeleteFavoriteUseCase.Response == Bool,
    GetFavoriteUseCase.Request == Int,
    GetFavoriteUseCase.Response == DetailModel  {
    
    private var cancellables: Set<AnyCancellable> = []
    private let _getDetailUseCase : GetDetailUseCase
    private let _addFavoriteUseCase : AddFavoriteUseCase
    private let _deleteFavoriteUseCase : DeleteFavoriteUseCase
    private let _getFavoriteUseCase : GetFavoriteUseCase
    
    @Published var detail: DetailModel?
    @Published var errorMessage: String = ""
    @Published var isFav : Bool = false
    @Published var detailStatus: PresenterStatus = PresenterStatus.initial
    
    public init(id: String, _getDetailUseCase: GetDetailUseCase, _addFavoriteUseCase: AddFavoriteUseCase, _deleteFavoriteUseCase: DeleteFavoriteUseCase, _getFavoriteUseCase: GetFavoriteUseCase) {
        self._getDetailUseCase = _getDetailUseCase
        self._addFavoriteUseCase = _addFavoriteUseCase
        self._deleteFavoriteUseCase = _deleteFavoriteUseCase
        self._getFavoriteUseCase = _getFavoriteUseCase
        self.getDetail(gameId: id)
    }
    
    func getDetail(gameId : String)   {
        detailStatus = PresenterStatus.loading
        _getDetailUseCase.execute(request: ["id": gameId])
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [self] completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    detailStatus = PresenterStatus.error
                case .finished:
                    detailStatus = PresenterStatus.success
                }
            }, receiveValue: { value in
                self.detail = value
                self.checkIsFavorite(game: value)
            })
            .store(in: &cancellables)
        
    }
    
    func addToFavorite() {
        _addFavoriteUseCase.execute(request: detail!)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
            }, receiveValue: { value in
                self.isFav = value
            }).store(in: &cancellables)
    }
    
    func deleteFavorite() {
        _deleteFavoriteUseCase.execute(request: detail?.id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
            }, receiveValue: { value in
                self.isFav = false
            }).store(in: &cancellables)
        
    }
    
    func checkIsFavorite(game : DetailModel){
        _getFavoriteUseCase.execute(request: game.id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                self.errorMessage = String(describing: error)
                print(self.errorMessage)
            }, receiveValue: { value in
                print(value)
                //                if(value != nil){
                self.isFav = true
                //                }else {
                //                    self.isFav = false
                //                }
            }).store(in: &cancellables)
    }
    
}

