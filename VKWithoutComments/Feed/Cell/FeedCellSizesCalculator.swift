//
//  FeedCellSizesCalculator.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import Foundation
import UIKit

protocol FeedCellSizesCalculator {
    func calculateSize() -> FeedCellSizes
}

struct FeedCellSizesCalculatorImpl: FeedCellSizesCalculator {
    
    func calculateSize() -> FeedCellSizes {
        return Feed.FetchFeed.ViewModel.Sizes(postSize: CGRect.zero, imageSize: CGRect.zero)
    }
    
}
