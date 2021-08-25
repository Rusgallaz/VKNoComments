//
//  FeedModels.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import Foundation
import UIKit

enum Feed {
    
    enum FetchFeed {
        struct Request {
            
        }
        
        struct Response {
            var feedResponse: FeedResponse
        }
        
        struct ViewModel {
            struct FeedCell: FeedCellViewModel {
                var iconUrl: String
                var name: String
                var date: String
                var postText: String
                var likesCount: String
                var viewsCount: String
                var postImage: FeedCellPostImageViewModel?
                var sizes: FeedCellSizes
            }
            
            struct FeedCellPostImage: FeedCellPostImageViewModel {
                var url: String
                var height: Int
                var width: Int
            }
            
            struct Sizes: FeedCellSizes {
                var postSize: CGRect
                var imageSize: CGRect
            }
            
            var feedCells: [FeedCell]
        }
    }
}
