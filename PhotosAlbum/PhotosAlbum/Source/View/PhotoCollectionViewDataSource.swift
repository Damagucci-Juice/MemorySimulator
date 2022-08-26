//
//  PhotoCollectionViewDataSource.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/26.
//

import UIKit

final class PhotoCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let colorCount = 40
        return colorCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        var array: [CGFloat] = []
        for _ in 0..<3 {
            let randomFloat: CGFloat = CGFloat.random(in: 0...1)
            array.append(randomFloat)
        }
        let randomColor = UIColor(red: array[0], green: array[1], blue: array[2], alpha: 1)
        cell.setUpPhoto(color: randomColor)
        return cell
    }
}
