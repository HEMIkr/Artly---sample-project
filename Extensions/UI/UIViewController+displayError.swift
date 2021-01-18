//
//  UIViewController+displayError.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import UIKit

extension UIViewController {
    public func displayError(_ error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            alertController.addAction(.init(title: Strings.ok.localized, style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
