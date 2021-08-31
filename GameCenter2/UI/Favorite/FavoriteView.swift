//
//  FavoriteVIew.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var presenter : FavoritePresenter
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("purple").edgesIgnoringSafeArea(.all)

                ScrollView{
                    VStack { 
                        if !self.presenter.games.isEmpty {
                            ForEach(self.presenter.games, id:\.self){ game in
                                self.presenter.linkBuilder(for: game) {
                                    FavGameItemView(game: game)
                                }
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

