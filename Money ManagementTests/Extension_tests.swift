//
//  Extension_tests.swift
//  Money ManagementTests
//
//  Created by Igna on 09/07/2022.
//

import XCTest

class Extension_tests: XCTestCase {
    let prod1 = Product(name: "A", price: 1, category: "C1", movement: .Expense, quantity: 1)
    let prod2 = Product(name: "B", price: 2, category: "C2", movement: .Expense, quantity: 1)
    let prod3 = Product(name: "C", price: 3, category: "C3", movement: .Expense, quantity: 1)
    
    let prod1M = Product(name: "A", price: 1, category: "C1", movement: .Expense, quantity: 1)
    
    var set1: Set<Product> = []
    
    // SET TESTS
    
    func test_find() {
        set1 = [prod1,prod2,prod3]
        let p = set1.find(prod1)
        XCTAssert(p == prod1)
    }
    
    func test_findElementNotExisting() {
        set1 = [prod2,prod3]
        let p = set1.find(prod1)
        XCTAssert(p == nil)
    }
    
    func test_replaceElement() throws {
        set1 = [prod1,prod2,prod3]
        try set1.replace(old: prod1, new: prod1M)
        XCTAssert(set1.find(prod1M) == prod1M)
    }
    
    func test_replaceNonExistingElement() throws {
        set1 = [prod2,prod3]
        XCTAssertThrowsError(try set1.replace(old: prod1, new: prod1M))
        XCTAssert(set1.find(prod1M) == nil)
    }
    
    func test_setToArrayInt() {
        let setT: Set<Int> = [1,2,3,4,5]
        let arrT: Array<Int> = [1,2,3,4,5]
        for item in setT.setToArray() {
            XCTAssert(arrT.contains(item))
        }
    }
    
}
