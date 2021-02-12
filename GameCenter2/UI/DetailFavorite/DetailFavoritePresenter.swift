//
//  DetailFavoritePresenter.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/02/21.
//

import Foundation

class DetailFavoritePresenter : ObservableObject {
    @Published var game: DetailModel
    @Published var isFav : Bool = true
    
    init(detailModel : DetailModel) {
        self.game = detailModel
    }
}
