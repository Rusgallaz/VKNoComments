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
    let profiles: [Profile]
    let groups: [Group]
}

// MARK: FeedItem
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

//MARK: Profile/Group
protocol SourceRepresentable {
    var id: Int { get }
    var name: String { get }
    var photoUrl: String { get }
}

struct Profile: Decodable, SourceRepresentable{
    let id: Int
    let firstName: String
    let secondName: String?
    let photo100: String
    
    var name: String {
        "\(firstName) \(secondName ?? "")"
    }
    var photoUrl: String {
        photo100
    }
}

struct Group: Decodable, SourceRepresentable {
    let id: Int
    let name: String
    let photo200: String
    
    var photoUrl: String {
        photo200
    }
}
