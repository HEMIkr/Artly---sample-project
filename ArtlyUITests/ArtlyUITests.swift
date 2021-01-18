//
//  ArtlyUITests.swift
//  ArtlyUITests
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import XCTest

class ArtlyUITests: XCTestCase {

    func testBasicUsage() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Tap second row
        app.tables.cells.element(boundBy: 1).tap()
        // Wait for scene to appear
        _ = app.images.element.waitForExistence(timeout: 3)
        // Tap map
        app.maps.element.tap()
        // Wait for fullscreen map
        _ = app.maps["UserMapViewController"].waitForExistence(timeout: 3)
        // Dismiss full screen map
        app.buttons["Close"].tap()
        // Tap back bar item
        app.navigationBars.firstMatch.buttons.firstMatch.tap()
        // back in main tableview
        _ = app.tables.firstMatch.waitForExistence(timeout: 3)
        
    }
}
