//
//  DecodingSnakeCaseTests.swift
//  ExtensionsTests
//
//  Created by Aleksander Wędrychowski on 14/01/2021.
//

import XCTest
@testable import Extensions

class DecodingSnakeCaseTests: XCTestCase {

    struct TestModel: Decodable {
        let firstName: String
    }
    
    func testDecodingSnakeCaseJson() {
        let jsonUrl = Bundle(for: type(of: self)).url(forResource: "snakeCase.json", withExtension: nil)!
        let encodedJson = try! Data(contentsOf: jsonUrl)
        let model = try? JSONDecoder.standard.decode(TestModel.self, from: encodedJson)
        
        XCTAssert(model?.firstName == "Guillaume")
    }

}
