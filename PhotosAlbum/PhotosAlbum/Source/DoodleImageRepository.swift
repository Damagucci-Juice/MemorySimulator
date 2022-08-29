//
//  DoodleImageRepository.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/29.
//

import Foundation
import UIKit.UIImage

protocol DoodleImageRepository {
    func convertDataToJson() -> Array<Image>
    func loadAnImage(url: String, completion: @escaping (UIImage?) -> Void)
}

final class DoodleImageRepositoryImplement: DoodleImageRepository {
    
    func convertDataToJson() -> Array<Image> {
        
        if let path = Bundle.main.path(forResource: "doodle", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let images = try? JSONDecoder().decode(Images.self, from: data) {
                    
                    return images
                }
                
            } catch {
                print("error MSG")
            }
        } else {
            fatalError("failed to find path")
        }
        fatalError("failed to find path")
    }
    
    func loadAnImage(url: String, completion: @escaping (UIImage?) -> Void) {
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        let queue = DispatchQueue.global(qos: .background)
        
        dataTask?.cancel()
        guard let urlComponents = URLComponents(string: url) else { fatalError() }
        guard let url = urlComponents.url else { fatalError() }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            
            defer {
                dataTask = nil
            }
            
            guard let data = data, error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200
            else { return completion(nil) }
            
            let uiImage = UIImage(data: data)
            queue.async {
                completion(uiImage)
            }

        }
        dataTask?.resume()
    }
}
