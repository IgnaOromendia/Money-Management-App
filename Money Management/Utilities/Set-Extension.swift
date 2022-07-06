//
//  Set-Extension.swift
//  Money Management
//
//  Created by Igna on 05/07/2022.
//

import Foundation

extension Set where Element: Equatable {
    /// Finds and returns an sepcifc element in the set
    func find<T>(_ elem: T) -> T? {
        var it = self.makeIterator()
        var p = it.next()
        while p != nil {
            if p == elem as? Element {
                return p as? T
            } else {
                p = it.next()
            }
        }
        return nil
    }
    
    /// Replace an element by other in the set
    mutating func replace<T>(old p1: T, new p2: T) throws {
        if let old = find(p1) {
            self.remove(old as! Element)
            self.insert(p2 as! Element)
        } else {
            throw SetError.ElementDoesntExists
        }
    }
}

fileprivate enum SetError: LocalizedError {
    case ElementDoesntExists
}
