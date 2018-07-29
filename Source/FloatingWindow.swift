//
//  FloatingWindow.swift
//  FloatingViewProtocol
//
//  Created by natai on 2018/7/10.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

class FloatingWindowManager {
    static let shared = FloatingWindowManager()
    
    var floatingWindow: FloatingWindow?
}

class FloatingWindow: UIWindow {
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            floatingWindowRootViewController.statusBarStyle = statusBarStyle
            UIView.animate(withDuration: 0.35) {
                self.floatingWindowRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    private var floatingWindowRootViewController: FloatingWindowRootViewController
    
    init(frame: CGRect, statusBarStyle: UIStatusBarStyle) {
        floatingWindowRootViewController = FloatingWindowRootViewController()
        super.init(frame: frame)
        self.statusBarStyle = statusBarStyle
        floatingWindowRootViewController.statusBarStyle = statusBarStyle
        rootViewController = floatingWindowRootViewController
        rootViewController?.view.backgroundColor = UIColor.clear
        rootViewController?.view.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subView in subviews {
            if subView is FloatingViewProtocol, subView.bounds.contains(subView.convert(point, from: self)) {
                return super.point(inside: point, with: event)
            }
        }
        return false
    }
}

class FloatingWindowRootViewController: UIViewController {
    var statusBarStyle: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}
