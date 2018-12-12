//
//  UIAlertController+Extension.swift
//  LaiAi
//
//  Created by Ryan on 2018/10/9.
//  Copyright © 2018年 Laiai. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    /// 设置文本对其方式
    func setMessageTextAlignment(textAlignment: NSTextAlignment) {
        
        func enumrateSubiewsInView(view: UIView) {
            let subViews = view.subviews
            if subViews.count == 0 {
                return
            }
            
            for i in 0..<subViews.count {
                let subView = subViews[i]
                enumrateSubiewsInView(view: subView)
                if subView is UILabel {
                    let label = subView as! UILabel
                    if label.text == message {
                        label.textAlignment = textAlignment
                    }
                }
            }
        }
        
        enumrateSubiewsInView(view: view)
    }
    
    
    
    
}
