//
//  FeedCellSizesCalculator.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import Foundation
import UIKit

protocol FeedCellSizesCalculator {
    func calculateSize(postText: String?, postImage: FeedCellPostImageViewModel?) -> FeedCellSizes
}

struct FeedCellSizesCalculatorImpl: FeedCellSizesCalculator {
    
    private let screenWidth: CGFloat
    private let cardWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
        cardWidth = screenWidth - FeedCellConstraints.Card.insets.left - FeedCellConstraints.Card.insets.right
    }
    
    func calculateSize(postText: String?, postImage: FeedCellPostImageViewModel?) -> FeedCellSizes {
        
        let textSize = calculatePostTextSize(postText: postText)
        let imageSize = calculatePostImageSize(postImage: postImage)
        let cellHeight = calculateCellHeight(textSize: textSize, imageSize: imageSize)
        
        return Feed.FetchFeed.ViewModel.Sizes(postSize: textSize, imageSize: imageSize, cellHeight: cellHeight)
    }
    
    private func calculatePostTextSize(postText: String?) -> CGSize {
        guard let postText = postText, !postText.isEmpty else { return .zero }
        let textWidth = cardWidth - FeedCellConstraints.PostText.leadingMargin - FeedCellConstraints.PostText.trailingMargin
        let textSize = CGSize(width: textWidth, height: .greatestFiniteMagnitude)
        
        let boundedRect = postText.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : FeedCellFont.postLabelFont],
                                     context: nil)
        return CGSize(width: textWidth, height: ceil(boundedRect.size.height))
    }
    
    private func calculatePostImageSize(postImage: FeedCellPostImageViewModel?) -> CGSize {
        guard let postImage = postImage else { return .zero }
        
        let imageHeight: Float = Float(postImage.height)
        let imageWidth: Float = Float(postImage.width)
        let imageRatio = CGFloat(imageHeight / imageWidth)
        
        return CGSize(width: cardWidth, height: cardWidth * imageRatio)
    }
    
    private func calculateCellHeight(textSize: CGSize, imageSize: CGSize) -> CGFloat {
        // Header + Footer + margins
        var height = FeedCellConstraints.Card.insets.top + FeedCellConstraints.Header.topMargin + FeedCellConstraints.Header.height + FeedCellConstraints.Footer.height + FeedCellConstraints.Footer.bottomMargin + FeedCellConstraints.Card.insets.bottom
        
        if textSize != .zero {
            height += FeedCellConstraints.PostText.topMargin + textSize.height + FeedCellConstraints.PostText.bottomMargin
        }
        if imageSize != .zero {
            height += imageSize.height + FeedCellConstraints.PostImage.bottomMargin
        }
        
        return height
    }
}
