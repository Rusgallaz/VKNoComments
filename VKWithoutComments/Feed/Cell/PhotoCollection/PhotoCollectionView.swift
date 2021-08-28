//
//  PhotoCollectionView.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 27.08.2021.
//

import Foundation
import UIKit

class PhotoCollectionView: UICollectionView {
    
    private var photos = [FeedCellPostImageViewModel]()
    
    init() {
        let layout = PhotoCollectionViewLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        if let layout = collectionViewLayout as? PhotoCollectionViewLayout {
            layout.delegate = self
        }
        
        backgroundColor = .lightGray
        
        register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseId)
    }
    
    func set(_ photos: [FeedCellPostImageViewModel]) {
        self.photos = photos
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: UICollectionViewDelegate
extension PhotoCollectionView: UICollectionViewDelegate {
    
}

//MARK: UICollectionViewDataSource
extension PhotoCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseId, for: indexPath) as! PhotoCollectionViewCell
        cell.set(photos[indexPath.row])
        return cell
    }
}

//MARK: PhotoCollectionViewLayoutDelegate
extension PhotoCollectionView: PhotoCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoSizeAIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
    
    
}
