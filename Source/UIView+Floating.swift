//
//  UIView+Floating.swift
//  FloatingViewProtocol
//
//  Created by natai on 2018/7/10.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

private var floatingPanGestureKey = "floatingPanGestureKey"
private var floatingDelegateKey = "floatingDelegateKey"

public extension UIView {
    weak var floatingDelegate: FloatingViewDelegate? {
        get {
            return objc_getAssociatedObject(self, &floatingDelegateKey) as? FloatingViewDelegate
        }
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &floatingDelegateKey, newValue as FloatingViewDelegate?, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    var floatingPanGesture: UIPanGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &floatingPanGestureKey) as? UIPanGestureRecognizer
        }
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &floatingPanGestureKey, newValue as UIPanGestureRecognizer?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addFloatingPanGestureRecognizer() {
        guard floatingPanGesture == nil else { return }
        floatingPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleFloatingViewPanGesture))
        addGestureRecognizer(floatingPanGesture!)
    }
    
    @objc private func handleFloatingViewPanGesture(_ pan: UIPanGestureRecognizer) {
        guard let view = self as? (UIView & FloatingViewProtocol), view.isDraggable else { return }
        
        switch pan.state {
        case .began:
            floatingDelegate?.floatingViewDidBeginDragging(view)
        case .changed:
            defer {
                pan.setTranslation(.zero, in: self)
            }
            let translation = pan.translation(in: self)
            modifyOrigin(withTranslation: translation)
            floatingDelegate?.floatingViewDidMove(view)
        case .ended:
            animateToAdsorb()
            floatingDelegate?.floatingViewDidEndDragging(view)
        default: break
        }
    }
    
    private func modifyOrigin(withTranslation translation: CGPoint) {
        guard let view = self as? FloatingViewProtocol, let superview = superview else { return }
        
        let minOriginX = view.isAutoAdsorb ? min(view.floatingEdgeInsets.left, 0) : view.floatingEdgeInsets.left
        let minOriginY = view.isAutoAdsorb ? min(view.floatingEdgeInsets.top, 0) : view.floatingEdgeInsets.top
        let maxOriginX = view.isAutoAdsorb ? max(superview.bounds.width - bounds.width - view.floatingEdgeInsets.right, superview.bounds.width - bounds.width) : superview.bounds.width - bounds.width - view.floatingEdgeInsets.right
        let maxOriginY = view.isAutoAdsorb ? max(superview.bounds.height - bounds.height - view.floatingEdgeInsets.bottom, superview.bounds.height - bounds.height) : superview.bounds.height - bounds.height - view.floatingEdgeInsets.bottom
        let tmpOriginX = frame.origin.x + translation.x
        let tmpOriginY = frame.origin.y + translation.y

        // 未到最后仍向右移，未到最左仍向左移
        if (tmpOriginX <= maxOriginX && translation.x > 0) || (tmpOriginX >= minOriginX && translation.x < 0) {
            frame.origin.x = tmpOriginX
        }
        // 未到最下仍向下移，未到最上仍向上移
        if (tmpOriginY <= maxOriginY && translation.y > 0) || (tmpOriginY >= minOriginY && translation.y < 0) {
            frame.origin.y = tmpOriginY
        }
    }
    
    private func animateToAdsorb() {
        guard let view = self as? FloatingViewProtocol,
              let superview = superview, view.isAutoAdsorb,
              view.floatingEdgeInsets.left + view.floatingEdgeInsets.right + frame.width * 2 <= superview.frame.width,
              view.floatingEdgeInsets.top + view.floatingEdgeInsets.bottom + frame.height * 2 <= superview.frame.height else {
                return
        }
        
        let accessibleCenterX = (superview.frame.width + view.floatingEdgeInsets.left - view.floatingEdgeInsets.right) / 2
        let accessibleCenterY = (superview.frame.height + view.floatingEdgeInsets.top - view.floatingEdgeInsets.bottom) / 2
        let accessibleMinX = view.floatingEdgeInsets.left
        let accessibleMinY = view.floatingEdgeInsets.top
        let accessibleMaxX = superview.bounds.width - view.floatingEdgeInsets.right
        let accessibleMaxY = superview.bounds.height - view.floatingEdgeInsets.bottom
        var destinationOrigin = frame.origin
        var adsorbedEdges: [FloatingAdsorbableEdges] = []
        
        if view.adsorbableEdges.contains(.top), center.y < accessibleCenterY, frame.minY < view.minAdsorbableSpacings.top + accessibleMinY {
            destinationOrigin.y = max(accessibleMinY, 0)
            adsorbedEdges.append(.top)
        } else if view.adsorbableEdges.contains(.bottom), center.y >= accessibleCenterY, frame.maxY > accessibleMaxY - view.minAdsorbableSpacings.bottom {
            destinationOrigin.y = min(accessibleMaxY - frame.height, superview.frame.height - frame.height)
            adsorbedEdges.append(.bottom)
        }
        
        if view.adsorbableEdges.contains(.left), center.x < accessibleCenterX, frame.minX < view.minAdsorbableSpacings.left + accessibleMinX {
            destinationOrigin.x = max(accessibleMinX, 0)
            adsorbedEdges.append(.left)
        } else if view.adsorbableEdges.contains(.right), center.x >= accessibleCenterX, frame.maxX > accessibleMaxX - view.minAdsorbableSpacings.right {
            destinationOrigin.x = min(accessibleMaxX - frame.width, superview.frame.width - frame.width)
            adsorbedEdges.append(.right)
        }
        
        // 须在确定所有可吸附方向后再根据优先级筛选
        switch view.adsorbPriority {
        case .horizontalHigher:
            // 只有一个方向的时候，不需要再做多余处理
            guard adsorbedEdges.count == 2 else { break }
            if adsorbedEdges.contains(.top) {
                destinationOrigin.y = max(frame.origin.y, accessibleMinY, 0)
            } else if adsorbedEdges.contains(.bottom) {
                destinationOrigin.y = min(frame.origin.y, accessibleMaxY - bounds.height, superview.frame.height - bounds.height)
            }
            // 筛除后供 partiallyHide 使用
            adsorbedEdges = adsorbedEdges.filter { $0 == .left || $0 == .right }
        case .verticalHigher:
            guard adsorbedEdges.count == 2 else { break }
            if adsorbedEdges.contains(.left) {
                destinationOrigin.x = max(frame.origin.x, accessibleMinX, 0)
            } else if adsorbedEdges.contains(.right) {
                destinationOrigin.x = min(frame.origin.x, accessibleMaxX - bounds.width, superview.frame.width - bounds.width)
            }
            adsorbedEdges = adsorbedEdges.filter { $0 == .top || $0 == .bottom }
        default: break
        }
        
        guard destinationOrigin != frame.origin else { return }
        UIView.animate(withDuration: view.adsorbAnimationDuration, animations: {
            self.frame.origin = destinationOrigin
        }) { isFinished in
            self.animatePartiallyHideView(atEdges: adsorbedEdges)
        }
    }
    
    private func animatePartiallyHideView(atEdges edges: [FloatingAdsorbableEdges]) {
        guard let view = self as? (UIView & FloatingViewProtocol), view.isAutoPartiallyHide else { return }
        
        var destinationOrigin = frame.origin
        for edge in edges {
            if edge == .top {
                destinationOrigin.y -= frame.height * view.partiallyHidePercent
            }
            if edge == .left {
                destinationOrigin.x -= frame.width * view.partiallyHidePercent
            }
            if edge == .bottom {
                destinationOrigin.y += frame.height * view.partiallyHidePercent
            }
            if edge == .right {
                destinationOrigin.x += frame.height * view.partiallyHidePercent
            }
        }
        
        guard destinationOrigin != frame.origin else { return }
        UIView.animate(withDuration: view.partiallyHideAnimationDuration, animations: {
            self.frame.origin = destinationOrigin
        }) { isFinished in
            self.floatingDelegate?.floatingViewFinishedPartiallyHideAnimation(view)
        }
    }
}
