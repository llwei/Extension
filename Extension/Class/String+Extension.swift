//
//  String+Extension.swift
//  Extension
//
//  Created by Ryan on 2018/12/11.
//  Copyright © 2018 Ryan. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    enum Format {
        /// 字母
        case letters(range: ClosedRange<Int>?)
        /// 数字
        case digits(range: ClosedRange<Int>?)
        /// 汉字
        case chinese(range: ClosedRange<Int>?)
        /// 字母|数字
        case lettersDigits(range: ClosedRange<Int>?)
        /// 字母|数字|汉字
        case lettersDigitsChinese(range: ClosedRange<Int>?)
        /// 标点符号
        case punctuations(range: ClosedRange<Int>?)
        /// 正负小数
        case decimal
        /// 邮箱
        case email
        /// 手机号
        case mobliephone
        /// 电话号码
        case telephone
        /// 身份证
        case identifierCard
        /// emoji表情
        case emoji
        /// 真实汉字姓名
        case realChineseName
        
        var regex: String {
            switch self {
            case let .letters(range):
                guard let first = range?.first, let last = range?.last else {
                    return "^[A-Za-z]+$"
                }
                return "^[A-Za-z]{\(first),\(last)}$"
                
            case let .digits(range):
                guard let first = range?.first, let last = range?.last else {
                    return "^[0-9]+$"
                }
                return "^[0-9]{\(first),\(last)}$"
                
            case let .chinese(range):
                guard let first = range?.first, let last = range?.last else {
                    return "^[\\u4e00-\\u9fa5]+$"
                }
                return "^[\\u4e00-\\u9fa5]{\(first),\(last)}$"
                
            case let .lettersDigits(range):
                guard let first = range?.first, let last = range?.last else {
                    return "^[A-Za-z0-9]+$"
                }
                return "^[A-Za-z0-9]{\(first),\(last)}$"
                
            case let .lettersDigitsChinese(range):
                guard let first = range?.first, let last = range?.last else {
                    return "^[\\u4e00-\\u9fa5A-Za-z0-9]+$"
                }
                return "^[\\u4e00-\\u9fa5A-Za-z0-9]{\(first),\(last)}$"
                
            case let .punctuations(range):
                guard let first = range?.first, let last = range?.last else {
                    return "[（）,，。？！，、；：“”‘’《》{}—.?!,;:\"\"()-......·.•。！!:：():：—\\-+]+$"
                }
                return "[（）,，。？！，、；：“”‘’《》{}—.?!,;:\"\"()-......·.•。！!:：():：—\\-+]{\(first),\(last)}$"
                
            case .decimal:
                return "^(\\-)?[0-9]+\\.[0-9]+$"
                
            case .email:
                return "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
                
            case .mobliephone:
                return "^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$"
                
            case .telephone:
                return "^([0-9]{3,4}-)?[0-9]{7,8}$"
                
            case .identifierCard:
                return "(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)"
                
            case .emoji:
                return "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]+$"
                
            case .realChineseName:
                return "(^[\\u4e00-\\u9fa5][\\u4e00-\\u9fa5 · •]*[\\u4e00-\\u9fa5]$)|^[\\u4e00-\\u9fa5]$"
            }
        }
    }
    
    /// 是否为指定类型字符串
    func equal(to format: Format) -> Bool {
        guard lengthOfBytes(using: String.Encoding.utf8) > 0 else {
            return false
        }
        return NSPredicate(format: "SELF MATCHES %@", format.regex).evaluate(with: self)
    }
    
    /// 是否包含指定类型字符串
    func contain(with format: Format) -> Bool {
        guard lengthOfBytes(using: String.Encoding.utf8) > 0 else {
            return false
        }
        let startIndex:String.Index = self.startIndex
        let endIndex:String.Index = self.endIndex
        let strRange = Range<String.Index>(uncheckedBounds: (startIndex,endIndex))
        let range = self.range(of: format.regex,
                               options: .regularExpression,
                               range: strRange,
                               locale: nil)
        return range != nil
    }
    
}

