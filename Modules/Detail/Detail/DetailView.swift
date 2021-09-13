//
//  DetailView.swift
//  Detail
//
//  Created by Rumah Coding on 12/09/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Common
import Core
import GameDomain
import GameRepo
import FavoriteRepo

public struct DetailView : View {
    @ObservedObject var presenter : DetailPresenter<
        Interactor<[String: String], DetailModel, GetDetailRepository<GetDetailRemote,DetailTransform>>,
        Interactor<DetailModel, Bool, AddFavRepository<FavoriteLocalDataSource, FavoriteTransformer>> ,
        Interactor<Int, Bool, DeleteFavRepository<FavoriteLocalDataSource>>,
        Interactor<Int, DetailModel, GetFavRepository<FavoriteLocalDataSource, FavoriteTransformer>>
    >
    
    public var body: some View {
        ScrollView {
            if presenter.detailStatus == PresenterStatus.loading {
                HStack{
                    Spacer()
                    Spinner(isAnimating: true, style: .large).eraseToAnyView()
                    Spacer()
                }.padding(.top, 100)
            }
            else {
                ZStack(alignment: .top){
                    GeometryReader { geometry in
                        VStack {
                            if geometry.frame(in: .global).minY <= 0 {
                                WebImage(url: URL(string: presenter.detail!.background_image ?? ""))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: abs(geometry.size.height + (geometry.frame(in: .global).minY)))
                                    .clipped()
                                    .offset(y: -geometry.frame(in: .global).minY)
                            } else {
                                WebImage(url: URL(string: presenter.detail!.background_image ?? ""))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                            }
                        }
                    }
                    .frame(height: 400)
                    .alignmentGuide(.top) { _ in 340 }
                    
                    HStack{
                        Spacer()
                        HStack{
                            Text(String(format: "%.2f", presenter.detail!.rating ))
                                .font(.system(size: 18))
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                            Image("star.fill")
                                .foregroundColor(Color("orange"))
                        }
                        .frame(width: 75, height: 30)
                        .background(Color("pink"))
                        .cornerRadius(10)
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .zIndex(1)
                    .padding(.trailing,32)
                    .alignmentGuide(.top) { _ in 15 }
                    
                    
                    VStack(alignment: .leading){
                        VStack(alignment: .leading, spacing :10) {
                            Text(presenter.detail!.name)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                            HStack{
                                Text("Released \(presenter.detail!.released ?? "uknown")")
                                    .fontWeight(.light)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                
                                Image("calendar")
                                    .foregroundColor(Color("orange"))
                            }
                            
                        }.padding(.bottom)
                        
                        HStack(alignment: .center) {
                            ForEach(presenter.detail!.genres.indices){ i in
                                if (i < 2) {
                                    Text(presenter.detail!.genres[i].name)
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                }
                            }
                            
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        
                        if (presenter.detail!.description != nil ){
                            Text(presenter.detail!.description!.replacingOccurrences(of: "<[^>]+>", with: "" ,options: .regularExpression, range: nil) )
                                .foregroundColor(.white)
                                .padding(.vertical)
                        }else {
                            Text("no description")
                                .foregroundColor(.white)
                                .padding(.vertical)
                            
                        }
                        
                        ScrollView(.horizontal){
                            HStack{
                                
                                if presenter.detail!.background_image_additional != nil
                                {
                                    WebImage(url: URL(string: presenter.detail!.background_image_additional ?? ""))
                                        .renderingMode(.original)
                                        .resizable()
                                        .indicator(.activity)
                                        .transition(.fade(duration: 0.5))
                                        .frame(width: 280, height: 150, alignment: .leading).scaledToFit()
                                        .cornerRadius(10)
                                }
                            }
                        }.padding(.bottom)
                        
                        
                        
                        Text("Platform")
                            .foregroundColor(Color("pink"))
                            .fontWeight(.semibold)
                            .font(.system(size: 22))
                        
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(presenter.detail!.parent_platforms.indices){ i in
                                    if (presenter.detail!.parent_platforms[i].platform.slug == "pc" || presenter.detail!.parent_platforms[i].platform.slug == "xbox" || presenter.detail!.parent_platforms[i].platform.slug == "playstation" || presenter.detail!.parent_platforms[i].platform.slug == "nintendo"){
                                        
                                        Image("logo\(presenter.detail!.parent_platforms[i].platform.slug)")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .background(Color("orange"))
                                            .cornerRadius(100)
                                        
                                    }
                                }
                                
                            }
                        }
                        
                    }
                    .padding()
                    .padding(.bottom, 100)
                    .background(RoundedCorners(color: Color("purple"), tl: 0, tr: 65, bl: 0, br: 0))
                    
                }
            }
            
        }
        .background(Color("purple")).edgesIgnoringSafeArea(.all)
        
        .navigationBarItems(trailing:
                                Button(action: {
                                    print("tap")
                                    if self.presenter.detailStatus == PresenterStatus.loading {
                                        self.presenter.isFav ? self.presenter.deleteFavorite(): self.presenter.addToFavorite()
                                    }
                                    
                                }) {
                                    HStack {
                                        Image(systemName: self.presenter.isFav ? "heart.fill" : "heart").foregroundColor(Color("orange"))
                                        Text("Fav").foregroundColor(Color("orange"))
                                    }
                                    
                                }
        )
        .onAppear{
            if self.presenter.detailStatus == PresenterStatus.loading {
                self.presenter.checkIsFavorite(game: self.presenter.detail!)
            }
        }
    }
}
