//
//  ImageLoader.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/30.
//

import UIKit
import Combine

final class ImageLoader {
    
    private let backgroundQueue = DispatchQueue.global(qos: .background)
    private let cache = ImageCache()
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, _) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: { [unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
