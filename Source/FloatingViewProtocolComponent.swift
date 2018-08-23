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
    
    public init(rawValue: FloatingAdsorbableEdges.RawValue) {
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
    public var isDraggable = true
    public var isAutoAdsorb = true
    public var adsorbableEdges: FloatingAdsorbableEdges = [.top, .left, .bottom, .right]
    public var adsorbPriority: FloatingAdsorbPriority = .verticalHigher
    public var adsorbAnimationDuration: TimeInterval = 0.35
    public var isAutoPartiallyHide = false
    public var partiallyHidePercent: CGFloat = 0.5
    public var partiallyHideAnimationDuration: TimeInterval = 0.35
    public var floatingEdgeInsets: UIEdgeInsets = .zero
    public var minAdsorbableSpacings: UIEdgeInsets?
    
    public init() {}
}
