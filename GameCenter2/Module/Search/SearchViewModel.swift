////
////  SearchViewModel.swift
////  GameCenter
////
////  Created by rifat khadafy on 18/08/20.
////  Copyright © 2020 rifat khadafy. All rights reserved.
////
//
//import Foundation
//import Combine
//
//final class SearchViewModel: ObservableObject {
//    @Published private(set) var state = State.idle
//    
//    private var bag = Set<AnyCancellable>()
//    private let input = PassthroughSubject<Event, Never>()
//    
//    init() {
//        Publishers.system(
//            initial: state,
//            reduce: Self.reduce,
//            scheduler: RunLoop.main,
//            feedbacks: [
//                Self.whenLoading(),
//                Self.userInput(input: input.eraseToAnyPublisher())
//            ]
//        )
//            .assign(to: \.state, on: self)
//            .store(in: &bag)
//    }
//    
//    deinit {
//        bag.removeAll()
//    }
//    
//    func send(event: Event) {
//        input.send(event)
//    }
//}
//
//extension SearchViewModel {
//    enum State {
//        case idle
//        case loading(String)
//        case loaded([ListGame])
//        case error(Error)
//    }
//    
//    enum Event {
//        case onSearchGame(String)
//        case onGamesLoaded([ListGame])
//        case onFailedToLoadGames(Error)
//    }
//    
//    
//}
//
//extension SearchViewModel {
//    static func reduce(_ state: State,_ event: Event) -> State {
//        switch state {
//        case .idle:
//            switch event {
//            case .onSearchGame(let query):
//                return .loading(query)
//            default:
//                return state
//            }
//            
//        case .loading:
//            switch event {
//            case .onFailedToLoadGames(let error):
//                return .error(error)
//            case .onGamesLoaded(let games):
//                return .loaded(games)
//            default:
//                return state
//            }
//            
//        case .loaded:
//            switch event {
//            case .onSearchGame(let query):
//                return .loading(query)
//            default:
//                return state
//            }
//        case .error:
//            return state
//        }
//    }
//    
//    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
//        Feedback { _ in
//            return input }
//    }
//    
//    static func whenLoading() -> Feedback<State, Event> {
//        Feedback { (state: State) -> AnyPublisher<Event, Never> in
//            guard case .loading(let query) = state else { return Empty().eraseToAnyPublisher() }
//            
//            return GamesApi.gameSearch(query: query)
//                .map { $0.results.map(ListGame.init) }
//                .map(Event.onGamesLoaded)
//                .catch { Just(Event.onFailedToLoadGames($0)) }
//                .eraseToAnyPublisher()
//        }
//    }
//}
//
