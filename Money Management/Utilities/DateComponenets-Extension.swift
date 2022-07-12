//
//  DateComponenets-Extension.swift
//  Money Management
//
//  Created by Igna on 09/07/2022.
//

import Foundation

// Just dia -> 2/3/2022 < 6/3/2022
// Different month -> 26/7/2022 < 5/12/2022
// Different year -> 2/6/2021 < 6/3/2022

extension DateComponents: Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        let justDay = lhs.day! < rhs.day! && lhs.month! == rhs.month! && lhs.year! == rhs.year!
        let difMonth = lhs.month! < rhs.month! && lhs.year! == rhs.year!
        let difYear = lhs.year! < rhs.year!
        return justDay || difMonth || difYear
    }
    
    var prettyDate: String {
        get {
            if self == Date.now.getKeyData()  {
                return "Today"
            } else if self == Date.now.yesterday.getKeyData() {
                return "Yesterady"
            } else {
                return "\(self.day ?? -1)/\(self.month ?? -1)/\(self.year ?? -1)"
            }
        }
    }
}
