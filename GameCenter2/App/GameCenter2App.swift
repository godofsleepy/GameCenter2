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
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)
        WindowGroup {
            ContentView().environmentObject(homePresenter).environmentObject(searchPresenter)
        }
    }
}
