//
//  FeedCellSizesCalculator.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import Foundation
import UIKit

protocol FeedCellSizesCalculator {
    func calculateSize(postText: String?, postImages: [FeedCellPostImageViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

struct FeedCellSizesCalculatorImpl: FeedCellSizesCalculator {
    
    private let screenWidth: CGFloat
    private let cardWidth: CGFloat
    
    private let photoCollectionSizesCalculator: PhotoCollectionSizesCalculator = PhotoCollectionSizesCalculatorImpl()
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
        cardWidth = screenWidth - FeedCellConstraints.Card.insets.left - FeedCellConstraints.Card.insets.right
    }
    
    func calculateSize(postText: String?, postImages: [FeedCellPostImageViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        let (textSize, moreButtonSize) = calculatePostTextAndMoreButtonSizes(postText: postText, isFullSizedPost: isFullSizedPost)
        let imageSize = calculatePostImageSize(postImages: postImages)
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
    
    private func calculatePostImageSize(postImages: [FeedCellPostImageViewModel]) -> CGSize {
        guard !postImages.isEmpty else { return .zero }
        
        let photoSizes = postImages.map{ CGSize(width: $0.width, height: $0.height) }
        let imageHeight = photoCollectionSizesCalculator.calculateLayoutHeight(superviewWidth: cardWidth, photoSizes: photoSizes)
        
        return CGSize(width: cardWidth, height: imageHeight)
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
