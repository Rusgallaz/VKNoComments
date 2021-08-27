//
//  FeedCellSizesCalculator.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import Foundation
import UIKit

protocol FeedCellSizesCalculator {
    func calculateSize(postText: String?, postImage: FeedCellPostImageViewModel?, isFullSizedPost: Bool) -> FeedCellSizes
}

struct FeedCellSizesCalculatorImpl: FeedCellSizesCalculator {
    
    private let screenWidth: CGFloat
    private let cardWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
        cardWidth = screenWidth - FeedCellConstraints.Card.insets.left - FeedCellConstraints.Card.insets.right
    }
    
    func calculateSize(postText: String?, postImage: FeedCellPostImageViewModel?, isFullSizedPost: Bool) -> FeedCellSizes {
        
        let (textSize, moreButtonSize) = calculatePostTextAndMoreButtonSizes(postText: postText, isFullSizedPost: isFullSizedPost)
        let imageSize = calculatePostImageSize(postImage: postImage)
        let cellHeight = calculateCellHeight(textSize: textSize, moreButtonSize: moreButtonSize, imageSize: imageSize)
        
        return Feed.Sizes(postSize: textSize, imageSize: imageSize, moreButtonSize: moreButtonSize, cellHeight: cellHeight)
    }
    
    private func calculatePostTextAndMoreButtonSizes(postText: String?, isFullSizedPost: Bool) -> (postTextSize: CGSize, moreButtonSize: CGSize) {
        guard let postText = postText, !postText.isEmpty else { return (.zero, .zero) }
        let textWidth = cardWidth - FeedCellConstraints.PostText.leadingMargin - FeedCellConstraints.PostText.trailingMargin
        
        let textSize = CGSize(width: textWidth, height: .greatestFiniteMagnitude)
        let boundedRect = postText.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : FeedCellFont.postLabelFont],
                                     context: nil)
        var textHeight = ceil(boundedRect.size.height)
        
        var moreButtonSize: CGSize = .zero
        if !isFullSizedPost && textHeight > FeedCellFont.postLabelFont.lineHeight * CGFloat(FeedCellConstants.maxLinesFullPost) {
            textHeight = FeedCellFont.postLabelFont.lineHeight * CGFloat(FeedCellConstants.linesCountMinimizedPost)
            moreButtonSize = CGSize(width: textWidth, height: FeedCellConstraints.MoreButton.height)
        }
        
        let postTextSize = CGSize(width: textWidth, height: textHeight)
        return (postTextSize, moreButtonSize)
    }
    
    private func calculatePostImageSize(postImage: FeedCellPostImageViewModel?) -> CGSize {
        guard let postImage = postImage else { return .zero }
        
        let imageHeight: Float = Float(postImage.height)
        let imageWidth: Float = Float(postImage.width)
        let imageRatio = CGFloat(imageHeight / imageWidth)
        
        return CGSize(width: cardWidth, height: cardWidth * imageRatio)
    }
    
    private func calculateCellHeight(textSize: CGSize, moreButtonSize: CGSize, imageSize: CGSize) -> CGFloat {
        // Header + Footer + margins
        var height = FeedCellConstraints.Card.insets.top + FeedCellConstraints.Header.topMargin + FeedCellConstraints.Header.height + FeedCellConstraints.Footer.height + FeedCellConstraints.Footer.bottomMargin + FeedCellConstraints.Card.insets.bottom
        
        if textSize != .zero {
            height += FeedCellConstraints.PostText.topMargin + textSize.height + FeedCellConstraints.PostText.bottomMargin
        }
        if moreButtonSize != .zero {
            height += FeedCellConstraints.MoreButton.topMargin + moreButtonSize.height
        }
        if imageSize != .zero {
            height += imageSize.height + FeedCellConstraints.PostImage.bottomMargin
        }
        
        return height
    }
}
