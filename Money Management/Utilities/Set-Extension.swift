//
//  Set-Extension.swift
//  Money Management
//
//  Created by Igna on 05/07/2022.
//

import Foundation

extension Set where Element == Product {
    func find(_ elem: Product) -> Product? {
        var it = self.makeIterator()
        var p = it.next()
        while p != nil {
            if p == elem {
                return p
            } else {
                p = it.next()
            }
        }
        return nil
    }
    
    mutating func replace(old p1: Product, new p2: Product) throws {
        if let old = find(p1) {
            self.remove(old)
            self.insert(p2)
        } else {
            throw SetError.ElementDoesntExists
        }
    }
}

fileprivate enum SetError: LocalizedError {
    case ElementDoesntExists
}
