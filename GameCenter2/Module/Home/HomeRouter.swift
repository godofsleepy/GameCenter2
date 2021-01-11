//
//  HomeRouter.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import SwiftUI

class HomeRouter {

  func makeDetailView(for gameid: String) -> some View {
    let detailUseCase = Injection.init().provideDetail(gameid: gameid)
    let presenter = DetailPresenter(detailUseCase: detailUseCase, gameId: gameid)
    return DetailView(presenter: presenter)
  }
  
}
