//
//  GameListViewModel.swift
//  GameCenter2
//
//  Created by rifat khadafy on 17/11/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import Foundation
import Combine

final class GamesListViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    
    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()
    
    init() {
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
            .assign(to: \.state, on: self)
            .store(in: &bag)
    }
    
    deinit {
        bag.removeAll()
    }
    
    func send(event: Event) {
        input.send(event)
    }
}


extension GamesListViewModel {
    enum State {
        case idle
        case loading(String)
        case loaded([ListGame])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onSelectGames(Int)
        case onSelectPlatform(String)
        case onGamesLoaded([ListGame])
        case onFailedToLoadGames(Error)
    }

}

extension GamesListViewModel {
    static func reduce(_ state: State,_ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onSelectPlatform(let id):
                print("select")
                return .loading(id)
            default:
                return state
            }
            
        case .loading:
            switch event {
            case .onFailedToLoadGames(let error):
                return .error(error)
            case .onGamesLoaded(let games):
                return .loaded(games)
            default:
                return state
            }
            
        case .loaded:
            switch event {
            case .onSelectPlatform(let id):
                return .loading(id)
            default:
                return state
            }
        case .error:
            return state
        }
    }
    
    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in
            return input }
    }
    
    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading(let id) = state else { return Empty().eraseToAnyPublisher() }
            
            return GamesApi.gamePlatform(id: id)
                .map { $0.results.map(ListGame.init) }
                .map(Event.onGamesLoaded)
                .catch { Just(Event.onFailedToLoadGames($0)) }
                .eraseToAnyPublisher()
        }
    }
}


