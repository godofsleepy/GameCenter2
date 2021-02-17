//
//  SearchBar.swift
//  GameCenter
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))

                TextField("Search", text: $text).foregroundColor(Color.white)
                    .accentColor(.white)

                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").foregroundColor(Color(red: 247 / 255, green: 164 / 255, blue: 10 / 255))
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.white)
            .background(Color(red: 37 / 255, green: 19 / 255, blue: 51 / 255))
            .cornerRadius(10.0)
        }.padding(.horizontal)
    }
}

