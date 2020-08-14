//
//  FloatingViewProtocolComponent.swift
//  FloatingViewProtocol
//
//  Created by natai on 2018/7/16.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

public struct FloatingAdsorbableEdges: OptionSet {
    public let rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static let top = FloatingAdsorbableEdges(rawValue: 1)
    public static let left = FloatingAdsorbableEdges(rawValue: 1 << 1)
    public static let bottom = FloatingAdsorbableEdges(rawValue: 1 << 2)
    public static let right = FloatingAdsorbableEdges(rawValue: 1 << 3)
}

public enum FloatingAdsorbPriority: Int {
    case horizontalHigher   // 只进行水平吸附
    case equal              // 水平、垂直都吸附
    case verticalHigher     // 只进行垂直吸附
}

public class FloatingViewProtocolComponent {
    var isDraggable = true
    var isAutoAdsorb = true
    var adsorbableEdges: FloatingAdsorbableEdges = [.top, .left, .bottom, .right]
    var adsorbPriority: FloatingAdsorbPriority = .verticalHigher
    var adsorbAnimationDuration: TimeInterval = 0.35
    var isAutoPartiallyHide = false
    var partiallyHidePercent: CGFloat = 0.5
    var partiallyHideAnimationDuration: TimeInterval = 0.35
    var floatingEdgeInsets: UIEdgeInsets = .zero
    var minAdsorbableSpacings: UIEdgeInsets?
    
    public init() {}
}
