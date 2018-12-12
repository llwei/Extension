//
//  UIButton+Extension.swift
//  Extensions
//
//  Created by Ryan on 2018/12/4.
//  Copyright © 2018 Ryan. All rights reserved.
//

import UIKit


extension UIButton {
    
    private struct AssociatedKeys {
        static var normalBgColorKey = "UIButton.normalBgColorKey"
        static var highlightBgColorKey = "UIButton.highlightBgColorKey"
        static var selectedBgColorKey = "UIButton.selectedBgColorKey"
        
        static var structModeKey = "UIButton.structModeKey"
    }
    
    /// normal状态背景图片
    @IBInspectable var normalBgColor: UIColor? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.normalBgColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.normalBgColorKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            var image: UIImage?
            if let color = newValue {
                image = UIImage.createImage(color)
                backgroundColor = nil
            }
            setBackgroundImage(image, for: .normal)
        }
    }
    
    /// highlight状态背景图片
    @IBInspectable var highlightBgColor: UIColor? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.highlightBgColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.highlightBgColorKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            var image: UIImage?
            if let color = newValue {
                image = UIImage.createImage(color)
                backgroundColor = nil
            }
            setBackgroundImage(image, for: .highlighted)
        }
    }
    
    /// selected状态背景图片
    @IBInspectable var selectedBgColor: UIColor? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.selectedBgColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.selectedBgColorKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            var image: UIImage?
            if let color = newValue {
                image = UIImage.createImage(color)
                backgroundColor = nil
            }
            setBackgroundImage(image, for: .selected)
        }
    }
    
}

extension UIButton {
    
    enum StructMode {
        case leftTextRightImage(interval: CGFloat)
        case leftImageRightText(interval: CGFloat)
        case topTextBottomImage(interval: CGFloat)
        case topImageBottomText(interval: CGFloat)
        
        var interval: CGFloat {
            switch self {
            case let .leftTextRightImage(interval),
                 let .leftImageRightText(interval),
                 let .topTextBottomImage(interval),
                 let .topImageBottomText(interval):
                return interval
            }
        }
    }
    
    /// 图文结构
    var structMode: StructMode? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.structModeKey) as? StructMode
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.structModeKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
           
            guard let mode = newValue else { return }
            switch mode {
            case .leftTextRightImage:
                titleEdgeInsets = UIEdgeInsets(top: 0,
                                               left: -((imageView?.frame.width ?? 0) + mode.interval / 2.0),
                                               bottom: 0,
                                               right: (imageView?.frame.width ?? 0) + mode.interval / 2.0)
                
                imageEdgeInsets = UIEdgeInsets(top: 0,
                                               left: (titleLabel?.frame.width ?? 0) + mode.interval / 2.0,
                                               bottom: 0,
                                               right: -((titleLabel?.frame.width ?? 0) + mode.interval / 2.0))
                
            case .leftImageRightText:
                titleEdgeInsets = UIEdgeInsets(top: 0,
                                               left: mode.interval,
                                               bottom: 0,
                                               right: 0)
                imageEdgeInsets = UIEdgeInsets(top: 0,
                                               left: -mode.interval,
                                               bottom: 0,
                                               right: 0)
                
            case .topTextBottomImage:
                titleEdgeInsets = UIEdgeInsets(top: -((imageView?.frame.height ?? 0) + mode.interval) / 2.0,
                                               left: -(imageView?.frame.width ?? 0) / 2.0,
                                               bottom: ((imageView?.frame.height ?? 0) + mode.interval) / 2.0,
                                               right: (imageView?.frame.width ?? 0) / 2.0)
                imageEdgeInsets = UIEdgeInsets(top: ((titleLabel?.frame.height ?? 0) + mode.interval) / 2.0,
                                               left: (titleLabel?.frame.width ?? 0) / 2.0,
                                               bottom: -((titleLabel?.frame.height ?? 0) + mode.interval) / 2.0,
                                               right: -(titleLabel?.frame.width ?? 0) / 2.0)
                
            case .topImageBottomText:
                titleEdgeInsets = UIEdgeInsets(top: ((imageView?.frame.height ?? 0) + mode.interval) / 2.0,
                                               left: -(imageView?.frame.width ?? 0) / 2.0,
                                               bottom: -((imageView?.frame.height ?? 0) + mode.interval) / 2.0,
                                               right: (imageView?.frame.width ?? 0) / 2.0)
                imageEdgeInsets = UIEdgeInsets(top: -((titleLabel?.frame.height ?? 0) + mode.interval) / 2.0,
                                               left: (titleLabel?.frame.width ?? 0) / 2.0,
                                               bottom: ((titleLabel?.frame.height ?? 0) + mode.interval) / 2.0,
                                               right: -(titleLabel?.frame.width ?? 0) / 2.0)
            }
        }
    }
    
    
}

