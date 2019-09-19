//
//  UIWebView+Extension.swift
//  LaiAi
//
//  Created by Ryan on 2019/8/20.
//  Copyright © 2019 Laiai. All rights reserved.
//

import UIKit

private var ImgUrlsKey: Void?

private let jsGetImages =  """
function getImages(){
    var objs = document.getElementsByTagName('img');
    var imgScr = '';
    for(var i=0;i<objs.length;i++){
    imgScr = imgScr + objs[i].src + '+';
    };
    return imgScr;
};
"""
private let jsClickImage = """
function registerImageClickAction(){
    var imgs=document.getElementsByTagName('img');
    var length=imgs.length;
    for(var i=0;i<length;i++){
        img=imgs[i];
        img.onclick=function(){
            window.location.href='image-preview:'+this.src
        }
    }
}
"""


extension UIWebView {
    private var imgUrls: [String] {
        get {
            return objc_getAssociatedObject(self, &ImgUrlsKey) as? [String] ?? []
        }
        set {
            objc_setAssociatedObject(self, &ImgUrlsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func getImagUrlsByJs() {
        // 注入获取图片
        stringByEvaluatingJavaScript(from: jsGetImages)
        if var urlResult = stringByEvaluatingJavaScript(from: "getImages()")?.components(separatedBy: "+") {
            if urlResult.count >= 2 {
                urlResult.removeLast()
            }
            self.imgUrls = urlResult
        }
        
        // 注入点击事件
        stringByEvaluatingJavaScript(from: jsClickImage)
        stringByEvaluatingJavaScript(from: "registerImageClickAction()")
    }
    
    func getImage(byRequest request: URLRequest, completion: (_ imgUrls: [String], _ imageIndex: Int) -> Void) {
        guard let requestString = request.url?.absoluteString else { return }
        let scheme = "image-preview:"
        if requestString.hasPrefix(scheme) {
            let imgUrl = (requestString as NSString).substring(from: scheme.count)
            guard let index = imgUrls.firstIndex(of: imgUrl) else { return }
            completion(imgUrls, index)
        }
    }
}
