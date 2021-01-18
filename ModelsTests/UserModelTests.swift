//
//  UserModelTests.swift
//  ModelsTests
//
//  Created by Aleksander Wędrychowski on 14/01/2021.
//

import XCTest
import Extensions
@testable import Models

class UserModelTests: XCTestCase {

    var model: User?

    override func setUp() {
        model = {
            guard let file = Bundle(for: type(of: self)).url(forResource: "UserJSON.json", withExtension: nil),
                  let data = try? Data(contentsOf: file)
                else { return nil }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try? decoder.decode(User.self, from: data)
            return model
        }()
    }

    override func tearDownWithError() throws {
        model = nil
    }
    
    func testUserParsing() {
        let user = model
        
        XCTAssert(user != nil)
    }

    func testURLParsing() {
        let user = model
        let expectedURL = URL(string: "http://www.behance.net/guillaumedelvigne")!
        
        XCTAssert(user?.profileUrl == expectedURL)
    }
    
    func testProfileUrl() {
        let user = model
        
        XCTAssert(user?.imageUrls.count == 6)
    }
}
