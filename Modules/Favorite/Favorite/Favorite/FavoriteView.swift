//
//  FavoriteView.swift
//  Favorite
//
//  Created by Rumah Coding on 12/09/21.
//

import SwiftUI
import GameDomain
import Core
import FavoriteRepo

public struct FavoriteView: View {
    
    public init() {}
    
    @EnvironmentObject var presenter : FavoritesPresenter<Interactor<Any, [DetailModel],GetFavsRepository<FavoriteLocalDataSource, FavoritesTransformer>>>
    
   public var body: some View {
        NavigationView{
            ZStack{
                Color("purple").edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    VStack {
                        if !self.presenter.games.isEmpty {
                            ForEach(self.presenter.games, id:\.self){ game in
                                FavItemView(game: game)
                                
                            }
                        }else {
                            Image("empty").frame(alignment: .center).padding(.top, 50)
                            
                        }
                    }.padding(24)
                    
                }
            }
            .navigationBarTitle("Favorite")
        }
        .onAppear{
            self.presenter.getGames()
        }
    }
}

