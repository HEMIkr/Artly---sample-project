//
//  RoutingLogic.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import Foundation

protocol RoutingLogic {
    func navigate(to destination: Destination)
    
    associatedtype Destination
}
