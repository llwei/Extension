//
//  NSObject+Extension.swift
//  LaiAi
//
//  Created by Ryan on 2018/10/9.
//  Copyright © 2018年 Laiai. All rights reserved.
//

import Foundation

extension NSObject {
    
    var className: String {
        return type(of: self).className
    }
    
    static var className: String {
        return String(describing: self)
    }
    
    
    /// 读取对象属性
    func propertyNames() -> [String] {
        var proNames = [String]()
        
        var outCount: UInt32 = 0
        let propers = class_copyPropertyList(self.classForCoder, &outCount)
        for i in 0..<Int(outCount) {
            if let aPro = propers?[i] {
                if let proNameStr = String(utf8String: property_getName(aPro)) {
                    proNames.append(proNameStr)
                }
            }
        }
        
        return proNames
    }
    
    /// 读取对象方法
    func methodNames() -> [String] {
        var metNames = [String]()
        
        var outCount: UInt32 = 0
        let methods = class_copyMethodList(self.classForCoder, &outCount)
        for i in 0..<Int(outCount) {
            if let aMet = methods?[i] {
                if let metNameStr = String(utf8String: property_getName(aMet)) {
                    metNames.append(metNameStr)
                }
            }
        }
        
        return metNames
    }
    
}
