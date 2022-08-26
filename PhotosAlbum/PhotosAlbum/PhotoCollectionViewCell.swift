//
//  PhotoCollectionViewCell.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/26.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    private let photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setUpPhoto(color: UIColor) {
        contentView.backgroundColor = color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(photoImageView)
        
        //MARK: - 어째서 오토레이아웃이 안잡혀도 들어가 있다고 생각하는 거지?
//        contentView.backgroundColor = .blue
//        photoImageView.adjustsImageSizeForAccessibilityContentSizeCategory = false
//        NSLayoutConstraint.activate([
//            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//        ])
    }
}
