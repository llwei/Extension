//
//  UITextField+Extension.swift
//  RxDemo
//
//  Created by Ryan on 2018/10/30.
//  Copyright © 2018 Ryan. All rights reserved.
//

import UIKit

extension UITextField {
    
    private struct AssociatedKeys {
        static var maxLengthKey = "UITextField.maxLengthKey"
    }
    
    /// 更改placeHolder颜色
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                       attributes:
                [
                    NSAttributedString.Key.foregroundColor : newValue ?? UIColor.white
                ]
            )
        }
    }
    
    /// 限制最大长度
    @IBInspectable var textMaxLength: Int {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.maxLengthKey) as? Int ?? Int.max
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.maxLengthKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_ASSIGN)
            if newValue > 0 {
                addTarget(self,
                          action: #selector(UITextField.textFieldDidChanged(tf:)),
                          for: .editingChanged)
            }
        }
    }
    
    
    @objc func textFieldDidChanged(tf: UITextField) {
        guard tf.textMaxLength > 0, let toBeString = text else {
            return
        }
        
        if let selectedRange = tf.markedTextRange,
            let _ = tf.position(from: selectedRange.start, offset: 0) {
            return
        }
        tf.text = String(toBeString.prefix(textMaxLength))
//        let string = NSString(string: toBeString)
//        if string.length > tf.textMaxLength {
//            let range = string.rangeOfComposedCharacterSequence(at: tf.textMaxLength)
//            if range.length == 1 {
//                tf.text = string.substring(to: tf.textMaxLength)
//            } else {
//                let targetRange = string.rangeOfComposedCharacterSequences(for: NSRange(location: 0, length: tf.textMaxLength))
//                tf.text = string.substring(with: targetRange)
//            }
//        }
        
    }
    
}
