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
    let attachments: [Attachment]?
}

struct Likes: Decodable {
    let count: Int
    let userLikes: Int
    let canLike: Int
}

struct Views: Decodable {
    let count: Int
}

// MARK: Attachments
struct Attachment: Decodable {
    let type: String
    let photo: Photo?
}

struct Photo: Decodable {
    struct Size: Decodable {
        let type: String
        let url: String
        let width: Int
        let height: Int
    }
    let sizes: [Size]
    
    var defaultHeight: Int {
        defaultSize.height
    }
    
    var defaultWidth: Int {
        defaultSize.width
    }
    
    var defaultUrl: String {
        defaultSize.url
    }
    
    private var defaultSize: Size {
        if let size = sizes.first(where: { $0.type == "y"}) {
            return size
        } else if let size = sizes.last {
            return size
        }
        
        // Couldn't found any size, return stub
        return Size(type: "Unknown type", url: "Unknown url", width: 0, height: 0)
    }
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
