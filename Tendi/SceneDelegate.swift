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
        window.rootViewController = TendiAuthSession.makeInitialRootViewController()
        window.makeKeyAndVisible()
        self.window = window
        
    }

}
