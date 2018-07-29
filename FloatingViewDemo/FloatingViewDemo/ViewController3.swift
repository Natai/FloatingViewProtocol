//
//  ViewController3.swift
//  FloatingViewDemo
//
//  Created by natai on 2018/7/16.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit
import FloatingViewProtocol

class ViewController3: UITableViewController {
    let floatingView = FloatingView(frame: CGRect(x: 0, y: 100, width: 60, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag

        floatingView.floatingDelegate = self
        floatingView.makeFloatingWindowKeyAndVisible()
    }
    
    deinit {
        floatingView.resignFloatingWindowKey()
    }
}

// MARK: - Action
extension ViewController3 {
    @IBAction func draggleSwitchTapped(_ sender: UISwitch) {
        floatingView.isDraggable = sender.isOn
    }
    
    @IBAction func autoAdsorbSwitchTapped(_ sender: UISwitch) {
        floatingView.isAutoAdsorb = sender.isOn
    }
    
    @IBAction func topEdgeAdsorbSwitchTapped(_ sender: UISwitch) {
        if sender.isOn {
            floatingView.adsorbableEdges.insert(.top)
        } else {
            floatingView.adsorbableEdges.remove(.top)
        }
    }
    
    @IBAction func leftEdgeAdsorbSwitchTapped(_ sender: UISwitch) {
        if sender.isOn {
            floatingView.adsorbableEdges.insert(.left)
        } else {
            floatingView.adsorbableEdges.remove(.left)
        }
    }
    
    @IBAction func bottomEdgeAdsorbSwitchTapped(_ sender: UISwitch) {
        if sender.isOn {
            floatingView.adsorbableEdges.insert(.bottom)
        } else {
            floatingView.adsorbableEdges.remove(.bottom)
        }
    }
    
    @IBAction func rightEdgeAdsorbSwitchTapped(_ sender: UISwitch) {
        if sender.isOn {
            floatingView.adsorbableEdges.insert(.right)
        } else {
            floatingView.adsorbableEdges.remove(.right)
        }
    }
    
    @IBAction func adsorbPrioritySegmentTapped(_ sender: UISegmentedControl) {
        floatingView.adsorbPriority = FloatingAdsorbPriority(rawValue: sender.selectedSegmentIndex) ?? .verticalHigher
    }
    
    @IBAction func partiallyHideSwitchTapped(_ sender: UISwitch) {
        floatingView.isAutoPartiallyHide = sender.isOn
    }
    
    @IBAction func statusBarStyleSegmentTapped(_ sender: UISegmentedControl) {
        // 需要将 flaotingView 添加到 window 中才可以直接切换状态栏；否则需要自行处理
        let style = UIStatusBarStyle(rawValue: sender.selectedSegmentIndex) ?? .default
        floatingView.updateFloatingWindowStatusBarStyle(to: style)
    }
}

// MARK: - UITextFieldDelegate
extension ViewController3: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text,
              let textField = textField as? FloatValueField else { return }
        switch textField.tag {
        case 10:
            floatingView.adsorbAnimationDuration = TimeInterval(text) ?? 0.35
        case 11:
            floatingView.minAdsorbableSpacings.top = textField.floatValue
        case 12:
            floatingView.minAdsorbableSpacings.left = textField.floatValue
        case 13:
            floatingView.minAdsorbableSpacings.bottom = textField.floatValue
        case 14:
            floatingView.minAdsorbableSpacings.right = textField.floatValue
        case 20:
            floatingView.partiallyHidePercent = min(textField.floatValue, 0.8)
        case 21:
            floatingView.partiallyHideAnimationDuration = TimeInterval(text) ?? 0.35
        case 30:
            floatingView.floatingEdgeInsets.top = textField.floatValue
        case 31:
            floatingView.floatingEdgeInsets.left = textField.floatValue
        case 32:
            floatingView.floatingEdgeInsets.bottom = textField.floatValue
        case 33:
            floatingView.floatingEdgeInsets.right = textField.floatValue
        default: break
        }
    }
}

// MARK: - FloatingViewDelegate
extension ViewController3: FloatingViewDelegate {
    func floatingViewDidBeginDragging(_ floatingView: (UIView & FloatingViewProtocol)) {
        floatingView.alpha = 1
    }
    
    func floatingViewFinishedPartiallyHideAnimation(_ floatingView: (UIView & FloatingViewProtocol)) {
        floatingView.alpha = 0.5
    }
}
