//
//  DoodleDataSource.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/29.
//

import UIKit

class DoodleDataSource: NSObject, UICollectionViewDataSource {
    
    let imageRepository: DoodleImageRepository
    let images: [Image]
    
    init(repo: DoodleImageRepository) {
        self.imageRepository = repo
        self.images = imageRepository.convertDataToJson()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageRepository.convertDataToJson().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath)
                as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let imageString = images[indexPath.row].image
        
        
        self.imageRepository.loadAnImage(url: imageString) { img in
            DispatchQueue.main.async {
                
                cell.photoImageView.image = img
            }
        }
        
        return cell
    }
}
