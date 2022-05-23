//
//  SportsTests.swift
//  SportsTests
//
//  Created by ayahassan on 5/12/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import XCTest
@testable import Sports

class SportsTests: XCTestCase {

       var networkManager : NetworkManagerProtocol = NetworkManager()
        
        override func setUp() {
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }

        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }
        
        func testGetAllSports() {
            let expectaion = expectation(description: "Waiting for the API")
            networkManager.fetchResponse(endUrl: "all_sports.php", httpMethod: .get, parametrs: [:]) { (result:Result<AllSports, Error>) in
                switch result {
                case .success(let response):
                    print(response.sports as Any)
                    XCTAssertEqual(response.sports?.count, 34, "API Faild")
                    expectaion.fulfill()
                case .failure( _):
                    XCTFail()
                }
            }
            waitForExpectations(timeout: 5, handler: nil)
        }
        
        func testGetLeagues() {
            let expectaion = expectation(description: "Waiting for the API")
            networkManager.fetchResponse(endUrl: "search_all_leagues.php", httpMethod: .get, parametrs: ["s":"Soccer"]) { (result:Result<AllLeagues, Error>) in
                switch result {
                case .success(let response):
                    print(response.countries as Any)
                    XCTAssertEqual(response.countries?.count, 10, "API Faild")
                    expectaion.fulfill()
                case .failure( _):
                    XCTFail()
                }
            }
            waitForExpectations(timeout: 5, handler: nil)
        }

    }

