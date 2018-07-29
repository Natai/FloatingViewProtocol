//
//  ViewController2.swift
//  FloatingViewDemo
//
//  Created by natai on 2018/7/16.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit
import FloatingViewProtocol

class ViewController2: UIViewController {
    let floatingView = FloatingView(frame: CGRect(x: 0, y: 100, width: 60, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        floatingView.makeFloatingWindowKeyAndVisible(statusBarStyle: .lightContent)
    }
    
    deinit {
        floatingView.resignFloatingWindowKey()
    }
}
