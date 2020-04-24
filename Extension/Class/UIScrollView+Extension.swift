//
//  UIScrollView+Extension.swift
//  Extension
//
//  Created by Ryan on 2019/9/26.
//  Copyright © 2019 Ryan. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    public func takeScreenshotOfCurrentContent(_ completion: @escaping ((UIImage?) -> Void)) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            completion(nil)
            return
        }
        let backgroundColor = self.backgroundColor ?? UIColor.white
        context.setFillColor(backgroundColor.cgColor)
        context.setStrokeColor(backgroundColor.cgColor)

        let pageFrame = CGRect(x: 0, y: contentOffset.y, width: self.bounds.size.width, height: self.bounds.size.height)
        self.drawHierarchy(in: pageFrame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        completion(image)
    }
    
    public func takeScreenshotOfFullContent(_ completion: @escaping ((UIImage?) -> Void)) {
        // 分页绘制内容到ImageContext
        let originalOffset = self.contentOffset

        // 当contentSize.height
        var pageNum = 1
        if self.contentSize.height > self.bounds.height {
            pageNum = Int(floorf(Float(self.contentSize.height / self.bounds.height)))
        }

        let backgroundColor = self.backgroundColor ?? UIColor.white

        UIGraphicsBeginImageContextWithOptions(self.contentSize, true, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            completion(nil)
            return
        }
        context.setFillColor(backgroundColor.cgColor)
        context.setStrokeColor(backgroundColor.cgColor)

        self.drawScreenshotOfPageContent(0, maxIndex: pageNum) {
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.contentOffset = originalOffset
            completion(image)
        }
    }

    fileprivate func drawScreenshotOfPageContent(_ index: Int, maxIndex: Int, completion: @escaping () -> Void) {

        self.setContentOffset(CGPoint(x: 0, y: CGFloat(index) * self.frame.size.height), animated: false)
        let pageFrame = CGRect(x: 0, y: CGFloat(index) * self.frame.size.height, width: self.bounds.size.width, height: self.bounds.size.height)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.drawHierarchy(in: pageFrame, afterScreenUpdates: true)

            if index < maxIndex {
                self.drawScreenshotOfPageContent(index + 1, maxIndex: maxIndex, completion: completion)
            }else{
                completion()
            }
        }
    }
}
