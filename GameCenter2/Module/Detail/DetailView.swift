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

struct DetailView : View {
    @ObservedObject var model : DetailViewModel
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: GameFav.entity(), sortDescriptors: []) var games : FetchedResults<GameFav>
    
    var body: some View{
        contentDetail
            .onAppear { self.model.send(event: .onAppear) }
    }
    
    private var contentDetail: some View {
        switch model.state {
        case .idle:
            return Color.clear.eraseToAnyView() 
        case .loading:
            return Spinner(isAnimating: true, style: .large).eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded(let game):
            return self.detail(data : game).eraseToAnyView()
        }
    }
    
    private func detail(data : GameDetail) -> some View {
        ScrollView {
            ZStack(alignment: .top){
                GeometryReader { geometry in
                    VStack {
                        if geometry.frame(in: .global).minY <= 0 {
                            WebImage(url: URL(string: data.background_image ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                                .clipped()
                                .offset(y: -geometry.frame(in: .global).minY)
                        } else {
                            WebImage(url: URL(string: data.background_image ?? ""))
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
                        Text(String(format: "%.2f", data.rating))
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
                    VStack(alignment: .leading) {
                        Text(data.name)
                            .fontWeight(.semibold)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        
                        HStack{
                            Text("Released \(data.released ?? "uknown")")
                                .fontWeight(.light)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            
                            Image("calendar")
                                .foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                        }
                        
                    }.padding(.bottom)
                    
                    HStack(alignment: .center) {
                        ForEach(data.genres.indices){ i in
                            if (i < 2) {
                                Text(data.genres[i].name)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                
                            }
                        }
                        
                    }.frame(minWidth: 0, maxWidth: .infinity).padding(.bottom)
                    
                    if (data.description != nil ){
                        Text(data.description!.replacingOccurrences(of: "<[^>]+>", with: "" ,options: .regularExpression, range: nil) )
                            .foregroundColor(.white)
                            .padding(.vertical)
                    }else {
                        Text("no description")
                            .foregroundColor(.white)
                            .padding(.vertical)
                        
                    }
                    
                    
                    HStack(alignment: .center){
                        if (true == true) {
                            Button(action: {
//                                self.deleteGame(id: data.id)
//                                try? self.moc.save()
                            }) {
                                HStack {
                                    Image(systemName: "plus").foregroundColor(.white)
                                    Text("Add to favorite").foregroundColor(.white)
                                }.padding(7)
                                    .background(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                                    .cornerRadius(30)
                            }
                        }else {
                            Button(action: {
//                                self.AddGame(data: data)
//                                try? self.moc.save()
                            }) {
                                HStack {
                                    Image(systemName: "plus").foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                                    Text("Add to favorite").foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                                }.padding(7)
                                    .overlay( RoundedRectangle(cornerRadius: 20).stroke(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255), lineWidth: 2)
                                )
                            }
                            
                        }
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    
                    Text("Platform")
                        .foregroundColor(Color(red: 241 / 255, green: 79 / 255, blue: 114 / 255))
                        .fontWeight(.semibold)
                        .font(.system(size: 22))
                    
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(data.parent_platforms.indices){ i in
                                if (data.parent_platforms[i].platform.slug == "pc" || data.parent_platforms[i].platform.slug == "xbox" || data.parent_platforms[i].platform.slug == "playstation" || data.parent_platforms[i].platform.slug == "nintendo"){
                                    
                                    Image("logo\(data.parent_platforms[i].platform.slug)")
                                        .background(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                                        .cornerRadius(100)
                                    
                                }
                            }                        }
                    }
                    
                    
                }
                .padding()
                .background(RoundedCorners(color: Color(red: 37 / 255, green: 19 / 255, blue: 51 / 255), tl: 0, tr: 65, bl: 0, br: 0))
                
            }
        }.background(Color(red: 37 / 255, green: 19 / 255, blue: 51 / 255)).edgesIgnoringSafeArea(.all)
        
    }
    
//    private func checkID(id : Int) -> Bool {
//        for game in games {
//            if game.wrappedId == id {
//                return true
//            }
//        }
//        return false
//    }
    
    
//    private func deleteGame(id : Int)  {
//        for game in games {
//            if game.wrappedId == id {
//                moc.delete(game)
//            }
//        }
//    }
    
//    private func AddGame(data: GameDetail){
//        let country = GameFav(context: self.moc)
//        country.id = Int64(data.id)
//        country.name = data.name
//        country.desc = data.description
//        country.image = data.background_image
//        country.rating = data.rating
//        country.released = data.released
//        country.genre = data.getGenre() as [NSString]
//        country.plaform = data.getPlatform() as [NSString]
//    }
    
}
