//
//  UIView+addTouchAnimation.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import UIKit

extension UIView {
    
    public func addTouchAnimation(touchScale: CGFloat = 0.97, touchShadow: Float = 0) {
        let gestureRecognizer = TouchGestureReconizer()
        gestureRecognizer.addAction(
            beginAction: { [weak self] _ in
                self?.animateTouchedDown(scale: touchScale, shadowOpacity: touchShadow)
            },
            endAction: { [weak self] in
                self?.aniamteTouchedUp()
            })
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func animateTouchedDown(scale: CGFloat, shadowOpacity: Float, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.1,
            animations: { [weak self] in
                guard let self = self else { return }
                if self.hasShadow {
                    self.layer.shadowOpacity = shadowOpacity
                }
                self.transform = .init(scaleX: scale, y: scale)
            },
            completion: { [weak self] _ in
                if self is UIControl {
                    UIImpactFeedbackGenerator().impactOccurred()
                }
                completion?()
            })
    }
    
    @objc private func aniamteTouchedUp(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.1,
            animations: { [weak self] in
                guard let self = self else { return }
                if self.hasShadow {
                    self.layer.shadowOpacity = Constants.defaultShadowOpacity
                }
                self.transform = .init(scaleX: 1, y: 1)
            },
            completion: { _ in
                completion?()
            })
    }
}
