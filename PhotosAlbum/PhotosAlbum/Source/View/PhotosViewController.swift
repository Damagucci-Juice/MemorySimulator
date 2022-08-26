//
//  PhotosViewController.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/25.
//

import UIKit

class PhotosViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let configuration = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: configuration)
        return collectionView
    }()
    
    let photosDelegate = PhotoCollectionDelegateFlowLayout()
    let photosDataSource = PhotoCollectionViewDataSource()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        // 초기화 로직
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder has been implemented.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureLayout()
        configureAttribute()
    }

    private func configureLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureViews() {
        self.view.addSubview(collectionView)
    }
    
    private func configureAttribute() {
        collectionView.register(PhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self.photosDataSource
        collectionView.delegate = self.photosDelegate
    }
}
