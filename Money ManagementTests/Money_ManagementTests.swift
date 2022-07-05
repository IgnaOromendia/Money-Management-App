//
//  Money_ManagementTests.swift
//  Money ManagementTests
//
//  Created by Igna on 04/07/2022.
//

import XCTest
@testable import Money_Management

class MoneyManagement_test: XCTestCase {
    var expenses = ProductsData(products: [Product(name: "Coca", price: 100, category: "Bebida", amount: 1),
                                           Product(name: "Hielo", price: 50, category: "Otros", amount: 1)], sum: 150)
    var earnings = ProductsData(products: [Product(name: "Robo", price: 500, category: "Otros", amount: 1)], sum: 500)
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
    
    func testAddExpensesToANewEmptyMM() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        let products = ProductsData(products: [prod1], sum: 250)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == 250)
    }
    
    func testAddExpensesToAMMWithOthersExpenses() throws {
        let mmTest =  MoneyManagement(expenses: [date:expenses], earnings: [date:earnings], debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        
        expenses.products.insert(prod1)
        expenses.sum += 250
        
        try mmTest.addExpenses(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == expenses)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == expenses.sum)
    }
    
    func testAddExpensesToAMMTwice() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 2)
        let products = ProductsData(products: [prod2], sum: 500)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        
        let productsOnMM = mmTest.dateExpenses(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.first?.amount ?? 0 == 2)
        }
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == products.sum)
    }
    
    func testAddExpensesToAMMMultiplesTimes() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 5)
        let prod3 = Product(name: "Papas", price: 100, category: "Comida", amount: 5)
        let products = ProductsData(products: [prod2,prod3], sum: 250*5 + 100)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod3, on: Date())
        
        let productsOnMM = mmTest.dateExpenses(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.first?.amount ?? 0 == 5)
        }
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == products.sum)
    }
    
    func testAddEarningsToANewEmptyMM() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        let products = ProductsData(products: [prod1], sum: 250)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == 250)
    }
    
    func testAddEarningsToAMMWithOthersExpenses() throws {
        let mmTest =  MoneyManagement(expenses: [date:expenses], earnings: [date:expenses], debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        
        expenses.products.insert(prod1)
        expenses.sum += 250
        
        try mmTest.addEarnings(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == expenses)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Earning) == expenses.sum)
    }
    
    func testAddEarningsToAMMTwice() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 2)
        let products = ProductsData(products: [prod2], sum: 500)
        
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        
        let productsOnMM = mmTest.dateEarnings(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.first?.amount ?? 0 == 2)
        }
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Earning) == products.sum)
    }
    
    func testAddEarningsToAMMMultiplesTimes() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 5)
        let prod3 = Product(name: "Papas", price: 100, category: "Comida", amount: 5)
        let products = ProductsData(products: [prod2,prod3], sum: 250*5 + 100)
        
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod3, on: Date())
        
        let productsOnMM = mmTest.dateEarnings(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.first?.amount ?? 0 == 5)
        }
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Earning) == products.sum)
    }
    
    // OTHER TESTS

}
