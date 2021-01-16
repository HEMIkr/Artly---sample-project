import XCTest
@testable import NetworkingModule

final class NetworkingUtilsTests: XCTestCase {
    func testSuccessStatusCode() {
        let urlResponse: URLResponse? = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let isSuccess = urlResponse?.isSuccess ?? false
        
        XCTAssertTrue(isSuccess)
    }

    func testFailureStatusCode() {
        let urlResponse: URLResponse? = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        let isSuccess = urlResponse?.isSuccess ?? true
        
        XCTAssertFalse(isSuccess)
    }
}
