//
//  ChacheImageView.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import Foundation
import UIKit

class CacheImageView: UIImageView {
    
    func set(url: String) {
        guard let url = URL(string: url) else { return }
        ImageCacheService.shared.load(url: url) { [weak self] uiImage in
            DispatchQueue.main.async {
                self?.image = uiImage
            }
        }
    }
}
