//
//  FeedCellConstraints.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 26.08.2021.
//

import Foundation
import UIKit

struct FeedCellConstraints {
    
    static let defaultMargin: CGFloat = 8
    
    struct Card {
        static let insets = UIEdgeInsets(top: 0, left: 0, bottom: defaultMargin, right: 0)
    }
    
    struct Header {
        struct IconImage {
            static let height = Header.height
            static let width = Header.height
        }
        
        struct Name {
            static let leadingMargin = defaultMargin
            static let trailingMargin = defaultMargin
            static let height = IconImage.height / 2
        }
        
        struct Date {
            static let leadingMargin = defaultMargin
            static let trailingMargin = defaultMargin
            static let height = IconImage.height / 2
        }
        
        static let topMargin = defaultMargin
        static let leadingMargin = defaultMargin
        static let trailingMargin = defaultMargin
        static let height: CGFloat = 40
        
    }
    
    struct PostText {
        static let topMargin = defaultMargin
        static let leadingMargin = defaultMargin
        static let trailingMargin = defaultMargin
        static let bottomMargin = defaultMargin
    }
    
    struct PostImage {
        static let leadingMargin = defaultMargin
        static let trailingMargin = defaultMargin
        static let bottomMargin = defaultMargin
    }
    
    struct Footer {
        struct Likes {
            static let imageLeadingMargin: CGFloat = 4
            static let imageHeight = Footer.height - imageLeadingMargin * 2
            static let imageWidth = imageHeight
            
            static let textLeadingMargin: CGFloat = 2
        }
        
        struct Views {
            static let textTrailingMargin: CGFloat = 4

            static let imageTrailingMargin: CGFloat = 2
            static let imageHeight = Footer.height - textTrailingMargin * 2
            static let imageWidth = imageHeight * 1.5
        }
        
        static let leadingMargin: CGFloat = 0
        static let trailingMargin: CGFloat = 0
        static let bottomMargin: CGFloat = 0
        static let height: CGFloat = 40
    }
}

struct FeedCellFont {
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
}
