//
//  UIColor+Extension.swift
//  Extension
//
//  Created by Ryan on 2018/12/11.
//  Copyright © 2018 Ryan. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha)
    }
    
    /// hex颜色
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0xFF00) >> 8) / 255.0,
                  blue: CGFloat((hex & 0xFF)) / 255.0,
                  alpha: alpha)
    }
    
    /// 随机颜色
    static func random() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0,
                       green: CGFloat(arc4random_uniform(256)) / 255.0,
                       blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
    }
    
}
