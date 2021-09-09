//
//  SearchRouter.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/01/21.
//

import Foundation
import SwiftUI

class SearchRouter {
    func makeDetailView(for gameId: String) -> some View {
      let detailUseCase = Injection.init().provideDetail(gameid: gameId)
      let presenter = DetailPresenter(detailUseCase: detailUseCase, gameId: gameId)
      return DetailView(presenter: presenter)
    }

}
