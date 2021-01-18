//
//  UsersViewBuilder.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 13/01/2021.
//

import UIKit

final class UsersViewBuilder {
    private enum Constants {
        static var barItemSpacing: CGFloat = 3
    }
    func buildBarItem() -> (UIBarButtonItem, UISwitch) {
        let favoritesSwitch = UISwitch()
        favoritesSwitch.tintColor = .appTheme
        
        let label = UILabel()
        label.text = Strings.Users.showFollowed.localized
        label.font = .font(ofSize: 11, weight: .light)
        label.textColor = .additionalTextColor
        label.textAlignment = .right
        label.numberOfLines = 2
        let stackView = UIStackView(arrangedSubviews: [label, favoritesSwitch])
        stackView.spacing = Constants.barItemSpacing
        let barItem = UIBarButtonItem(customView: stackView)
        return (barItem, favoritesSwitch)
    }
}
