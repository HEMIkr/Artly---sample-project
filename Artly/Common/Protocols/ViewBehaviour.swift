//
//  ViewBehaviour.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import UIKit

protocol ViewBehaviour: AnyObject {
    func displayError(_ error: Error)
}

extension ViewBehaviour where Self: UIViewController {
    func displayError(_ error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            alertController.addAction(.init(title: Strings.ok.localized, style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
