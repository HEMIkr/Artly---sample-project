//
//  APIRouter.swift
//  
//
//  Created by Aleksander Wędrychowski on 12/01/2021.
//

import Foundation

public enum APIRouter {
    case creativesToFollow
}

extension APIRouter {
    private static let baseURLComponents: URLComponents? = {
        #if DEBUG
        return URLComponents(string: "https://gist.githubusercontent.com") // Development server baseURL
        #else
        return URLComponents(string: "https://gist.githubusercontent.com") // Production server baseURL
        #endif
    }()
    
    private var method: HTTPMethod {
        switch self {
        case .creativesToFollow: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .creativesToFollow: return "/HEMIkr/3fbf10733e87c835e57c451a2baff120/raw/0db2ea62c309763640855be52204d00f9ff4cc08/users.json"
        }
    }
    
    var asURLRequest: URLRequest? {
        guard var urlComponents = APIRouter.baseURLComponents else {
            assertionFailure()
            return nil
        }
        urlComponents.path = path
        
        switch self {
        case .creativesToFollow: break
        }
        
        guard let url = urlComponents.url else {
            assertionFailure()
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
