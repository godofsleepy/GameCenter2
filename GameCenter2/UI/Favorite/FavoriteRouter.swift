//
//  FavoriteRouter.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/02/21.
//

import Foundation
import SwiftUI

class FavoriteRouter {
    func makeFavoriteDetailView(for game: DetailModel) -> some View {
        let presenter = DetailFavoritePresenter(detailModel: game)
        return DetailFavoriteView(presenter: presenter)
    }
}
