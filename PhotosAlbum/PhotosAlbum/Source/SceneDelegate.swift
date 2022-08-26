//
//  SceneDelegate.swift
//  PhotosAlbum
//
//  Created by YEONGJIN JANG on 2022/08/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController(rootViewController: PhotosViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

