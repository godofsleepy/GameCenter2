//
//  Router.swift
//  GameCenter2
//
//  Created by Rumah Coding on 11/09/21.
//

import Foundation

public enum Route {
    case detail
    case detailFavorite
    case profile
    case tabHome
}

@ViewBuilder
public func destination(for route: Route) -> some View {
    switch route {
    case .bottomHome:
        return TabHome()
//    case .detail:
//        return
//    default:
//        return TabHome()
        
    }
}
