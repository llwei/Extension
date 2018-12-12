//
//  Data+Extension.swift
//  Extension
//
//  Created by Ryan on 2018/12/11.
//  Copyright © 2018 Ryan. All rights reserved.
//

import Foundation

extension Data {
    
    /// 把16进制NSData转为字符串,如 <000e0b046f75> 转为 “000e0b046f75”
    var hexString: String {
        var hexStr: String = ""
        for i in 0..<count {
            var temp: UInt8 = 0x00
            
            let begin = index(startIndex, offsetBy: i)
            let end = index(startIndex, offsetBy: i + 1)
            copyBytes(to: &temp, from: begin..<end)
            
            var string = String(format: "%x", temp)
            if string.lengthOfBytes(using: String.Encoding.utf8) == 1 {
                string = "0" + string
            }
            hexStr = hexStr + string
        }
        return hexStr
    }
    
}
