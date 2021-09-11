//
//  ContentView.swift
//  GameCenter2
//
//  Created by rifat khadafy on 16/11/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var destination: [Destination]
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        //        Mengganti warna background list
        UITableView.appearance().backgroundColor = UIColor(red: 37/255.0, green: 19/255.0, blue: 51/255.0, alpha: 1.0)
        
        UITableViewCell.appearance().backgroundColor = UIColor(red: 37/255.0, green: 19/255.0, blue: 51/255.0, alpha: 1.0)
        
        UITabBar.appearance().barTintColor = UIColor(red: 37/255.0, green: 19/255.0, blue: 51/255.0, alpha: 10.0)
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 241/255.0, green: 79/255.0, blue: 114/255.0, alpha: 1.0)]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:UIColor(red: 241/255.0, green: 79/255.0, blue: 114/255.0, alpha: 1.0)]
        UINavigationBar.appearance().barTintColor = UIColor(red: 37/255.0, green: 19/255.0, blue: 51/255.0, alpha: 10.0)
        
    }
    
    var body: some View {
        List(destination) {
            NavigationLink(destination: destination(for: $0))
        }
    }
}

struct TabHome: View {
    var body :some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
        }
        .preferredColorScheme(.light)
        .accentColor(Color(red: 241 / 255, green: 79 / 255, blue: 114 / 255))
    }
}
