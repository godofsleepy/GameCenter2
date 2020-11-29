//
//  GameItemView.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImage
import SDWebImageSwiftUI


struct GameItemView : View{
    var game : ListGame
    var body : some View {
        HStack {
            WebImage(url: URL(string: game.background_image ?? ""))
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, alignment: .trailing)
                .cornerRadius(5)
            
            VStack(alignment: .leading){
                Text(game.name)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                
                Text(game.released ?? "uknown")
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                
                HStack(alignment: .lastTextBaseline){
                    Text(String(format: "%.2f", game.rating))
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                    Image("star.fill")
                        .foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                }
                
            }.padding(.leading)
            Spacer()
            
            Image("chevron.right")
                .foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
            
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.bottom)
        
    }
    
}

