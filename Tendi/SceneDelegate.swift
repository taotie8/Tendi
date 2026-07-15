//
//  SceneDelegate.swift
//  Tendi
//
//  Created by JIAO on 2026/7/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = self.window ?? UIWindow(windowScene: windowScene)
        let rootViewController = (window.rootViewController as? AuthMainViewController) ?? AuthMainViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.setNavigationBarHidden(true, animated: false)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
    }

}

