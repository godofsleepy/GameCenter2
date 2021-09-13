//
//  ProfileView.swift
//  Profile
//
//  Created by Rumah Coding on 11/09/21.
//

import SwiftUI

public struct ProfileView: View {
    public init() {}
    
    @Environment(\.openURL) var openURL
    
    var data = Profile()
    public var body: some View {
        ZStack{
            Color(red: 37 / 255, green: 19 / 255, blue: 51 / 255).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("About Application")
                    .foregroundColor(Color("pink"))
                    .font(.system(size: 30))
                    .fontWeight(.semibold).padding(.bottom)
                
                Text(data.description_app).foregroundColor(Color.white).padding(.bottom)
                
                Text("About Developer")
                    .foregroundColor(Color("pink"))
                    .font(.system(size: 30))
                    .fontWeight(.semibold).padding(.bottom)
                
                HStack{
                    Image(data.image)
                        .resizable()
                        .frame(width: 80,height: 80).clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(data.name).font(.system(size: 24)).fontWeight(.semibold).foregroundColor(Color.white)
                        Text(data.age).font(.system(size: 18)).foregroundColor(Color.white)
                    }.padding(.leading)
                }.padding(.bottom)
                
                Text("Description")
                    .foregroundColor(Color("pink")).padding(.bottom).font(.system(size: 18))
                
                Text(data.description_me).foregroundColor(Color.white).padding(.bottom)
                
                HStack {
                    Button("Linkedin") {
                        openURL(URL(string: "https://www.linkedin.com/in/rifat-khadafy-b05378159/")!)
                    }.foregroundColor(Color("orange"))
                    
                    Button("Github") {
                        openURL(URL(string: "https://github.com/godofsleepy")!)
                    }.foregroundColor(Color("orange"))

                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            
        }
        
        
        .navigationBarTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct Profile : Hashable {
    let description_app = "Ini adalah aplikasi lanjutan saya dari kelas IOS Fundamental Dicoding"
    let description_me = "Hai perkenalkan nama saya Rifat Khadafy seorang Fresh Graduate dari suatu SMK di Depok, saya sekarang masih mencari kesempatan untuk sebuah pekerjaan."
    let name = "Rifat Khadafy"
    let age = "18"
    let image = "me"
}



