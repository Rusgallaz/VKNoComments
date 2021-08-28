//
//  PhotoCollectionSizesCalculator.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 28.08.2021.
//

import Foundation
import UIKit

protocol PhotoCollectionSizesCalculator {
    func calculateLayoutHeight(superviewWidth: CGFloat, photoSizes: [CGSize]) -> CGFloat
}

class PhotoCollectionSizesCalculatorImpl: PhotoCollectionSizesCalculator {
    func calculateLayoutHeight(superviewWidth: CGFloat, photoSizes: [CGSize]) -> CGFloat {
        let photoSizeWithMinRatio = photoSizes.min { ($0.height / $0.width) < ($1.height / $1.width) }
        guard let photoSizeWithMinRatio = photoSizeWithMinRatio else { return 0 }
        return photoSizeWithMinRatio.height / photoSizeWithMinRatio.width * superviewWidth
    }
}
