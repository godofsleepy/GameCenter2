//
//  Injection.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> GameRepositoryProtocol {
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return GameRepository.sharedInstance(remote, locale)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(gameid : String) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
    
    func provideSearch()  -> SearchUseCase {
        let repository = provideRepository()
        return SearchInteractor(repository: repository)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    func provideDetailFavorite() -> DetailFavoriteUseCase {
        let repository = provideRepository()
        return DetailFavoriteInteractor(repository: repository)
    }

    
}
