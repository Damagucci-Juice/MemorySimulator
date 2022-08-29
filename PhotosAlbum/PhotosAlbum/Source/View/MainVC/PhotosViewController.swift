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
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        self.view.addSubview(collectionView)

        configureLayout()
        configureAttribute()
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PHPhotoLibrary.shared().register(self)
        getPermissionIfNecessary { granted in
            guard granted else { return }
            self.photosDataSource.fetchAssets()
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
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
    
    private func configureAttribute() {
        //MARK: - CollectionView's Settings
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier
        )
        collectionView.dataSource = self.photosDataSource
        collectionView.delegate = self.photosDelegate
    }
}

extension PhotosViewController {
    private func configureNavigation() {
        //MARK: - NavigationController's Settings
        self.navigationItem.title = "Photos"
        self.navigationController?.view.backgroundColor = .white
        
        let doneAction = UIAction { _ in
            print("Touched \"Done\" button")
        }
        
        let modalAction = UIAction { _ in
            let layout = UICollectionViewFlowLayout()
            let vc = DoodleViewController(collectionViewLayout: layout)
            self.navigationController?.pushViewController(vc, animated: true)
//            self.navigationController?.present(vc, animated: true, completion: nil)
        }
        
        let doneButton = UIBarButtonItem(title: "Done", image: .none, primaryAction: doneAction, menu: nil)
        doneButton.style = .done
        let addButton = UIBarButtonItem(title: nil, image: .add, primaryAction: modalAction, menu: nil)
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = addButton
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
