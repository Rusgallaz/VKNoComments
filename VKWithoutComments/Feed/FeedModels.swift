//
//  FeedModels.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import Foundation
import UIKit

enum Feed {
    
    struct FeedCell: FeedCellViewModel {
        var postId: Int
        var iconUrl: String
        var name: String
        var date: String
        var postText: String?
        var likesCount: String
        var viewsCount: String
        var postImages: [FeedCellPostImageViewModel]
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPostImage: FeedCellPostImageViewModel {
        var url: String
        var height: Int
        var width: Int
    }
    
    struct Sizes: FeedCellSizes {
        var postSize: CGSize
        var imageSize: CGSize
        var moreButtonSize: CGSize
        var cellHeight: CGFloat
    }
    
    enum FetchFeed {
        struct Request {
            
        }
        
        struct Response {
            var feedResponse: FeedResponse
        }
        
        struct ViewModel {
            var feedCells: [FeedCell]
        }
    }
    
    enum ShowMore {
        struct Request {
            var postId: Int
        }
        struct Response {
            var feedResponse: FeedResponse
            var fullSizedPostIds: [Int]
        }
        struct ViewModel {
            var feedCells: [FeedCell]
        }
    }
    
    enum FetchUser {
        struct Request {
            
        }
        
        struct Response {
            var userResponse: UserResponse
        }
        
        struct ViewModel {
            struct HeaderView: HeaderViewViewModel {
                var avatarUrl: String
            }
            var headerView: HeaderView
        }
    }
}
