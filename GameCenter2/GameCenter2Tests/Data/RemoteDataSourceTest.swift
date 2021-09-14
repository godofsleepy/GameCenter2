//
//  RemoteDataSourceTest.swift
//  GameCenter2Tests
//
//  Created by rifat khadafy on 31/08/21.
//

import XCTest
import Combine
import Core
import GameDomain
import GameRepo

@testable import GameCenter2
class RemoteDataSourceTest: XCTestCase {
    
    static var responseJson: String = """
{"count":612416,"next":"https://api.rawg.io/api/games?key=915260f2cb5041538cdedbc5c3b37a18&page=2","previous":null,"results":[{"id":3498,"slug":"grand-theft-auto-v","name":"Grand Theft Auto V","released":"2013-09-17","tba":false,"background_image":"https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg","rating":4.48,"rating_top":5,"ratings":[{"id":5,"title":"exceptional","count":2989,"percent":58.97},{"id":4,"title":"recommended","count":1676,"percent":33.06},{"id":3,"title":"meh","count":319,"percent":6.29},{"id":1,"title":"skip","count":85,"percent":1.68}],"ratings_count":5013,"reviews_text_count":33,"added":15648,"added_by_status":{"yet":392,"owned":9308,"beaten":4182,"toplay":435,"dropped":767,"playing":564},"metacritic":97,"playtime":71,"suggestions_count":407,"updated":"2021-08-20T12:42:02","user_game":null,"reviews_count":5069,"saturated_color":"0f0f0f","dominant_color":"0f0f0f","platforms":[{"platform":{"id":187,"name":"PlayStation 5","slug":"playstation5","image":null,"year_end":null,"year_start":2020,"games_count":359,"image_background":"https://media.rawg.io/media/games/1f4/1f47a270b8f241e4676b14d39ec620f7.jpg"},"released_at":"2013-09-17","requirements_en":null,"requirements_ru":null},{"platform":{"id":18,"name":"PlayStation 4","slug":"playstation4","image":null,"year_end":null,"year_start":null,"games_count":6089,"image_background":"https://media.rawg.io/media/games/942/9424d6bb763dc38d9378b488603c87fa.jpg"},"released_at":"2013-09-17","requirements_en":null,"requirements_ru":null},{"platform":{"id":16,"name":"PlayStation 3","slug":"playstation3","image":null,"year_end":null,"year_start":null,"games_count":3627,"image_background":"https://media.rawg.io/media/games/234/23410661770ae13eac11066980834367.jpg"},"released_at":"2013-09-17","requirements_en":null,"requirements_ru":null},{"platform":{"id":14,"name":"Xbox 360","slug":"xbox360","image":null,"year_end":null,"year_start":null,"games_count":2725,"image_background":"https://media.rawg.io/media/games/bc0/bc06a29ceac58652b684deefe7d56099.jpg"},"released_at":"2013-09-17","requirements_en":null,"requirements_ru":null},{"platform":{"id":4,"name":"PC","slug":"pc","image":null,"year_end":null,"year_start":null,"games_count":363936,"image_background":"https://media.rawg.io/media/games/588/588c6bdff3d4baf66ec36b1c05b793bf.jpg"},"released_at":"2013-09-17","requirements_en":{"minimum":"Minimum:OS: Windows 10 64 Bit, Windows 8.1 64 Bit, Windows 8 64 Bit, Windows 7 64 Bit Service Pack 1, Windows Vista 64 Bit Service Pack 2* (*NVIDIA video card recommended if running Vista OS)Processor: Intel Core 2 Quad CPU Q6600 @ 2.40GHz (4 CPUs) / AMD Phenom 9850 Quad-Core Processor (4 CPUs) @ 2.5GHzMemory: 4 GB RAMGraphics: NVIDIA 9800 GT 1GB / AMD HD 4870 1GB (DX 10, 10.1, 11)Storage: 72 GB available spaceSound Card: 100% DirectX 10 compatibleAdditional Notes: Over time downloadable content and programming changes will change the system requirements for this game.  Please refer to your hardware manufacturer and www.rockstargames.com/support for current compatibility information. Some system components such as mobile chipsets, integrated, and AGP graphics cards may be incompatible. Unlisted specifications may not be supported by publisher.     Other requirements:  Installation and online play requires log-in to Rockstar Games Social Club (13+) network; internet connection required for activation, online play, and periodic entitlement verification; software installations required including Rockstar Games Social Club platform, DirectX , Chromium, and Microsoft Visual C++ 2008 sp1 Redistributable Package, and authentication software that recognizes certain hardware attributes for entitlement, digital rights management, system, and other support purposes.     SINGLE USE SERIAL CODE REGISTRATION VIA INTERNET REQUIRED; REGISTRATION IS LIMITED TO ONE ROCKSTAR GAMES SOCIAL CLUB ACCOUNT (13+) PER SERIAL CODE; ONLY ONE PC LOG-IN ALLOWED PER SOCIAL CLUB ACCOUNT AT ANY TIME; SERIAL CODE(S) ARE NON-TRANSFERABLE ONCE USED; SOCIAL CLUB ACCOUNTS ARE NON-TRANSFERABLE.  Partner Requirements:  Please check the terms of service of this site before purchasing this software.","recommended":"Recommended:OS: Windows 10 64 Bit, Windows 8.1 64 Bit, Windows 8 64 Bit, Windows 7 64 Bit Service Pack 1Processor: Intel Core i5 3470 @ 3.2GHz (4 CPUs) / AMD X8 FX-8350 @ 4GHz (8 CPUs)Memory: 8 GB RAMGraphics: NVIDIA GTX 660 2GB / AMD HD 7870 2GBStorage: 72 GB available spaceSound Card: 100% DirectX 10 compatibleAdditional Notes:"},"requirements_ru":null},{"platform":{"id":1,"name":"Xbox One","slug":"xbox-one","image":null,"year_end":null,"year_start":null,"games_count":4935,"image_background":"https://media.rawg.io/media/games/ad2/ad2ffdf80ba993654f31da045bc02456.jpg"},"released_at":"2013-09-17","requirements_en":null,"requirements_ru":null},{"platform":{"id":186,"name":"Xbox Series S/X","slug":"xbox-series-x","image":null,"year_end":null,"year_start":2020,"games_count":303,"image_background":"https://media.rawg.io/media/games/26d/26d4437715bee60138dab4a7c8c59c92.jpg"},"released_at":"2013-09-17","requirements_en":null,"requirements_ru":null}],"parent_platforms":[{"platform":{"id":1,"name":"PC","slug":"pc"}},{"platform":{"id":2,"name":"PlayStation","slug":"playstation"}},{"platform":{"id":3,"name":"Xbox","slug":"xbox"}}],"genres":[{"id":4,"name":"Action","slug":"action","games_count":127576,"image_background":"https://media.rawg.io/media/games/f87/f87457e8347484033cb34cde6101d08d.jpg"},{"id":3,"name":"Adventure","slug":"adventure","games_count":93985,"image_background":"https://media.rawg.io/media/games/26d/26d4437715bee60138dab4a7c8c59c92.jpg"}],"stores":[{"id":290375,"store":{"id":3,"name":"PlayStation Store","slug":"playstation-store","domain":"store.playstation.com","games_count":7650,"image_background":"https://media.rawg.io/media/games/bc8/bc845a71d60a87ea5736b40c2d3a0fdf.jpg"}},{"id":438095,"store":{"id":11,"name":"Epic Games","slug":"epic-games","domain":"epicgames.com","games_count":581,"image_background":"https://media.rawg.io/media/games/daa/daaee07fcb40744d90cf8142f94a241f.jpg"}},{"id":290376,"store":{"id":1,"name":"Steam","slug":"steam","domain":"store.steampowered.com","games_count":54688,"image_background":"https://media.rawg.io/media/games/f87/f87457e8347484033cb34cde6101d08d.jpg"}},{"id":290377,"store":{"id":7,"name":"Xbox 360 Store","slug":"xbox360","domain":"marketplace.xbox.com","games_count":1908,"image_background":"https://media.rawg.io/media/games/b49/b4912b5dbfc7ed8927b65f05b8507f6c.jpg"}},{"id":290378,"store":{"id":2,"name":"Xbox Store","slug":"xbox-store","domain":"microsoft.com","games_count":4507,"image_background":"https://media.rawg.io/media/games/942/9424d6bb763dc38d9378b488603c87fa.jpg"}}],"clip":null,"tags":[{"id":31,"name":"Singleplayer","slug":"singleplayer","language":"eng","games_count":129678,"image_background":"https://media.rawg.io/media/games/120/1201a40e4364557b124392ee50317b99.jpg"},{"id":40847,"name":"Steam Achievements","slug":"steam-achievements","language":"eng","games_count":22901,"image_background":"https://media.rawg.io/media/games/da1/da1b267764d77221f07a4386b6548e5a.jpg"},{"id":7,"name":"Multiplayer","slug":"multiplayer","language":"eng","games_count":27013,"image_background":"https://media.rawg.io/media/games/46d/46d98e6910fbc0706e2948a7cc9b10c5.jpg"},{"id":13,"name":"Atmospheric","slug":"atmospheric","language":"eng","games_count":15592,"image_background":"https://media.rawg.io/media/games/b7d/b7d3f1715fa8381a4e780173a197a615.jpg"},{"id":40836,"name":"Full controller support","slug":"full-controller-support","language":"eng","games_count":10638,"image_background":"https://media.rawg.io/media/games/310/3106b0e012271c5ffb16497b070be739.jpg"},{"id":42,"name":"Great Soundtrack","slug":"great-soundtrack","language":"eng","games_count":3159,"image_background":"https://media.rawg.io/media/games/e46/e462e92b46e8df13e78a806191610d47.jpg"},{"id":24,"name":"RPG","slug":"rpg","language":"eng","games_count":12516,"image_background":"https://media.rawg.io/media/games/4ba/4ba9b4b68ffcc7019b112174883ba4d6.jpg"},{"id":18,"name":"Co-op","slug":"co-op","language":"eng","games_count":7178,"image_background":"https://media.rawg.io/media/games/46d/46d98e6910fbc0706e2948a7cc9b10c5.jpg"},{"id":36,"name":"Open World","slug":"open-world","language":"eng","games_count":4141,"image_background":"https://media.rawg.io/media/games/d82/d82990b9c67ba0d2d09d4e6fa88885a7.jpg"},{"id":411,"name":"cooperative","slug":"cooperative","language":"eng","games_count":2963,"image_background":"https://media.rawg.io/media/games/5bb/5bb55ccb8205aadbb6a144cf6d8963f1.jpg"},{"id":8,"name":"First-Person","slug":"first-person","language":"eng","games_count":15163,"image_background":"https://media.rawg.io/media/games/736/73619bd336c894d6941d926bfd563946.jpg"},{"id":149,"name":"Third Person","slug":"third-person","language":"eng","games_count":5081,"image_background":"https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"},{"id":4,"name":"Funny","slug":"funny","language":"eng","games_count":14877,"image_background":"https://media.rawg.io/media/games/4a0/4a0a1316102366260e6f38fd2a9cfdce.jpg"},{"id":37,"name":"Sandbox","slug":"sandbox","language":"eng","games_count":3872,"image_background":"https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"},{"id":123,"name":"Comedy","slug":"comedy","language":"eng","games_count":7097,"image_background":"https://media.rawg.io/media/games/8ca/8ca40b562a755d6a0e30d48e6c74b178.jpg"},{"id":150,"name":"Third-Person Shooter","slug":"third-person-shooter","language":"eng","games_count":1719,"image_background":"https://media.rawg.io/media/games/5bb/5bb55ccb8205aadbb6a144cf6d8963f1.jpg"},{"id":62,"name":"Moddable","slug":"moddable","language":"eng","games_count":590,"image_background":"https://media.rawg.io/media/games/5fa/5fae5fec3c943179e09da67a4427d68f.jpg"},{"id":144,"name":"Crime","slug":"crime","language":"eng","games_count":1915,"image_background":"https://media.rawg.io/media/games/10d/10d19e52e5e8415d16a4d344fe711874.jpg"},{"id":62349,"name":"vr mod","slug":"vr-mod","language":"eng","games_count":19,"image_background":"https://media.rawg.io/media/games/bda/bdab2603c0dc67268d0610449bc7df16.jpg"}],"esrb_rating":{"id":4,"name":"Mature","slug":"mature"},"short_screenshots":[{"id":-1,"image":"https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"},{"id":1827221,"image":"https://media.rawg.io/media/screenshots/a7c/a7c43871a54bed6573a6a429451564ef.jpg"},{"id":1827222,"image":"https://media.rawg.io/media/screenshots/cf4/cf4367daf6a1e33684bf19adb02d16d6.jpg"},{"id":1827223,"image":"https://media.rawg.io/media/screenshots/f95/f9518b1d99210c0cae21fc09e95b4e31.jpg"},{"id":1827225,"image":"https://media.rawg.io/media/screenshots/a5c/a5c95ea539c87d5f538763e16e18fb99.jpg"},{"id":1827226,"image":"https://media.rawg.io/media/screenshots/a7e/a7e990bc574f4d34e03b5926361d1ee7.jpg"},{"id":1827227,"image":"https://media.rawg.io/media/screenshots/592/592e2501d8734b802b2a34fee2df59fa.jpg"}]}]}
"""
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
        let dataSource = GetGamesRemoteMock(_endpoint: "test", _key: "a")
        var test : [GameResponse] = []
        // When
        dataSource.execute(request: "")
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
    
    class GetGamesRemoteMock: DataSource {
        internal init(_endpoint: String, _key: String) {
            self._endpoint = _endpoint
            self._key = _key
        }
        
        typealias Request = Any
        typealias Response = [GameResponse]
        var _endpoint: String
        var _key: String
        
        
        var functionWasCalled = false
        
        func execute(request: Any?) -> AnyPublisher<[GameResponse], Error> {
            functionWasCalled = true
            return Future<[GameResponse], Error> { completion in
                if !self._endpoint.isEmpty {
                    if !self._key.isEmpty{
                        do {
                            let value = try JSONDecoder().decode(GamesResponse.self, from: Data(responseJson.utf8))
                            completion(.success(value.results))
                        }
                        catch {
                            completion(.failure(URLError.invalidResponse))
                        }
                        
                        
                    } else {
                        print("Doesn't Have API KEY")
                        completion(.failure(URLError.invalidResponse))
                        
                    }
                }
            }.eraseToAnyPublisher()
            
        }
        
        func verify() -> Bool{
            return functionWasCalled
        }
    }
    
}
