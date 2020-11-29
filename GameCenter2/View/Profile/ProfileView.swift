//
//  ProfileView.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var data = Profile()
    var body: some View {
        ZStack{
            Color(red: 37 / 255, green: 19 / 255, blue: 51 / 255).edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack(alignment: .leading) {
                    Text("About Application")
                        .foregroundColor(Color(red: 241 / 255, green: 79 / 255, blue: 114 / 255))
                        .font(.system(size: 30))
                        .fontWeight(.semibold).padding(.bottom)
                    
                    Text(data.description_app).foregroundColor(Color.white).padding(.bottom)
                    
                    Text("About Developer")
                        .foregroundColor(Color(red: 241 / 255, green: 79 / 255, blue: 114 / 255))
                        .font(.system(size: 30))
                        .fontWeight(.semibold).padding(.bottom)
                    
                    HStack{
                        Image(data.image)
                            .resizable()
                            .frame(width: 80,height: 80).clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .overlay(
                                Circle().stroke(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255), lineWidth: 4))
                        
                        VStack(alignment: .leading) {
                            Text(data.name).font(.system(size: 24)).fontWeight(.semibold).foregroundColor(Color.white)
                            Text(data.age).font(.system(size: 18)).foregroundColor(Color.white)
                        }.padding(.leading)
                    }.padding(.bottom)
                    
                    Text("Description")
                        .foregroundColor(Color(red: 241 / 255, green: 79 / 255, blue: 114 / 255)).padding(.bottom).font(.system(size: 18))
                    
                    Text(data.description_me).foregroundColor(Color.white)
                }
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading).padding(24)
            
        }.navigationBarTitle("About")
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
