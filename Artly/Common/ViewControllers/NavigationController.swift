//
//  NavigationController.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .darkContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .appBackground
        navigationBar.shadowImage = UIImage()
        setupDesign(.standard)
        navigationBar.titleTextAttributes = [
            .font: UIFont.font(ofSize: 25, weight: .medium),
            .foregroundColor: UIColor.appTheme
        ]
    }
}
