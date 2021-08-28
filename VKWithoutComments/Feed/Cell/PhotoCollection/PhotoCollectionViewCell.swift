//
//  PhotoCollectionViewCell.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 27.08.2021.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseId = "PhotoCollectionViewCell_ID"
    
    private let photoImageView: CacheImageView = {
        let image = CacheImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    func set(_ photo: FeedCellPostImageViewModel) {
        photoImageView.set(url: photo.url)
    }
    
    private func setupLayout() {
        addSubview(photoImageView)
        photoImageView.fillSuperview()
    }
}
