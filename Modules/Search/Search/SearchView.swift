//
//  SearchView.swift
//  Search
//
//  Created by Rumah Coding on 12/09/21.
//

import SwiftUI
import GameDomain
import Core
import Common
import GameRepo

public struct SearchView<DetailRoute: View>: View {
    
    let detailRoute: ((_ id: Int) -> DetailRoute)
    
    public init(detailRoute: @escaping ((Int) -> DetailRoute)) {
        self.detailRoute = detailRoute
    }
    
    @EnvironmentObject var presenter : SearchPresenter<
        Interactor<
            [String: String],
            [GameModel],
            SearchRepository<SearchRemote, GameTransform>>>
    @State var query: String = ""
    
    public var body: some View {
        
        NavigationView {
            ZStack {
                Color("purple").edgesIgnoringSafeArea(.all)
                ScrollView {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass").foregroundColor(Color("orange"))
                            TextField("Search", text:$query, onCommit: {
                                self.presenter.getSearch(query: query)
                            }).foregroundColor(Color.white)
                            
                            
                            if !query.isEmpty {
                                Button(action: {
                                    self.query = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill").foregroundColor(Color("orange"))
                                }
                            }
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("orange"), lineWidth: 1))
                        
                    }.padding(.horizontal).padding(.vertical)
                    
                    VStack{
                        if presenter.searchStatus == PresenterStatus.loading {
                            Spinner(isAnimating: true, style: .large).eraseToAnyView()
                        } else {
                            if !self.presenter.games.isEmpty {
                                ForEach(self.presenter.games, id: \.id){ game in
                                    NavigationLink(destination: self.detailRoute(game.id)) {
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
            .navigationBarTitle("Search")
        }
        
    }
}
