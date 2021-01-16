//
//  APIRouterTests.swift
//  
//
//  Created by Aleksander Wędrychowski on 12/01/2021.
//

import Foundation
import XCTest
@testable import NetworkingModule

class APIRouterTests: XCTest {
    
    func testRequestCreating() {
        let route = APIRouter.creativesToFollow
        
        let request = route.asURLRequest
        XCTAssert(request != nil)
    }
    
    func testRequestURL() {
        let url = APIRouter.creativesToFollow.asURLRequest?.url?.absoluteString
        
        XCTAssert(url == "https://gist.githubusercontent.com/HEMIkr/3fbf10733e87c835e57c451a2baff120/raw/a93ca944e0a9ef9cc222d9814e009429c7810404/users.json")
    }
}
