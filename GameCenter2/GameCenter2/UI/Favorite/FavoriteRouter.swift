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
        let detailUseCase = Injection.init().provideDetailFavorite()
        let presenter = DetailFavoritePresenter(detailModel: game, detailFavoriteUsecase: detailUseCase)
        return DetailFavoriteView(presenter: presenter)
    }
}
