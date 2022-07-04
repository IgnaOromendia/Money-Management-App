//
//  Array-Extension.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

extension Array where Element == Int {
    func addAll() -> Int {
        var result = 0
        for item in self {
            result += item
        }
        return result
    }
}
