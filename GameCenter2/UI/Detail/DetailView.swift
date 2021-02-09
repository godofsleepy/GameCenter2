//
//  DetailView.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import AVKit

struct DetailView : View {
    @ObservedObject var presenter : DetailPresenter
    @State var index = 0
    @State var selection: Int? = nil
    var player = AVPlayer(url:  URL(string: "https://media.rawg.io/media/stories-640/c10/c10ef05b12482e4d2c647c4e26138d5b.mp4")!)
    
    var body: some View {
        ScrollView {
            if presenter.loadingState {
                Spinner(isAnimating: true, style: .large).eraseToAnyView()
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
                                .foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                        }
                        .frame(width: 75, height: 30)
                        .background(Color(red: 241 / 255, green: 79 / 255, blue: 114 / 255))
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
                                    .foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
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
                            
                        }.frame(minWidth: 0, maxWidth: .infinity).padding(.bottom)
                        
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
                            VideoPlayer(player: player)
                                .onAppear{
                                    player.play()
                                }
                                .frame(width: 280, height: 150, alignment: .leading)
                        }.padding(.bottom)
                        
                        
                        Text("Platform")
                            .foregroundColor(Color(red: 241 / 255, green: 79 / 255, blue: 114 / 255))
                            .fontWeight(.semibold)
                            .font(.system(size: 22))
                        
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(presenter.detail[0].parent_platforms.indices){ i in
                                    if (presenter.detail[0].parent_platforms[i].platform.slug == "pc" || presenter.detail[0].parent_platforms[i].platform.slug == "xbox" || presenter.detail[0].parent_platforms[i].platform.slug == "playstation" || presenter.detail[0].parent_platforms[i].platform.slug == "nintendo"){
                                        
                                        Image("logo\(presenter.detail[0].parent_platforms[i].platform.slug)")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .background(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                                            .cornerRadius(100)
                                        
                                    }
                                }                        }
                        }
                        
                        
                        
                    }
                    .padding()
                    .padding(.bottom, 100)
                    .background(RoundedCorners(color: Color(red: 37 / 255, green: 19 / 255, blue: 51 / 255), tl: 0, tr: 65, bl: 0, br: 0))
                    
                }
            }
            
        }.background(Color(red: 37 / 255, green: 19 / 255, blue: 51 / 255)).edgesIgnoringSafeArea(.all)
        
        .navigationBarItems(trailing:
                                Button(action: {
                                }) {
                                    HStack {
                                        Image(systemName: "heart.fill").foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                                        Text("Fav").foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                                    }                                }
        )
    }
}
