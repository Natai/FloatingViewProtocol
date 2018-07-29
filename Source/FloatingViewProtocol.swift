//
//  FloatingViewProtocol.swift
//  FloatingViewProtocol
//
//  Created by natai on 2018/7/10.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

public protocol FloatingViewProtocol: NSObjectProtocol {
    var component: FloatingViewProtocolComponent { get }
    /// 是否可以拖拽
    var isDraggable: Bool { get set }
    /// 是否自动吸附
    var isAutoAdsorb: Bool { get set }
    /// 可自动吸附的方向
    var adsorbableEdges: FloatingAdsorbableEdges { get set }
    /// 水平方向吸附和垂直方向吸附的优先级
    var adsorbPriority: FloatingAdsorbPriority { get set }
    /// 吸附动画时间
    var adsorbAnimationDuration: TimeInterval { get set }
    /// 停止拖拽后，最小距离 floatingEdge 边缘多少可以自动吸附
    var minAdsorbableSpacings: UIEdgeInsets { get set }
    /// 吸附在边缘后是否自动地部分隐藏
    var isAutoPartiallyHide: Bool { get set }
    /// 隐藏的百分比
    var partiallyHidePercent: CGFloat { get set }
    /// 部分隐藏动画时长
    var partiallyHideAnimationDuration: TimeInterval { get set }
    /// 悬浮视图可到达区域，距离父视图各边的缩进
    var floatingEdgeInsets: UIEdgeInsets { get set }
}

// MARK: - Default Implement
public extension FloatingViewProtocol where Self: UIView {
    var isDraggable: Bool {
        get { return component.isDraggable }
        set { component.isDraggable = newValue }
    }
    
    var isAutoAdsorb: Bool {
        get { return component.isAutoAdsorb }
        set { component.isAutoAdsorb = newValue }
    }
    
    var adsorbableEdges: FloatingAdsorbableEdges {
        get { return component.adsorbableEdges }
        set { component.adsorbableEdges = newValue }
    }
    
    var adsorbPriority: FloatingAdsorbPriority {
        get { return component.adsorbPriority }
        set { component.adsorbPriority = newValue }
    }
    
    var adsorbAnimationDuration: TimeInterval {
        get { return component.adsorbAnimationDuration }
        set { component.adsorbAnimationDuration = newValue }
    }
    
    var isAutoPartiallyHide: Bool {
        get { return component.isAutoPartiallyHide }
        set { component.isAutoPartiallyHide = newValue }
    }
    
    var partiallyHidePercent: CGFloat {
        get { return component.partiallyHidePercent }
        set { component.partiallyHidePercent = newValue }
    }
    
    var partiallyHideAnimationDuration: TimeInterval {
        get { return component.partiallyHideAnimationDuration }
        set { component.partiallyHideAnimationDuration = newValue }
    }
    
    var floatingEdgeInsets: UIEdgeInsets {
        get { return component.floatingEdgeInsets }
        set { component.floatingEdgeInsets = newValue }
    }
    
    var minAdsorbableSpacings: UIEdgeInsets {
        get {
            if let spacings = component.minAdsorbableSpacings {
                return spacings
            }
            guard let superview = superview else { return .zero }
            let halfSuperWidth = superview.frame.width / 2
            return UIEdgeInsets(
                top: self.floatingEdgeInsets.top > 0 ? 100 : 100 - self.floatingEdgeInsets.top,
                left: halfSuperWidth - self.floatingEdgeInsets.left,
                bottom: self.floatingEdgeInsets.bottom > 0 ? 100 : 100 - self.floatingEdgeInsets.bottom,
                right: halfSuperWidth - self.floatingEdgeInsets.right
            )
        }
        set {
            component.minAdsorbableSpacings = newValue
        }
    }
}

// MARK: - FloatingWindow
public extension FloatingViewProtocol where Self: UIView {
    func makeFloatingWindowKeyAndVisible(statusBarStyle: UIStatusBarStyle = .default) {
        defer {
            FloatingWindowManager.shared.floatingWindow?.makeKeyAndVisible()
        }
        guard FloatingWindowManager.shared.floatingWindow == nil else { return }
        let floatingWindow = FloatingWindow(frame: UIScreen.main.bounds, statusBarStyle: statusBarStyle)
        floatingWindow.addSubview(self)
        // floatingWindow must be referenced, otherwise it cannot be displayed
        FloatingWindowManager.shared.floatingWindow = floatingWindow
    }
    
    func resignFloatingWindowKey() {
        FloatingWindowManager.shared.floatingWindow = nil
    }
    
    func updateFloatingWindowStatusBarStyle(to style: UIStatusBarStyle) {
        FloatingWindowManager.shared.floatingWindow?.statusBarStyle = style
    }
}
