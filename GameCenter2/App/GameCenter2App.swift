//
//  GameCenter2App.swift
//  GameCenter2
//
//  Created by rifat khadafy on 16/11/20.
//

import SwiftUI

@main
struct GameCenter2App: App {
    
    var body: some Scene {
        let homeUseCase = Injection.init().provideHome()
        let searchUseCase = Injection.init().provideSearch()
        let favoriteUseCase = Injection.init().provideFavorite()
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)
        let favoritePresenter = FavoritePresenter(favoriteUseCase : favoriteUseCase)
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(searchPresenter)
                .environmentObject(favoritePresenter)
            
        }
    }
}
