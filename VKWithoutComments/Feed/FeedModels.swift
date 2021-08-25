//
//  FeedModels.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import Foundation

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
            }
            var feedCells: [FeedCell]
        }
    }
}
