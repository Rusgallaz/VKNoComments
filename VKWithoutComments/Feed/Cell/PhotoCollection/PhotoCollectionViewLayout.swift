//
//  PhotoCollectionViewLayout.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 28.08.2021.
//

import Foundation
import UIKit

protocol PhotoCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, photoSizeAIndexPath indexPath: IndexPath) -> CGSize
}

class PhotoCollectionViewLayout: UICollectionViewLayout {
    weak var delegate: PhotoCollectionViewLayoutDelegate!
    
    private let photoCollectionSizesCalculator: PhotoCollectionSizesCalculator = PhotoCollectionSizesCalculatorImpl()
    private var cache = [UICollectionViewLayoutAttributes]()

    private var cellPadding: CGFloat = 0
    private var contentWidth: CGFloat = 0
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.height
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        contentWidth = 0
        cache = []
        guard let collectionView = collectionView else { return }
        
        var photoSizes = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoSizeAIndexPath: indexPath)
            photoSizes.append(photoSize)
        }
        
        let rowHeight = photoCollectionSizesCalculator.calculateLayoutHeight(superviewWidth: collectionView.frame.width, photoSizes: photoSizes)
        
        var xOffset: CGFloat = 0
        let photoRatios = photoSizes.map { $0.height / $0.width }
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let ratio = photoRatios[item]
            let width = rowHeight / ratio
            let frame = CGRect(x: xOffset, y: 0, width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            
            contentWidth = max(contentWidth, frame.maxX)
            xOffset += width
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleAttributes.append(attribute)
            }
        }
        return visibleAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
}
