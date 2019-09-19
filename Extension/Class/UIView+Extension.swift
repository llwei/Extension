//
//  UIView+Extension.swift
//  Extensions
//
//  Created by Ryan on 2018/12/4.
//  Copyright © 2018 Ryan. All rights reserved.
//

import UIKit

extension UIView {
    
    private struct AssociatedKeys {
        static var gradientLayerKey = "UIView.GradientLayerKey"
    }
    
    /// 设置圆角
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    /// 设置边框宽度
    @IBInspectable var borderWidth: CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    /// 设置边框颜色
    @IBInspectable var borderColor: UIColor {
        set {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
    }
    
}

extension UIView {
    
    private var gradientLayer: CAGradientLayer? {
        get {
            return objc_getAssociatedObject(self,
                                            &AssociatedKeys.gradientLayerKey) as? CAGradientLayer
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.gradientLayerKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置渐变颜色背景图层
    func setGradientBackgroundColor(colors: [UIColor],
                                    starPoint: CGPoint = CGPoint(x: 0, y: 0.5),
                                    endPoint: CGPoint = CGPoint(x: 1 , y: 0.5),
                                    locations: [Float]? = nil) {
        guard let gradientLayer = self.gradientLayer else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = bounds
            gradientLayer.startPoint = starPoint
            gradientLayer.endPoint = endPoint
            gradientLayer.colors = colors.map({$0.cgColor})
            self.gradientLayer = gradientLayer
            layer.insertSublayer(gradientLayer, at: 0)
            return
        }
        gradientLayer.frame = bounds
        gradientLayer.startPoint = starPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors.map({$0.cgColor})
    }
    
    /// 指定位置切圆角
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        guard let cornerMask = self.layer.mask as? CAShapeLayer else {
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
            return
        }
        cornerMask.path = path.cgPath
    }
    
}

extension UIView {
    
    /// UIView转化为UIImage
    func toImage() -> UIImage? {
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}

extension UIView {
    
    func scaleShake() {
        layer.removeAnimation(forKey: "scaleShake")
        let anim = CAKeyframeAnimation(keyPath: "transform.scale")
        anim.values = [0.98, 1.1, 1.0, 0.98]
        anim.duration = 1.0
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
        layer.add(anim, forKey: "scaleShake")
    }
    
    func angleShake() {
        layer.removeAnimation(forKey: "angleShake")
        layer.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        let anim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        anim.values = [Double.pi / 15, 0.0, -Double.pi / 15, 0.0, Double.pi / 15]
        anim.duration = 1.2
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
        layer.add(anim, forKey: "angleShake")
    }
    
}

