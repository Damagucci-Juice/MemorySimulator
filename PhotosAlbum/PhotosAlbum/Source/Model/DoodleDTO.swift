//
//  DoodleDTO.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/29.
//

import Foundation

// MARK: - Image
struct Image: Codable {
    let title: String
    let image: String
    let date: String
}

typealias Images = [Image]

