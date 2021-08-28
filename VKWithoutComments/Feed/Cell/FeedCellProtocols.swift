//
//  FeedCellProtocols.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 26.08.2021.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrl: String { get }
    var name: String { get }
    var date: String { get }
    var postText: String? { get }
    var likesCount: String { get }
    var viewsCount: String { get }
    var postImages: [FeedCellPostImageViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellPostImageViewModel {
    var url: String { get }
    var height: Int { get }
    var width: Int { get }
}

protocol FeedCellSizes {
    var postSize: CGSize { get }
    var imageSize: CGSize { get }
    var moreButtonSize: CGSize { get }
    var cellHeight: CGFloat { get }
}

protocol FeedCellDelegate: AnyObject {
    func moreButtonPressedInCell(_ cell: FeedCellView)
}
