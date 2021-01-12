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
                                ForEach(self.presenter.games, id: \.id){ game in
                                    self.presenter.linkBuilder(for: String(game.id)) {
                                        GameItemView(game: game)
                                    }
                                }
                            }

                            
                        }.padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle("Search")
        }
        
    }

//    private var content: some View {
//        switch model.state {
//        case .idle:
//            return Color.clear.eraseToAnyView()
//        case .loading:
//            return Spinner(isAnimating: true, style: .large).eraseToAnyView()
//        case .error(let error):
//            return Text(error.localizedDescription).foregroundColor(Color.white).eraseToAnyView()
//        case .loaded(let games):
//            return list(of: games).eraseToAnyView()
//        }
//    }
//
//    private func list(of games: [ListGame]) -> some View {
//        return ForEach(games){ game in
//            NavigationLink(destination: DetailView(model: DetailViewModel(gameId: String(game.id)))){
//                GameItemView(game: game)
//            }
//        }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0,trailing: 0))
//    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
