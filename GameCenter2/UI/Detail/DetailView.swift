//
//  DetailView.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import SwiftUI
import AVKit
import SDWebImageSwiftUI

struct DetailView : View {
    @ObservedObject var presenter : DetailPresenter
    
    var body: some View {
        ScrollView {
            if presenter.loadingState {
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
                                WebImage(url: URL(string: presenter.detail[0].background_image ?? ""))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: abs(geometry.size.height + (geometry.frame(in: .global).minY)))
                                    .clipped()
                                    .offset(y: -geometry.frame(in: .global).minY)
                            } else {
                                WebImage(url: URL(string: presenter.detail[0].background_image ?? ""))
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
                            Text(String(format: "%.2f", presenter.detail[0].rating ))
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
                            Text(presenter.detail[0].name)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                            HStack{
                                Text("Released \(presenter.detail[0].released ?? "uknown")")
                                    .fontWeight(.light)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                
                                Image("calendar")
                                    .foregroundColor(Color("orange"))
                            }
                            
                        }.padding(.bottom)
                        
                        HStack(alignment: .center) {
                            ForEach(presenter.detail[0].genres.indices){ i in
                                if (i < 2) {
                                    Text(presenter.detail[0].genres[i].name)
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                }
                            }
                            
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        
                        if (presenter.detail[0].description != nil ){
                            Text(presenter.detail[0].description!.replacingOccurrences(of: "<[^>]+>", with: "" ,options: .regularExpression, range: nil) )
                                .foregroundColor(.white)
                                .padding(.vertical)
                        }else {
                            Text("no description")
                                .foregroundColor(.white)
                                .padding(.vertical)
                            
                        }
                        
                        ScrollView(.horizontal){
                            HStack{
                                if presenter.detail[0].clip != nil {
                                   
                                    VideoPlayer(player : AVPlayer(url: URL(string : presenter.detail[0].clip ?? "")!))
                                        .cornerRadius(10)
                                        .frame(width: 280, height: 150, alignment: .leading)
                                        .scaledToFit()
                                        .padding(.trailing)
                                        .transition(.move(edge: .bottom)).edgesIgnoringSafeArea(.all)
                                        .onAppear{
                                            
                                        }
                                    
                                }
                                if presenter.detail[0].background_image_additional != nil
                                {
                                    WebImage(url: URL(string: presenter.detail[0].background_image_additional ?? ""))
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
                                ForEach(presenter.detail[0].parent_platforms.indices){ i in
                                    if (presenter.detail[0].parent_platforms[i].platform.slug == "pc" || presenter.detail[0].parent_platforms[i].platform.slug == "xbox" || presenter.detail[0].parent_platforms[i].platform.slug == "playstation" || presenter.detail[0].parent_platforms[i].platform.slug == "nintendo"){
                                        
                                        Image("logo\(presenter.detail[0].parent_platforms[i].platform.slug)")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .background(Color("orange"))
                                            .cornerRadius(100)
                                        
                                    }
                                }                        }
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
                                    if !self.presenter.loadingState {
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
            if !self.presenter.loadingState {
                self.presenter.checkIsFavorite(game: self.presenter.detail[0])
            }
        }
    }
}
