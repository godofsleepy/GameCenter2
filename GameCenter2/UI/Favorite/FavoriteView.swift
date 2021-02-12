//
//  FavoriteVIew.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter : FavoritePresenter
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 37 / 255, green: 19 / 255, blue: 51 / 255).edgesIgnoringSafeArea(.all)

                ScrollView{
                    VStack { 
                        ForEach(self.presenter.games, id:\.self){ game in
                            self.presenter.linkBuilder(for: game) {
                                FavGameItemView(game: game)
                            }
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

