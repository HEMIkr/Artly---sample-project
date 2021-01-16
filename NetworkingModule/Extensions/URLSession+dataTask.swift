//
//  URLSession+dataTask.swift
//  
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import Foundation

typealias URLDataTaskResponse = (data: Data?, response: URLResponse?, error: Error?)
extension URLSession {
    func dataTask(with request: URLRequest, dataTaskCompletion: @escaping (URLDataTaskResponse) -> Void) -> URLSessionDataTask {
        self.dataTask(with: request, completionHandler: { data, response, error in
            dataTaskCompletion((data: data, response: response, error: error))
        })
    }
}
