//
//  Money_ManagementTests.swift
//  Money ManagementTests
//
//  Created by Igna on 04/07/2022.
//

import XCTest
@testable import Money_Management

class MoneyManagement_test: XCTestCase {
    var expenses = ProductsData(products: [Product(name: "Coca", price: 100),
                                           Product(name: "Hielo", price: 50)], sum: 50)
    var earnings = ProductsData(products: [Product(name: "Robo", price: 500)], sum: 500)
    let date = Date().getKeyData()
    var arr1 = [0,0,0,0,0,0,150,0,0,0,0,0]
    var arr2 = [0,0,0,0,0,0,500,0,0,0,0,0]
    var debtsT = ["Juan":10000]
    var debtorsT = ["Pepe":100]
    
    
    // INIT & GET TEST
    func testDesignatedInit() throws {
        let mmTest = MoneyManagement(expenses: [date:expenses], earnings: [date:earnings], monthlyExpenses: arr1, monthlyEarnings: arr2, debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == expenses)
        XCTAssert(mmTest.dateEarnings(on: Date()) == earnings)
        XCTAssert(mmTest.getDebts() == debtsT)
        XCTAssert(mmTest.getDebtors() == debtorsT)
        XCTAssert(mmTest.getCategories() == ["Comida"])
        
    }
    
    func testConvenienceInit_1() throws {
        let mmTest = MoneyManagement(expenses: [date:expenses], earnings: [date:earnings], debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == expenses)
        XCTAssert(mmTest.dateEarnings(on: Date()) == earnings)
        XCTAssert(mmTest.getDebts() == debtsT)
        XCTAssert(mmTest.getDebtors() == debtorsT)
        XCTAssert(mmTest.getCategories() == ["Comida"])
        
    }
    
    func testConvenienceInit_2() throws {
        let mmTest = MoneyManagement()
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == nil)
        XCTAssert(mmTest.dateEarnings(on: Date()) == nil)
        XCTAssert(mmTest.getDebts().isEmpty)
        XCTAssert(mmTest.getDebtors().isEmpty)
        XCTAssert(mmTest.getCategories().isEmpty)
        
    }
    
    // SET TEST
    
    // OTHER TESTS

}
