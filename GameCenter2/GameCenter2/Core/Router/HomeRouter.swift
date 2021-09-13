//
//  DetailRouter.swift
//  GameCenter2
//
//  Created by Rumah Coding on 13/09/21.
//

import SwiftUI
import Profile
import Detail
import Core
import GameDomain
import GameRepo
import FavoriteRepo

class HomeRouter {
    
    let injection = Injection()
    
    func routeToDetail(for gameid: String) -> DetailView {
        let getdetailUseCase: Interactor<[String: String], DetailModel, GetDetailRepository<GetDetailRemote,DetailTransform>> = injection.provideGetDetail()
        let addFavoriteUseCase: Interactor<DetailModel, Bool, AddFavRepository<FavoriteLocalDataSource, FavoriteTransformer>> = injection.provideAddFavorite()
        let deleteFavoriteUseCase: Interactor<Int, Bool, DeleteFavRepository<FavoriteLocalDataSource>> = injection.provideDeleteFavorite()
        let getFavUseCase: Interactor<Int, DetailModel, GetFavRepository<FavoriteLocalDataSource, FavoriteTransformer>> = injection.provideGetFavorite()
        
        let presenter = DetailPresenter(
            id: gameid,
            _getDetailUseCase: getdetailUseCase,
            _addFavoriteUseCase: addFavoriteUseCase,
            _deleteFavoriteUseCase: deleteFavoriteUseCase,
            _getFavoriteUseCase: getFavUseCase)
        return DetailView(presenter: presenter)
    }
    
    func routeToProfile() -> ProfileView {
        return ProfileView()
    }
}
