//
//  Date+Extension.swift
//  Extension
//
//  Created by Ryan on 2018/12/12.
//  Copyright © 2018 Ryan. All rights reserved.
//

import Foundation

extension Date {
    
    private static let dateFormat = DateFormatter()
    
    /// 时间转字符串
    func toString(_ format: String) -> String {
        Date.dateFormat.dateFormat = format
        return Date.dateFormat.string(from: self)
    }
}

extension Date {
    
    init? (
        calendar: Calendar? = Calendar.current,
        timeZone: TimeZone? = TimeZone.current,
        era: Int? = Date().era,
        year: Int? = Date().year,
        month: Int? = Date().month,
        day: Int? = Date().day,
        hour: Int? = Date().hour,
        minute: Int? = Date().minute,
        second: Int? = Date().second,
        nanosecond: Int? = Date().nanosecond) {
        
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond
        
        if let date = calendar?.date(from: components) {
            self = date
        } else {
            return nil
        }
    }
    
    /// 日历
    var calendar: Calendar {
        return Calendar.current
    }
    
    /// 时区
    var timeZone: TimeZone {
        return calendar.timeZone
    }
    
    /// 纪元
    var era: Int {
        return calendar.component(.era, from: self)
    }
    
    /// 年
    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            self = Date(calendar: calendar,
                        timeZone: timeZone,
                        era: era,
                        year: newValue,
                        month: month,
                        day: day,
                        hour: hour,
                        minute: minute,
                        second: second,
                        nanosecond: nanosecond) ?? self
        }
    }
    
    /// 月
    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            self = Date(calendar: calendar,
                        timeZone: timeZone,
                        era: era,
                        year: year,
                        month: newValue,
                        day: day,
                        hour: hour,
                        minute: minute,
                        second: second,
                        nanosecond: nanosecond) ?? self
        }
    }
    
    /// 日
    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            self = Date(calendar: calendar,
                        timeZone: timeZone,
                        era: era,
                        year: year,
                        month: month,
                        day: newValue,
                        hour: hour,
                        minute: minute,
                        second: second,
                        nanosecond: nanosecond) ?? self
        }
    }
    
    /// 时
    var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            self = Date(calendar: calendar,
                        timeZone: timeZone,
                        era: era,
                        year: year,
                        month: month,
                        day: day,
                        hour: newValue,
                        minute: minute,
                        second: second,
                        nanosecond: nanosecond) ?? self
        }
    }
    
    /// 分
    var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            self = Date(calendar: calendar,
                        timeZone: timeZone,
                        era: era,
                        year: year,
                        month: month,
                        day: day,
                        hour: hour,
                        minute: newValue,
                        second: second,
                        nanosecond: nanosecond) ?? self
        }
    }
    
    /// 秒
    var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            self = Date(calendar: calendar,
                        timeZone: timeZone,
                        era: era,
                        year: year,
                        month: month,
                        day: day,
                        hour: hour,
                        minute: minute,
                        second: newValue,
                        nanosecond: nanosecond) ?? self
        }
    }
    
    /// 毫秒
    var nanosecond: Int? {
        return calendar.component(.nanosecond, from: self)
    }
    
    //// 当前为该年的第几个星期
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    
    /// 当前为该月的第几个星期
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }
    
    /// 当前为该周的第几天
    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }
    
    
}

extension Date {
    
    /// 是否在未来
    var isFuture: Bool {
        return self > Date()
    }
    
    /// 是否在过去
    var isPast: Bool {
        return self < Date()
    }
    
    /// 是否在今天
    var isToday: Bool {
        let date = Date()
        return self.day == date.day && self.month == date.month && self.year == date.year
    }
    
    /// 是否在昨天
    var isYesterday: Bool {
        return self.adding(.day, value: 1).isToday
    }
    
    /// 是否在明天
    var isTomorrow: Bool {
        return self.adding(.day, value: -1).isToday
    }
    
}

extension Date {
    
    mutating func add(_ componet: Calendar.Component, value: Int) {
        switch componet {
        case .second, .minute, .hour, .day, .month, .year:
            self = calendar.date(byAdding: componet, value: value, to: self) ?? self
            
        case .weekOfYear, .weekOfMonth:
            self = calendar.date(byAdding: .day, value: value * 7, to: self) ?? self
            
        default:
            break
        }
    }
    
    func adding(_ componet: Calendar.Component, value: Int) -> Date {
        switch componet {
        case .second, .minute, .hour, .day, .month, .year:
            return calendar.date(byAdding: componet, value: value, to: self) ?? self
            
        case .weekOfYear, .weekOfMonth:
            return calendar.date(byAdding: .day, value: value * 7, to: self) ?? self
            
        default:
            return self
        }
    }
    
}


