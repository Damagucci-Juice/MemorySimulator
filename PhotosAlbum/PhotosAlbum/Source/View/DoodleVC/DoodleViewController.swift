//
//  DoodleViewController.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/29.
//

import UIKit

class DoodleViewController: UICollectionViewController {
    
    private let dataSource = DoodleDataSource(repo: DoodleImageRepositoryImplement())
    private let delegate = DoodleCollectionDelegateFlowLayout()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: .none, bundle: .none)
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.collectionView.collectionViewLayout = layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder has been implemented.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        
        configureNavigationItems()
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self.delegate
        collectionView.dataSource = self.dataSource

        self.collectionView.backgroundColor = UIColor.systemGray4
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
    
    private func configureNavigationItems() {
        let closeButton = UIBarButtonItem(title: "close", image: nil, primaryAction: UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }), menu: nil)
        self.navigationItem.rightBarButtonItem = closeButton
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Doodles"
    }
}
