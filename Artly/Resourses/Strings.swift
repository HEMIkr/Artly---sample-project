//
//  Strings.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//
// swiftlint:disable identifier_name

import Foundation

enum Strings: String {
    case ok = "common_ok"
    case close = "common_close"
    case title = "common_application_title"
    enum Users: String {
        case fieldsOfExpertise = "users_fields_of_expertise"
    }
    
    enum UserDetails: String {
        case follow = "user_details_follow"
        case unfollow = "user_details_unfollow"
        case photos = "user_details_photos"
    }
}
