//
//  TouchGestureRecognizer.swift
//  Extensions
//
//  Created by Aleksander Wędrychowski on 16/01/2021.
//

import UIKit.UIGestureRecognizerSubclass

final class TouchGestureReconizer: UIPanGestureRecognizer {
    private var beginAction: ((UITouch?) -> Void)?
    private var endAction: (() -> Void)?
    private var shouldEndActionOccursWhenMoved: Bool = true
    private var handler: UIGestureRecognizerDelegate = TouchGestureHandler()
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        setup()
    }
    
    private func setup() {
        delegate = handler
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        beginAction?(touches.first)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if shouldEndActionOccursWhenMoved,
           touches.filter({ self.view?.bounds.contains($0.location(in: self.view)) == false }).first != nil {
            endAction?()
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        endAction?()
        super.touchesEnded(touches, with: event)
    }
    
    func addAction(beginAction: @escaping (UITouch?) -> Void, endAction: @escaping () -> Void, shouldEndActionOccursWhenMoved: Bool = true) {
        self.shouldEndActionOccursWhenMoved = shouldEndActionOccursWhenMoved
        self.beginAction = beginAction
        self.endAction = endAction
        self.cancelsTouchesInView = false
    }
}

private final class TouchGestureHandler: NSObject, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