extension String {
    
    private static let dateFormat = DateFormatter()
    
    /// 字符串转日期
    func toDate(_ format: String) -> Date? {
        String.dateFormat.dateFormat = format
        return String.dateFormat.date(from: self)
    }
}

extension String {
    
    /// 根据下标获取字符
    subscript(i: Int) -> String? {
        guard i >= 0 && i < count else {
            return nil
        }
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    /// 字符串内去半封闭范围字符
    subscript(range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else {
            return nil
        }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
    
    //// 字符串内去全封闭范围字符
    subscript(range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else {
            return nil
        }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
    
    /// 某字符在字符串中的第一个下标索引
    func firstIndex(of string: String) -> Int? {
        return map({ String($0) }).firstIndex(of: string)
    }
    
    /// 根据换行符\n把字符串分段为数组元素
    var lines: [String] {
        var result:[String] = []
        enumerateLines { (line, stop) -> () in
            result.append(line)
        }
        return result
    }
    
    /// 过滤空格和换行符
    var filterSpacesAndNewLines: String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
    /// 过滤字符串中开头和结尾的空格与换行符
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// 某字符出现的个数
    func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string).count - 1
        }
        return components(separatedBy: string).count - 1
    }
    
    /// 获取字符串中出现最多的字符
    var mostCommonCharacter: String {
        var mostCommon = ""
        let charSet = Set(filterSpacesAndNewLines.map({String($0)}))
        var count = 0
        for string in charSet {
            if self.count(of: string) > count {
                count = self.count(of: string)
                mostCommon = string
            }
        }
        return mostCommon
    }
    
    //// 返回一定长度的随机字符串(大小写字母与数字组合)
    static func random(of length: Int) -> String {
        var string = ""
        guard length > 0 else {
            return string
        }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        for _ in 0..<length {
            let randomIndex = arc4random_uniform(UInt32(base.count))
            string += "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
        }
        return string
    }
    
    /// 截取前index
    func substring(to index: Int) -> String {
        if self.count > index {
            let theIndex = self.index(self.startIndex, offsetBy:index)
            return String(self[..<theIndex])//"\(self.substring(to: theIndex))..."
        }
        return self
    }
    
    /// 从index后截取
    func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            
            return String(subString)
        } else {
            return self
        }
    }
    
}


extension String {
    
    public var int: Int? {
        return Int(self)
    }
    
    public var int8: Int8? {
        return Int8(self)
    }
    
    public var int16: Int16? {
        return Int16(self)
    }
    
    public var int32: Int32? {
        return Int32(self)
    }
    
    public var int64: Int64? {
        return Int64(self)
    }
    
    public var float: Float? {
        return NumberFormatter().number(from: self) as? Float
    }
    
    public var float32: Float32? {
        return NumberFormatter().number(from: self) as? Float32
    }
    
    public var float64: Float64? {
        return NumberFormatter().number(from: self) as? Float64
    }
    
    public var double: Double? {
        return NumberFormatter().number(from: self) as? Double
    }
}


extension String {
    
    /// string转data, 如 “000e0b046f75” 转为 <000e0b046f75>
    var hexBytes: Data? {
        let length = lengthOfBytes(using: String.Encoding.utf8)
        guard length > 0 && length % 2 == 0 else { return nil }
        
        let ld = "[0-9a-fA-F]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", ld)
        
        if predicate.evaluate(with: self) {
            let data = NSMutableData()
            for idx in sequence(first: 0, next: { return $0 + 2 <= length - 2 ? $0 + 2 : nil }) {
                guard let hexStr = self[idx..<idx+2] else { break }
                var intvalue: UInt32 = 0
                let scanner = Scanner(string: hexStr)
                scanner.scanHexInt32(&intvalue)
                data.append(&intvalue, length: 1)
            }
            return data as Data
        }
        return nil
    }
    
    
    var base64Encoded: String? {
        let plainData = self.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    var base64Decoded: String? {
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    var md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        let lowStr = String(format: hash as String)
        return lowStr.uppercased()
     }
    
}
