//
//  Date-Extension.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

extension Date {
    func getKeyData() -> DateComponents {
        return Calendar.current.dateComponents([.day,.month,.year,.weekOfMonth], from: self)
    }
    
    var yesterday: Date {
        return Date().advanced(by: -86000)
    }
}
