//
//  DoodleCollectionDelegateFlowLayout.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/29.
//

import UIKit

class DoodleCollectionDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    
    var onUpdateTouchedSave: (Int) -> Void = { _ in }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: UIScreen.main.bounds.width, spacing: LayoutConstant.spacing)
        return CGSize(width: width, height: 50.0)
    }
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        let totalSpacing:  CGFloat = (2 * spacing) + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return finalWidth - 5
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let saveAction = UIAction(title: "Save") { [unowned self] _ in
                self.onUpdateTouchedSave(indexPath.row)
            }
            
            return UIMenu(title: "", children: [saveAction])
        }
    }
}
