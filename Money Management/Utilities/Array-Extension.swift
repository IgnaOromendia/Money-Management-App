//
//  Array-Extension.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

extension Array where Element == Int {
    /// Add all the element of the array
    func addAll() -> Int {
        var result = 0
        for item in self {
            result += item
        }
        return result
    }
}

extension Array where Element:Equatable {
    /// Get the index of a given element
    func getIndex(of item: Element) -> Int?{
        for (i,elem) in self.enumerated() {
            if elem == item {
                return i
            }
        }
        return nil
    }
}
