//
//  FloatingViewDelegate.swift
//  FloatingViewProtocol
//
//  Created by natai on 2018/7/13.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

public protocol FloatingViewDelegate: NSObjectProtocol {
    func floatingViewDidBeginDragging(panGestureRecognizer: UIPanGestureRecognizer)
    func floatingViewDidEndDragging(panGestureRecognizer: UIPanGestureRecognizer)
    func floatingViewDidMove(panGestureRecognizer: UIPanGestureRecognizer)
    func floatingViewFinishedPartiallyHideAnimation()
}

public extension FloatingViewDelegate {
    func floatingViewDidBeginDragging(panGestureRecognizer: UIPanGestureRecognizer) { }
    func floatingViewDidEndDragging(panGestureRecognizer: UIPanGestureRecognizer) { }
    func floatingViewDidMove(panGestureRecognizer: UIPanGestureRecognizer) { }
    func floatingViewFinishedPartiallyHideAnimation() { }
}
