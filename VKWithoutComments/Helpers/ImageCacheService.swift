//
//  ImageCache.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import Foundation
import UIKit

class ImageCacheService {
    static let shared = ImageCacheService()
    
    private let cachedImages = NSCache<NSString, UIImage>()
    
    func load(url: URL, completion: @escaping (UIImage) -> Void) {
        if let image = image(url: url) {
            completion(image)
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            self.cachedImages.setObject(image, forKey: url.absoluteString as NSString)
            completion(image)
        }.resume()
    }
    
    private func image(url: URL) -> UIImage? {
        cachedImages.object(forKey: url.absoluteString as NSString)
    }
}
