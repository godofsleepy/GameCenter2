//
//  Router.swift
//  GameCenter2
//
//  Created by Rumah Coding on 11/09/21.
//

import Foundation
import SwiftUI
import Home
import Favorite
import Search

public enum Route {
    case detail
//    case detailFavorite
//    case profile
    case tabHome
}

@ViewBuilder
public func destination(for route: Route) -> some View {
    switch route {
    case .tabHome:
        TabHome()
    case .detail:
        Text("a")
//    default:
//        return TabHome()
        
    }
}
