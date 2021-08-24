//
//  GetFeedResponse.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

struct GetFeedResponse: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    let items: [FeedItem]
}

struct FeedItem: Decodable {
    let type: String
    let sourceId: Int
    let postId: Int
    let date: Double
    let text: String?
    let likes: Likes?
    let views: Views?
}

struct Likes: Decodable {
    let count: Int
    let userLikes: Int
    let canLike: Int
}

struct Views: Decodable {
    let count: Int
}
