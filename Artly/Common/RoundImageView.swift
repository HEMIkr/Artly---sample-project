//
//  RoundImageView.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import UIKit

final class RoundImageView: UIImageView {

    override init(image: UIImage?) {
        super.init(image: image)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        backgroundColor = .appBackground
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
        addShadow()
        clipsToBounds = true
    }
}
