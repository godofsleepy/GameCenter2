//
//  GameCenter2App.swift
//  GameCenter2
//
//  Created by rifat khadafy on 16/11/20.
//

import SwiftUI
import Core
import Favorite
import GameDomain
import GameRepo
import FavoriteRepo
import Home
import Search

@main
struct GameCenter2App: App {
    
    var body: some Scene {
        let injection = Injection()
        let homeUseCase: Interactor<[String: String], [GameModel],GetGameRepository<GetGamesRemote,GameTransform>> = injection.provideHome()
        let searchUseCase: Interactor<
            [String: String],
            [GameModel],
            SearchRepository<SearchRemote, GameTransform>> = injection.provideSearch()
        let favoriteUseCase: Interactor<Any, [DetailModel],GetFavsRepository<FavoriteLocalDataSource, FavoritesTransformer>> = injection.provideFavorite()

        let homePresenter = HomePresenter(_homeUseCase: homeUseCase)
        let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)
        let favoritePresenter = FavoritesPresenter(favoriteUseCase : favoriteUseCase)
        
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(searchPresenter)
                .environmentObject(favoritePresenter)
            
        }
    }
}
