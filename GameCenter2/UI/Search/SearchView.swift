//
//  SearchView.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var presenter : SearchPresenter
    @State var query: String = ""

    var body: some View {

        NavigationView{
            ZStack{
                Color(red: 37 / 255, green: 19 / 255, blue: 51 / 255).edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass").foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                            TextField("Search", text:$query, onCommit: {
                                self.presenter.getSearch(query: query)
                            }).foregroundColor(Color.white)


                            if !query.isEmpty {
                                Button(action: {
                                    self.query = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill").foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                                }
                            }
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255), lineWidth: 1))

                    }.padding(.horizontal).padding(.vertical)

                    ScrollView{
                        VStack{
                            if presenter.loadingState {
                                Spinner(isAnimating: true, style: .large).eraseToAnyView()
                            } else {
                                if !self.presenter.games.isEmpty {
                                    ForEach(self.presenter.games, id: \.id){ game in
                                        self.presenter.linkBuilder(for: String(game.id)) {
                                            GameItemView(game: game)
                                        }
                                    }

                                } else {
                                    Image("noFind").frame(alignment: .center).padding(.top, 50)
                                }
                                
                            }

                            
                        }.padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle("Search")
        }
        
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
