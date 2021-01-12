//
//  FavoriteVIew.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import SwiftUI

struct FavoriteView: View {
    var body: some View {
        NavigationView{
            VStack {
                List {
//                    ForEach(games, id:\.self){ game in
//                        NavigationLink(destination: FavoriteDetailView(data: game)){
//                            FavGameItemView(game: game)
//                        }
//                    }.onDelete(perform: removeGames)
                }
                
            }
                
            .navigationBarTitle("Favorite")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

