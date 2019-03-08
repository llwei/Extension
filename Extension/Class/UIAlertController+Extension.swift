//
//  UIAlertController+Extension.swift
//  LaiAi
//
//  Created by Ryan on 2018/10/9.
//  Copyright © 2018年 Laiai. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    var titleAttributes: [NSAttributedString.Key : Any]? {
        get {
            return value(forKey: "attributedTitle") as? [NSAttributedString.Key : Any]
        }
        set {
            guard let value = newValue else { return }
            let attributes = NSAttributedString(string: title ?? "", attributes: value)
            setValue(attributes, forKey: "attributedTitle")
        }
    }
    
    var messageAttributes: [NSAttributedString.Key : Any]? {
        get {
            return value(forKey: "attributedMessage") as? [NSAttributedString.Key : Any]
        }
        set {
            guard let value = newValue else { return }
            let attributes = NSAttributedString(string: message ?? "", attributes: value)
            setValue(attributes, forKey: "attributedMessage")
        }
    }
    
    open override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("没找到" + key)
    }
    
    open override func value(forUndefinedKey key: String) -> Any? {
        print("没找到" + key)
        return nil
    }
}

extension UIAlertAction {
    
    var titleColor: UIColor? {
        get {
            return value(forKey: "titleTextColor") as? UIColor
        }
        set {
            setValue(newValue, forKey: "titleTextColor")
        }
    }
    
    open override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("没找到" + key)
    }
    
    open override func value(forUndefinedKey key: String) -> Any? {
        print("没找到" + key)
        return nil
    }
}
