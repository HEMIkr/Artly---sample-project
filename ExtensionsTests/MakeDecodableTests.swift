//
//  MakeDecodableTests.swift
//  ExtensionsTests
//
//  Created by Aleksander Wędrychowski on 14/01/2021.
//

import XCTest
@testable import Extensions

class MakeDecodableTests: XCTestCase {

    struct TestModel1: Decodable {
        let firstName: String
    }
    
    struct TestModel2: Decodable {
        let lastName: String
    }
    
    var jsonData: Data!
    
    override func setUp() {
        jsonData = {
            let jsonUrl = Bundle(for: type(of: self)).url(forResource: "MakeDecodable.json", withExtension: nil)!
            return try! Data(contentsOf: jsonUrl)
        }()
    }
    
    override func tearDown() {
        jsonData = nil
    }
    
    func testMakeFromDataDecodableSuccess() {
        let model = try? TestModel1.make(from: jsonData)
        
        XCTAssert(model?.firstName == "Guillaume")
    }
    
    func testMakeFromDataDecodableFailure() {
        let model = try? TestModel2.make(from: jsonData)
        
        XCTAssert(model == nil)
    }
}
