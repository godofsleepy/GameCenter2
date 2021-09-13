//
//  RemoteDataSourceTest.swift
//  GameCenter2Tests
//
//  Created by rifat khadafy on 31/08/21.
//

import XCTest
import Combine

@testable import GameCenter2
class RemoteDataSourceTest: XCTestCase {
    
    static var fakeResponse : GameResponse = GameResponse(id: 1, name: "Test", rating: 5.5, released: "2021-08-31", background_image: "test.png")
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRemoteDataSource() throws {
        // Given
        let dataSource = RemoteDataSourceMock()
        var test : [GameResponse] = []
        // When
        dataSource.getGames(platformId: "14")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            },receiveValue: { games in
                test = games
            }).store(in: &cancellables)
        
        
        
        XCTAssert(dataSource.verify())
        XCTAssertEqual(test.count, 1)
        
    }
    
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}

extension RemoteDataSourceTest {
    
    class RemoteDataSourceMock: RemoteDataSourceProtocol {
        
        var functionWasCalled = false
        
        func getGames(platformId : String) -> AnyPublisher<[GameResponse], Error> {
            functionWasCalled = true
            return Future<[GameResponse], Error> { completion in
                completion(.success([fakeResponse]))
            }.eraseToAnyPublisher()
        }
        
        func getDetail(gameId: String) -> AnyPublisher<DetailResponse, Error> {
            return Future<DetailResponse, Error> { completion in
                completion(.success(
                    DetailResponse(id: 1, name: "a", released: "", rating: 2.2, description: "", background_image: "", background_image_additional: "", parent_platforms: [platforms(platform: platform(slug: ""))], genres: [genre(name: "")])
                ))
            }.eraseToAnyPublisher()
            
        }
        
        func getSearch(query: String) -> AnyPublisher<[GameResponse], Error> {
            return Future<[GameResponse], Error> { completion in
                completion(.success([fakeResponse]))
            }.eraseToAnyPublisher()
            
        }
        
        
        func verify() -> Bool{
            return functionWasCalled
        }
    }
    
}
