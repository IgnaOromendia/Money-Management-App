//
//  Validation_test.swift
//  Money ManagementTests
//
//  Created by Igna on 09/07/2022.
//

import XCTest

class Validation_test: XCTestCase {

    let word = "Test"
    let numbers = "12345"
    let mixed = "4a5dAsdf234"
    let validation = DataValidation()
    
    // Only number
    func test_numberValidation() throws {
        XCTAssertNoThrow(try validation.onlyNumbers(on: numbers))
    }
    
    func test_wordValidation() throws {
        XCTAssertThrowsError(try validation.onlyNumbers(on: word))
    }
    
    func test_mixValidation() throws {
        XCTAssertThrowsError(try validation.onlyNumbers(on: mixed))
    }
    
    // Future date
    func test_futureDateFuture() throws {
        let yesterday: Date = Date.now + TimeInterval(86400)
        XCTAssertThrowsError(try validation.futureDate(yesterday))
    }
    
    func test_futureDatePast() throws {
        let yesterday: Date = Date.now - TimeInterval(86400)
        XCTAssertNoThrow(try validation.futureDate(yesterday))
    }
    
    // Empty text
    func test_emptyText() throws {
        XCTAssertThrowsError(try validation.emptyText(""), "") { error in
            XCTAssert(error as! ValidationErrors == ValidationErrors.emptyText)
        }
    }
    
    func test_notEmptyText() throws {
        XCTAssertNoThrow(try validation.emptyText("a"))
    }
    
    func test_nilText() throws {
        XCTAssertThrowsError(try validation.emptyText(nil), "") { error in
            XCTAssert(error as! ValidationErrors == ValidationErrors.nilText)
        }
    }
    
    
}
