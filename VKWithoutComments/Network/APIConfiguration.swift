//
//  ConfigurationAPI.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

struct APIConfiguration {
    
    enum Methods: String {
        case feedGet = "/method/newsfeed.get"
        case usersGet = "/method/users.get"
    }
    
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.131"
}
