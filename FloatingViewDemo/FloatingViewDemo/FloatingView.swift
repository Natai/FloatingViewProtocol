//
//  FloatingView.swift
//  FloatingViewDemo
//
//  Created by natai on 2018/7/16.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit
import FloatingViewProtocol

class FloatingView: UIView, FloatingViewProtocol {
    // 遵守协议后，可以重写属性，这里全部保持默认
    let component = FloatingViewProtocolComponent()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        intialConfigure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        
        intialConfigure()
    }
    
    private func intialConfigure() {
        backgroundColor = UIColor.cyan
        layer.cornerRadius = bounds.width / 2
        addFloatingPanGestureRecognizer()
    }
}
