//
//  ViewController1.swift
//  FloatingViewDemo
//
//  Created by natai on 2018/7/16.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    let floatingView = FloatingView(frame: CGRect(x: 0, y: 100, width: 60, height: 60))

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.view.addSubview(floatingView)
        navigationController?.interactivePopGestureRecognizer?.require(toFail: floatingView.floatingPanGesture!)
    }
    
    deinit {
        floatingView.removeFromSuperview()
    }
}
