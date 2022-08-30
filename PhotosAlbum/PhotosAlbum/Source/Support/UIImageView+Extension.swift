//
//  UIImageView Extensions +.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/26.
//

import UIKit
import Photos

extension UIImageView {
    func fetchImageAsset(_ asset: PHAsset?, targetSize size: CGSize, contentMode: PHImageContentMode = .aspectFill, options: PHImageRequestOptions? = nil, completionHandler: ((Bool) -> Void)?) {
      
      guard let asset = asset else {
        completionHandler?(false)
        return
      }
      
      let resultHandler: (UIImage?, [AnyHashable: Any]?) -> Void = { image, info in
        self.image = image
        completionHandler?(true)
      }
      
      PHCachingImageManager.default().requestImage(
        for: asset,
        targetSize: size,
        contentMode: contentMode,
        options: options,
        resultHandler: resultHandler)
    }
}
