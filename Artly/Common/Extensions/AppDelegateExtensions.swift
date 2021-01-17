//
//  AppDelegateExtensions.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import UIKit

extension AppDelegate {
    func setupWindow() {
        self.window = UIWindow()
        self.window?.backgroundColor = .appBackground
    }
    
    func setupInitialScene() {
        self.window?.rootViewController = setupMainAppFlow()
        self.window?.makeKeyAndVisible()
    }
    
    private func setupMainAppFlow() -> UIViewController {
        return UsersViewController()
    }
}

extension SceneDelegate {
    func setupInitialScene(using scene: UIScene) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        window.makeKeyAndVisible()
        window.rootViewController = NavigationController.init(rootViewController: UsersViewController())
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window = window
    }
}
