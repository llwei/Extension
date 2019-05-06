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
        guard let title = currentTitle, let titleLabel = self.titleLabel else { return }
        let titleSize = title.size(withAttributes: [NSAttributedStringKey.font: titleLabel.font])
        
        switch StructMode(rawValue: structMode) ?? .leftImageRightText {
        case .leftImageRightText:
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: structInterval,
                                           bottom: 0,
                                           right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -structInterval,
                                           bottom: 0,
                                           right: 0)
            
        case .leftTextRightImage:
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -((imageView?.frame.width ?? 0) + structInterval / 2.0),
                                           bottom: 0,
                                           right: (imageView?.frame.width ?? 0) + structInterval / 2.0)
            
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: titleSize.width + structInterval / 2.0,
                                           bottom: 0,
                                           right: -(titleSize.width + structInterval / 2.0))
            
            
            
        case .topTextBottomImage:
            titleEdgeInsets = UIEdgeInsets(top: -((imageView?.frame.height ?? 0) + structInterval) / 2.0,
                                           left: -(imageView?.frame.width ?? 0),
                                           bottom: ((imageView?.frame.height ?? 0) + structInterval) / 2.0,
                                           right: 0)
            imageEdgeInsets = UIEdgeInsets(top: (titleSize.height + structInterval) / 2.0,
                                           left: 0,
                                           bottom: -(titleSize.height + structInterval) / 2.0,
                                           right: -titleSize.width)
            
        case .topImageBottomText:
            titleEdgeInsets = UIEdgeInsets(top: ((imageView?.frame.height ?? 0) + structInterval) / 2.0,
                                           left: -(imageView?.frame.width ?? 0),
                                           bottom: -((imageView?.frame.height ?? 0) + structInterval) / 2.0,
                                           right: 0)
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + structInterval) / 2.0,
                                           left: 0,
                                           bottom: (titleSize.height + structInterval) / 2.0,
                                           right: -titleSize.width)
        }
    }
    
    
}

