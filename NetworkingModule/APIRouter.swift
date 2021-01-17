//
//  APIRouter.swift
//  
//
//  Created by Aleksander Wędrychowski on 12/01/2021.
//

import Foundation

public enum APIRouter {
    case creativesToFollow
    case userDetails(UserDetails.Request)
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
        case .userDetails: return .get
        }
    }
    
    private var path: String {
        switch self { // model cound paramterise request. In this demo-case we always call the same endpoint.
        case .creativesToFollow: return "/HEMIkr/3fbf10733e87c835e57c451a2baff120/raw/046075add689747fd7eb434e2fed475df949493b/users.json"
        case .userDetails: return "/HEMIkr/096fce6ab062338eb6a45b4210bba0fa/raw/1ab26a14a73321b00a1af3b536fbe30809751798/user2.json"
        }
    }
    
    var asURLRequest: URLRequest? {
        guard var urlComponents = APIRouter.baseURLComponents else {
            assertionFailure()
            return nil
        }
        urlComponents.path = path
        
        switch self { // model cound paramterise request. In this demo-case we always call the same endpoint.
        case .creativesToFollow: break
        case .userDetails: break
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
