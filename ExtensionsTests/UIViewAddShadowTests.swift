//
//  UIViewAddShadowTests.swift
//  ExtensionsTests
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import XCTest
@testable import Extensions

class UIViewAddShadowTests: XCTestCase {
    func testAddShadow() {
        
        let view = UIView()
        view.addShadow()
        
        XCTAssert(view.layer.shadowColor == UIColor.black.cgColor && view.layer.shadowOpacity == 0.3)
    }
    
    func testRemoveShadow() {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.3
        
        view.removeShadow()
        
        XCTAssert(view.layer.shadowRadius == 0 && view.layer.shadowOpacity == 0)
    }
}
