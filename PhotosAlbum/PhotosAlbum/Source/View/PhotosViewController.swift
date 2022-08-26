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
        self.view.backgroundColor = UIColor.red
        self.collectionView.backgroundColor = UIColor.white
        collectionView.register(PhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension PhotosViewController: UICollectionViewDataSource {
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

extension PhotosViewController: UICollectionViewDelegate {
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private enum LayoutConstant {
        static let spacing: CGFloat = 2
        static let itemHeight: CGFloat = 80
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }

    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 4
        let totalSpacing:  CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return finalWidth - 5.0
    }
}
