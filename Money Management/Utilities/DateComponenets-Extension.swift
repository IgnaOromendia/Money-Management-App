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
}
