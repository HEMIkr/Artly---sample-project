//
//  UIViewRoundCornerTests.swift
//  ExtensionsTests
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import XCTest
@testable import Extensions

class UIViewRoundCornerTests: XCTestCase {
    func testRoundCorners() {
        let view = UIView(frame: .init(x: 0, y: 0, width: 50, height: 50))
        view.roundCorners(radius: 10)
        
        XCTAssert(view.layer.cornerRadius == 10)
    }
}
