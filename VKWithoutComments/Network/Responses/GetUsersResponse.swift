//
//  GetUsersResponse.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 28.08.2021.
//

import Foundation

struct GetUsersResponse: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
