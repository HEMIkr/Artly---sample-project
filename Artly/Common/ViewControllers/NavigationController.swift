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
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.gray
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.addShadow()
    }
}
