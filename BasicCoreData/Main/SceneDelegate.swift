//
//  SceneDelegate.swift
//  BasicCoreData
//
//  Created by David Molina on 12/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setInitialController(to: windowScene)
    }

}

@available(iOS 13.0, *)
private extension SceneDelegate {
    
    func setInitialController(to windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = navigationController
        return
    }

}

