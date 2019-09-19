//
//  UIImage+Extension.swift
//  Extensions
//
//  Created by Ryan on 2018/12/4.
//  Copyright © 2018 Ryan. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 根据颜色绘制图片
    class func createImage(_ color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    
    /// 设置渐变颜色背景图层
    class func colors(colors: [UIColor],
                      size: CGSize,
                      starPoint: CGPoint = CGPoint(x: 0, y: 0.5),
                      endPoint: CGPoint = CGPoint(x: 1 , y: 0.5),
                      locations: [NSNumber]? = nil) -> UIImage? {
        
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: CGPoint.zero, size: size)
        gradientLayer.startPoint = starPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        gradientLayer.colors = colors.map({$0.cgColor})
        gradientLayer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 图片转字符串
    func toAttributeString() -> NSAttributedString {
        let textAttachment = NSTextAttachment()
        textAttachment.image = self
        textAttachment.bounds = CGRect(x: 0, y: -2, width: self.size.width, height: self.size.height)
        return NSAttributedString(attachment: textAttachment)
    }
    
}


extension UIImage {
    
    /// 将图片旋转一定弧度
    func rotation(by radians: CGFloat) -> UIImage? {
        
        // calculate the size of the rotated view's containing box for our drawing sapce
        let rotatedViewBox = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: size.width,
                                                  height: size.height))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: radians)
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so wo will rotate and scale around
        bitmap?.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        
        // Rotate the image context
        bitmap?.rotate(by: radians)
        
        // Draw the rotated image into the context
        bitmap?.scaleBy(x: 1.0, y: -1.0)
        bitmap?.draw(cgImage!,
                     in: CGRect(x: -size.width / 2,
                                y: -size.height / 2,
                                width: size.width,
                                height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// 水平翻转
    func horizontalFlip() -> UIImage? {
        guard let cgImage = cgImage, let colorSpace = cgImage.colorSpace else {
            return nil
        }
        
        guard let ctx = CGContext(data: nil,
                                  width: Int(size.width),
                                  height: Int(size.height),
                                  bitsPerComponent: cgImage.bitsPerComponent,
                                  bytesPerRow: 0,
                                  space: colorSpace,
                                  bitmapInfo: cgImage.bitmapInfo.rawValue) else {
                                    return self
        }
        
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: -1, y: 1)
        transform = transform.translatedBy(x: -size.width, y: 0)
        
        ctx.concatenate(transform)
        ctx.draw(cgImage,
                 in: CGRect(x: 0,
                            y: 0,
                            width: size.width,
                            height: size.height))
        
        if let cgImage = ctx.makeImage() {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    /// 垂直翻转
    func verticalFlip() -> UIImage? {
        guard let cgImage = cgImage, let colorSpace = cgImage.colorSpace else {
            return nil
        }
        
        guard let ctx = CGContext(data: nil,
                                  width: Int(size.width),
                                  height: Int(size.height),
                                  bitsPerComponent: cgImage.bitsPerComponent,
                                  bytesPerRow: 0,
                                  space: colorSpace,
                                  bitmapInfo: cgImage.bitmapInfo.rawValue) else {
                                    return self
        }
        
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -size.height)
        
        ctx.concatenate(transform)
        ctx.draw(cgImage,
                 in: CGRect(x: 0,
                            y: 0,
                            width: size.width,
                            height: size.height))
        
        if let cgImage = ctx.makeImage() {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    /// 将两张图片叠加生成一张图片
    class func merge(backgroundImage firstImage: UIImage,
                     frontImage secondImage: UIImage) -> UIImage? {
        guard let bgCgImage = firstImage.cgImage, let frontCgImage = secondImage.cgImage else { return nil }
        
        let mergedSize = CGSize(width: max(bgCgImage.width, frontCgImage.width),
                                height: max(bgCgImage.height, frontCgImage.height))
        UIGraphicsBeginImageContext(mergedSize)
        firstImage.draw(in: CGRect(x: 0,
                                   y: 0,
                                   width: bgCgImage.width,
                                   height: bgCgImage.height))
        secondImage.draw(in: CGRect(x: 0,
                                    y: 0,
                                    width: frontCgImage.width,
                                    height: frontCgImage.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}




extension UIImage {
    
    /// 截取当前图片rect区域内的图像
    func cropImage(with rect: CGRect) -> UIImage? {
        guard let newImageRef = cgImage?.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: newImageRef)
    }
    
    /// 获取图片某一像素的颜色
    func pixelColor(at point: CGPoint) -> UIColor? {
        guard CGRect(x: 0,
                     y: 0,
                     width: size.width,
                     height: size.height).contains(point) else {
                        return nil
        }
        
        var pixelData: [Int] = [0, 0, 0, 0]
        let bitsPerComponent: Int = 8
        let bytesPerRow: Int = 4
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        let context = CGContext(data: &pixelData,
                                width: 1,
                                height: 1,
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: bitmapInfo)
        context?.setBlendMode(CGBlendMode.copy)
        
        let pointX = trunc(point.x)
        let pointY = trunc(point.y)
        context?.translateBy(x: -pointX, y: pointY - size.height)
        context?.draw(cgImage!,
                      in: CGRect(x: 0,
                                 y: 0,
                                 width: size.width,
                                 height: size.height))
        
        let red = CGFloat(pixelData[0]) / 255.0
        let green = CGFloat(pixelData[1]) / 255.0
        let blue = CGFloat(pixelData[2]) / 255.0
        let alpha = CGFloat(pixelData[3]) / 255.0
        return UIColor(red: red,
                       green: green,
                       blue: blue,
                       alpha: alpha)
    }
    
    
    /// 压缩图片至指定尺寸
    func compressImage(to size: CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let compressImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return compressImage
    }
    
    /// 修复图片方向错误问题
    func fixOrientation() -> UIImage {
        
        guard let cgImage = cgImage, let colorSpace = cgImage.colorSpace else {
            return self
        }
        
        if imageOrientation == .up {
            return self
        }
        
        guard let ctx = CGContext(data: nil,
                                  width: Int(size.width),
                                  height: Int(size.height),
                                  bitsPerComponent: cgImage.bitsPerComponent,
                                  bytesPerRow: 0,
                                  space: colorSpace,
                                  bitmapInfo: cgImage.bitmapInfo.rawValue) else {
                                    return self
        }
        
        var transform = CGAffineTransform.identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .right,.rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -CGFloat(Double.pi / 2))
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage,
                     in: CGRect(x: 0,
                                y: 0,
                                width: size.height,
                                height: size.width))
        default:
            break
        }
        
        return UIImage(cgImage: ctx.makeImage()!)
    }
}
