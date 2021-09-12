//
//  FavItemView.swift
//  Favorite
//
//  Created by Rumah Coding on 12/09/21.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import GameDomain

struct FavItemView: View {
    var game : DetailModel
    var body: some View {
        HStack {
            WebImage(url: URL(string: game.background_image ?? ""))
                .renderingMode(.original)
                .resizable()
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, alignment: .trailing)
                .cornerRadius(5)
            
            VStack(alignment: .leading){
                Text(game.name)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                
                HStack(alignment: .lastTextBaseline){
                    Text(String(format: "%.2f", game.rating))
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                    Image("star.fill")
                        .foregroundColor(Color("orange"))
                }
                
            }.padding(.leading)
            Spacer()
            
            Image("chevron.right")
                .foregroundColor(Color("orange"))
            
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.bottom)
        
    }
}

