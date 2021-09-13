//
//  HomeView.swift
//  Home
//
//  Created by Rumah Coding on 10/09/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Common
import Core
import GameRepo
import GameDomain

public struct HomeView<ProfileRoute: View, DetailRoute: View>: View {
    
    let profileRoute: (() -> ProfileRoute)
    let detailRoute: ((_ id: Int) -> DetailRoute)
    
    public init(profileRoute: @escaping (() -> ProfileRoute), detailRoute: @escaping ((Int) -> DetailRoute)) {
        self.profileRoute = profileRoute
        self.detailRoute = detailRoute
    }
   

    @EnvironmentObject var presenter : HomePresenter<Interactor<[String: String], [GameModel],GetGameRepository<GetGamesRemote,GameTransform>>>
    @State var index = 0
    @State var selection: Int? = nil
    
    public var body: some View {
        NavigationView{
            ZStack {
                Color("purple").edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("pink"), lineWidth: 5)
                            
                            HStack {
                                Button(action: {
                                    print("Left")
                                    self.index -= 1
                                    if self.index < 0{
                                        self.index = 3
                                    }
                                    self.presenter.getGames(platformId: dataPlatforms[self.index].id)
                                }) {
                                    Image("chevron.left")
                                        .foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                                }
                                
                                CarouselView(index: self.$index.animation(), maxIndex: 3) {
                                    ForEach(dataPlatforms, id: \.self) { platform in
                                        Image(platform.image)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                }
                                
                                Button(action: {
                                    print("Right")
                                    self.index += 1
                                    if self.index == 4{
                                        self.index = 0
                                    }
                                    self.presenter.getGames(platformId: dataPlatforms[self.index].id)
                                    
                                }) {
                                    Image("chevron.right")
                                        .foregroundColor(Color("orange"))
                                }
                            }
                            .padding(10)
                            
                            VStack(alignment: .leading) {
                                Text("platform")
                                    .foregroundColor(Color.white).font(.system(size: 16))
                                Text(dataPlatforms[self.index].name)
                                    .foregroundColor(Color(red: 241 / 255, green: 79 / 255, blue: 114 / 255)).font(.system(size: 33,weight: .semibold))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80, alignment: .topLeading)
                            .padding(30)
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                        .padding(.bottom)
                        
                        Text("Featured")
                            .foregroundColor(Color("pink"))
                            .font(.system(size: 24))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        VStack{
                            if presenter.homeStatus == PresenterStatus.loading {
                                Spinner(isAnimating: true, style: .large).eraseToAnyView()
                            } else if presenter.homeStatus == PresenterStatus.success {
                                ForEach(self.presenter.games, id: \.id){ game in
                                    NavigationLink(destination: self.detailRoute(game.id)) {
                                        GameItemView(game: game)
                                    }
                                }
                            } else if presenter.homeStatus == PresenterStatus.error {
                                Text(presenter.errorMessage).foregroundColor(Color.white)
                                
                            }
                        }
                    }.padding()
                    
                }
                
                
            }
            .navigationBarTitle("Home", displayMode: .automatic)
            .navigationBarItems(trailing: NavigationLink(destination: self.profileRoute(), tag: 1, selection: $selection){
                Button(action: {
                    self.selection = 1
                }) {
                    Image(systemName: "info.circle").foregroundColor(Color("pink")).font(.system(size: 26))
                }
            })
        }
        .onAppear {
            self.presenter.getGames(platformId: "18")
        }
    }
    
}
