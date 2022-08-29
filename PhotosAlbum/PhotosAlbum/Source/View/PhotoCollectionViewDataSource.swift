//
//  PhotoCollectionViewDataSource.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/26.
//

import UIKit
import Photos

final class PhotoCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private(set) var allPhotos = PHFetchResult<PHAsset>()
    private let cacheImageManager = PHCachingImageManager()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier,
                    for: indexPath
                )
                as? PhotoCollectionViewCell
                
        else { return UICollectionViewCell() }
        
        let photoAsset: PHAsset = allPhotos[indexPath.row]
        
        //TODO: - 실패하면 색을 만드는 팩토리 메서드 패턴으로 색을 주입
        cell.photoImageView.fetchImageAsset(photoAsset, targetSize: cell.bounds.size) { success in
            
        }
        return cell
    }

    func fetchAssets() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
          NSSortDescriptor(
            key: "creationDate",
            ascending: false)
        ]
        
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        var assets: [PHAsset] = []
        
        for i in 0..<allPhotos.count {
            assets.append(allPhotos[i])
        }
        
        cacheImageManager.startCachingImages(for: assets, targetSize: CGSize(width: 90, height: 90), contentMode: .aspectFit, options: .none)
    }
    
    func updateAssets(fetchResult: PHFetchResult<PHAsset>) {
        self.allPhotos = fetchResult
    }
    
}

