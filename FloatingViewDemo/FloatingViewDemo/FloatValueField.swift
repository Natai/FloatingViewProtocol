//
//  FloatValueField.swift
//  FloatingViewDemo
//
//  Created by natai on 2018/7/19.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

class FloatValueField: UITextField {
    var floatValue: CGFloat {
        guard let number = NumberFormatter().number(from: text ?? "") else { return 0.0 }
        return CGFloat(truncating: number)
    }
}
