//
//  ImageCache.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/30.
//

import Foundation
import UIKit.UIImage

final class ImageCache {
    // 1st level cache, that contains encoded images
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    // 2nd level cache, that contains decoded images
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    private let config: Config
    
    struct Config {
        let countLimit: Int
        let memoryLimit: Int
        
        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }
    
    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

extension ImageCache: ImageCacheType {
    func removeAllImages() {
        self.imageCache.removeAllObjects()
        self.decodedImageCache.removeAllObjects()
    }
    
    func image(for url: URL) -> UIImage? {
        
        // the best case scenario -> there is a decoded image
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        // search for image data
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
            return decodedImage
        }
        return nil
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        let decodedImage = image.decodedImage()
        
        imageCache.setObject(image, forKey: url as AnyObject)
        decodedImageCache.setObject(decodedImage as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
    }
    
    func removeImage(for url: URL) {
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }
    
    subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
    
    
}
