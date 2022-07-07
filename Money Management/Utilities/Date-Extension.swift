//
//  Date-Extension.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

extension Date {
    /// Get the date components (day, month, year and weekOfMonth)
    func getKeyData() -> DateComponents {
        return Calendar.current.dateComponents([.day,.month,.year,.weekOfMonth], from: self)
    }
    
    /// Returns yesterday's date
    var yesterday: Date {
        return Date().advanced(by: -86400)
    }
    
    /// Get a string date 9/12/2018 with this fomrat
    var comparableDate: String {
        get {
            let date = Calendar.current.dateComponents([.day,.month,.year], from: self)
            return "\(date.day ?? -1)/\(date.month ?? -1)/\(date.year ?? -1)"
        }
    }
    
    /// Get string date 26/03
    var dayMonthDate: String {
        get {
            let date = Calendar.current.dateComponents([.day,.month], from: self)
            if let day = date.day, let month = date.month {
                let finalDay = day < 10 ? "0\(day)/" : "\(day)/"
                let finalMonth = month < 10 ? "0\(month)" : "\(month)"
                return finalDay + finalMonth
            }
            return "Error"
        }
    }
    
    /// Make today's date look like 'today', the same with yesterday's date
    var prettyDate: String {
        get {
            if self.comparableDate == Date().comparableDate {
                return "Today"
            } else if self.comparableDate == Date().yesterday.comparableDate {
                return "Yesterady"
            } else {
                return self.dayMonthDate
            }
        }
    }
}
