//
//  FloatingViewDelegate.swift
//  FloatingViewProtocol
//
//  Created by natai on 2018/7/13.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

public protocol FloatingViewDelegate: NSObjectProtocol {
    func floatingViewDidBeginDragging(_ floatingView: (UIView & FloatingViewProtocol))
    func floatingViewDidEndDragging(_ floatingView: (UIView & FloatingViewProtocol))
    func floatingViewDidMove(_ floatingView: (UIView & FloatingViewProtocol))
    func floatingViewFinishedPartiallyHideAnimation(_ floatingView: (UIView & FloatingViewProtocol))
}

public extension FloatingViewDelegate {
    func floatingViewDidBeginDragging(_ floatingView: (UIView & FloatingViewProtocol)) { }
    func floatingViewDidEndDragging(_ floatingView: (UIView & FloatingViewProtocol)) { }
    func floatingViewDidMove(_ floatingView: (UIView & FloatingViewProtocol)) { }
    func floatingViewFinishedPartiallyHideAnimation(_ floatingView: (UIView & FloatingViewProtocol)) { }
}
