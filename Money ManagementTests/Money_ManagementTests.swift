//
//  Money_ManagementTests.swift
//  Money ManagementTests
//
//  Created by Igna on 04/07/2022.
//

import XCTest
@testable import Money_Management

class MoneyManagement_Model_test: XCTestCase {
    var expenses = ProductsData(products: [Product(name: "Coca", price: 100, category: "Bebida", amount: 1),
                                           Product(name: "Hielo", price: 50, category: "Otros", amount: 1)], sum: 150)
    var earnings = ProductsData(products: [Product(name: "Robo", price: 500, category: "Otros", amount: 1)], sum: 500)
    let date = Date().getKeyData()
    var arr1 = [0,0,0,0,0,0,150,0,0,0,0,0]
    var arr2 = [0,0,0,0,0,0,500,0,0,0,0,0]
    var debtsT = ["Juan":10000]
    var debtorsT = ["Pepe":100]
    
    
    // INIT & GET TEST
    func test_DesignatedInit() {
        let mmTest = MoneyManagement(expenses: [date:expenses], earnings: [date:earnings], monthlyExpenses: arr1, monthlyEarnings: arr2, debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == expenses)
        XCTAssert(mmTest.dateEarnings(on: Date()) == earnings)
        XCTAssert(mmTest.getDebts() == debtsT)
        XCTAssert(mmTest.getDebtors() == debtorsT)
        XCTAssert(mmTest.getCategories() == ["Comida"])
        
    }
    
    func test_ConvenienceInit_1() {
        let mmTest = MoneyManagement(expenses: [date:expenses], earnings: [date:earnings], debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == expenses)
        XCTAssert(mmTest.dateEarnings(on: Date()) == earnings)
        XCTAssert(mmTest.getDebts() == debtsT)
        XCTAssert(mmTest.getDebtors() == debtorsT)
        XCTAssert(mmTest.getCategories() == ["Comida"])
        
    }
    
    func test_ConvenienceInit_2() {
        let mmTest = MoneyManagement()
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == nil)
        XCTAssert(mmTest.dateEarnings(on: Date()) == nil)
        XCTAssert(mmTest.getDebts().isEmpty)
        XCTAssert(mmTest.getDebtors().isEmpty)
        XCTAssert(mmTest.getCategories().isEmpty)
        
    }
    
    // SET TEST
    
    func test_AddExpensesToANewEmptyMM() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        let products = ProductsData(products: [prod1], sum: 250)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == 250)
    }
    
    func test_AddExpensesToAMMWithOthersExpenses() throws {
        let mmTest =  MoneyManagement(expenses: [date:expenses], earnings: [date:earnings], debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        
        expenses.products.insert(prod1)
        expenses.sum += 250
        
        try mmTest.addExpenses(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == expenses)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == expenses.sum)
    }
    
    func test_AddExpensesToAMMTwice() throws {
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
    
    func test_AddExpensesToAMMMultiplesTimes() throws {
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
            XCTAssert(productsOnMM.products.find(prod1)?.amount ?? 0 == 5)
        }
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == products.sum)
    }
    
    func test_AddEarningsToANewEmptyMM() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        let products = ProductsData(products: [prod1], sum: 250)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == 250)
    }
    
    func test_AddEarningsToAMMWithOthersExpenses() throws {
        let mmTest =  MoneyManagement(expenses: [date:expenses], earnings: [date:expenses], debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", amount: 1)
        
        expenses.products.insert(prod1)
        expenses.sum += 250
        
        try mmTest.addEarnings(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == expenses)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Earning) == expenses.sum)
    }
    
    func test_AddEarningsToAMMTwice() throws {
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
    
    func test_AddEarningsToAMMMultiplesTimes() throws {
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
            XCTAssert(productsOnMM.products.find(prod1)?.amount ?? 0 == 5)
        }
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Earning) == products.sum)
    }
    
    func test_addDebt() {
        let mmTest = MoneyManagement()
        mmTest.addDebt(name: "Pedro", amount: 100)
        XCTAssert(mmTest.getDebts() == ["Pedro":100])
    }
    
    func test_increaseDebt() {
        let mmTest = MoneyManagement()
        mmTest.addDebt(name: "Pedro", amount: 100)
        mmTest.addDebt(name: "Pedro", amount: 400)
        XCTAssert(mmTest.getDebts() == ["Pedro":500])
    }
    
    func test_addDebtor() {
        let mmTest = MoneyManagement()
        mmTest.addDebtor(name: "Pedro", amount: 100)
        XCTAssert(mmTest.getDebtors() == ["Pedro":100])
    }
    
    func test_increaseDebtor() {
        let mmTest = MoneyManagement()
        mmTest.addDebtor(name: "Pedro", amount: 100)
        mmTest.addDebtor(name: "Pedro", amount: 400)
        XCTAssert(mmTest.getDebtors() == ["Pedro":500])
    }
    
    func test_addCategory() {
        let mmTest = MoneyManagement()
        mmTest.addCategory("Comida")
        XCTAssert(mmTest.getCategories() == ["Comida"])
    }
    
    func test_addAnExistingCategory() {
        let mmTest = MoneyManagement()
        mmTest.addCategory("Comida")
        mmTest.addCategory("Comida")
        XCTAssert(mmTest.getCategories() == ["Comida"])
    }
    
    // OTHER TESTS
    
    func test_monthlyMovment() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", amount: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == 1)
    }
    
    func test_monthlyMovment2() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", amount: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        XCTAssert(mmTest.monthlyMovment(Date().getKeyData().month!, for: .Expense) == 4)
    }
    
    func test_weeklyMovment() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", amount: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        XCTAssert(mmTest.weeklyMovment(Date().getKeyData().weekOfMonth!, for: .Expense) == 1)
    }
    
    func test_weeklyMovment2() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", amount: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        XCTAssert(mmTest.weeklyMovment(Date().getKeyData().weekOfMonth!, for: .Expense) == 4)
    }
    
    func test_balanceSameDay() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", amount: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        XCTAssert(mmTest.balance(from: Date().getKeyData(), to: Date().getKeyData()) == 0)
    }
    
    func test_balanceDifferentDays() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", amount: 1)
        try mmTest.addExpenses(product: prod1, on: Date().yesterday)
        try mmTest.addEarnings(product: prod1, on: Date())
        let balance1 = mmTest.balance(from: Date().yesterday.getKeyData(), to: Date().getKeyData())
        XCTAssert(balance1 == 0)
    }

}

class Extensions_tests: XCTestCase {
    let prod1 = Product(name: "A", price: 1, category: "C1", amount: 1)
    let prod2 = Product(name: "B", price: 2, category: "C2", amount: 1)
    let prod3 = Product(name: "C", price: 3, category: "C3", amount: 1)
    
    let prod1M = Product(name: "A", price: 1, category: "C1", amount: 2)
    
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
