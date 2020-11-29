//
//  DetailViewModel.swift
//  GameCenter
//
//  Created by rifat khadafy on 14/08/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    @Published private(set) var state: State
    
    private var bag = Set<AnyCancellable>()
    
    private let input = PassthroughSubject<Event, Never>()
    
    init(gameId: String) {
        state = .idle(gameId)
        
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
    
    func send(event: Event) {
        input.send(event)
    }
    
}

extension DetailViewModel {
    enum State {
        case idle(String)
        case loading(String)
        case loaded(GameDetail)
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onLoaded(GameDetail)
        case onFailedToLoad(Error)
    }
    
}

extension DetailViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle(let id):
            switch event {
            case .onAppear:
                return .loading(id)
            default:
                return state
            }
        case .loading:
            switch event {
            case .onFailedToLoad(let error):
                print("state : error")
                return .error(error)
            case .onLoaded(let game):
                print("state : onloaded")
                return .loaded(game)
            default:
                print("event : error")
                return state
            }
        case .loaded:
            print("state : loaded")
            return state
        case .error:
            return state
        }
    }
    
    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading(let id) = state else { return Empty().eraseToAnyPublisher() }
            return GamesApi.detail(id: id)
                .map(GameDetail.init)
                .map(Event.onLoaded)
                .catch { Just(Event.onFailedToLoad($0)) }
                .eraseToAnyPublisher()
        }
    }
    
    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback(run: { _ in
            return input
        })
    }
}
