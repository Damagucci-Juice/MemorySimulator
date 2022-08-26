//
//  PhotosViewController.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/25.
//

import UIKit
import Photos

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
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder has been implemented.")
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureLayout()
        configureAttribute()
//        configureBinding()
        getPermissionIfNecessary { granted in
            guard granted else { return }
            self.photosDataSource.fetchAssets()
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PHPhotoLibrary.shared().register(self)
    }
    
//    private func configureBinding() {
//
//    }
    
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
        //MARK: - CollectionView's Settings
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier
        )
        collectionView.dataSource = self.photosDataSource
        collectionView.delegate = self.photosDelegate
        
        //MARK: - NavigationController's Settings
        self.navigationItem.title = "Photos"
        self.navigationController?.view.backgroundColor = .white
        let action = UIAction { _ in
            print("Touched \"Done\" button")
        }
        let doneButton = UIBarButtonItem(
            title: "Done", image: .none, primaryAction: action, menu: nil)
        doneButton.style = .done
        self.navigationItem.rightBarButtonItem = doneButton
    }
}

extension PhotosViewController {
    func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
        
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
          completionHandler(true)
          return
        }
        PHPhotoLibrary.requestAuthorization { status in
          completionHandler(status == .authorized)
        }
    }
    
}

extension PhotosViewController: PHPhotoLibraryChangeObserver {

    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let change = changeInstance.changeDetails(for: photosDataSource.allPhotos)
              else { return }
        let changedResult = change.fetchResultAfterChanges
        photosDataSource.updateAssets(fetchResult: changedResult)
        
        DispatchQueue.main.sync { [weak self] in
            self?.collectionView.reloadData()
        }
    }

}
