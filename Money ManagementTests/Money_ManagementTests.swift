//
//  Money_ManagementTests.swift
//  Money ManagementTests
//
//  Created by Igna on 04/07/2022.
//

import XCTest
@testable import Money_Management

class MoneyManagement_Model_test: XCTestCase {
    let date = Date().getKeyData()
    var expenses = ProductsData(products: [Product(name: "Coca", price: 100, category: "Bebida", movement: .Expense, quantity: 1),
                                           Product(name: "Hielo", price: 50, category: "Otros", movement: .Expense, quantity: 1)], sum: 150, date: Date().getKeyData())
    var earnings = ProductsData(products: [Product(name: "Robo", price: 500, category: "Otros", movement: .Expense, quantity: 1)], sum: 500, date: Date().getKeyData())
    
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
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        let products = ProductsData(products: [prod1], sum: -250, date: date)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Expense) == products.sum)
    }
    
    func test_AddExpensesToAMMWithOthersExpenses() throws {
        let mmTest =  MoneyManagement(expenses: [date:expenses], earnings: [date:earnings], debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        
        expenses.products.insert(prod1)
        expenses.sum -= 250
        
        try mmTest.addExpenses(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == expenses)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: Movement.Expense) == expenses.sum)
    }
    
    func test_AddExpensesToAMMTwice() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 2)
        let products = ProductsData(products: [prod2], sum: -500, date: date)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        
        let productsOnMM = mmTest.dateExpenses(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.first?.quantity ?? 0 == 2)
        }
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: Movement.Expense) == products.sum)
    }
    
    func test_AddExpensesToAMMMultiplesTimes() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 5)
        let prod3 = Product(name: "Papas", price: 100, category: "Comida", movement: .Expense, quantity: 5)
        let products = ProductsData(products: [prod2,prod3], sum: -250*5 - 100, date: date)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod3, on: Date())
        
        let productsOnMM = mmTest.dateExpenses(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.find(prod1)?.quantity ?? 0 == 5)
        }
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Expense) == products.sum)
    }
    
    func test_AddExpensesToAMMMultiplesTimes_2() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        let prod1_3 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 3)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 4)
        let products = ProductsData(products: [prod2], sum: -(250*4), date: date)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1_3, on: Date())
        
        let productsOnMM = mmTest.dateExpenses(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.find(prod1)?.quantity ?? 0 == 4)
        }
        
        XCTAssert(mmTest.dateExpenses(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Expense) == products.sum)
    }
    
    func test_AddEarningsToANewEmptyMM() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        let products = ProductsData(products: [prod1], sum: 250, date: date)
        
        try mmTest.addEarnings(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Earning) == 250)
    }
    
    func test_AddEarningsToAMMWithOthersExpenses() throws {
        let mmTest =  MoneyManagement(expenses: [date:expenses], earnings: [date:expenses], debts: debtsT, debtors: debtorsT, categories: ["Comida"])
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        
        expenses.products.insert(prod1)
        expenses.sum += 250
        
        try mmTest.addEarnings(product: prod1, on: Date())
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == expenses)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Earning) == expenses.sum)
    }
    
    func test_AddEarningsToAMMTwice() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 2)
        let products = ProductsData(products: [prod2], sum: 500, date: date)
        
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        
        let productsOnMM = mmTest.dateEarnings(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.first?.quantity ?? 0 == 2)
        }
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Earning) == products.sum)
    }
    
    func test_AddEarningsToAMMMultiplesTimes() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 5)
        let prod3 = Product(name: "Papas", price: 100, category: "Comida", movement: .Expense, quantity: 5)
        let products = ProductsData(products: [prod2,prod3], sum: 250*5 + 100, date: date)
        
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod3, on: Date())
        
        let productsOnMM = mmTest.dateEarnings(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.find(prod1)?.quantity ?? 0 == 5)
        }
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Earning) == products.sum)
    }
    
    func test_AddEarningsToAMMMultiplesTimes_2() throws {
        let mmTest =  MoneyManagement()
        let prod1 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 1)
        let prod1_3 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 3)
        let prod2 = Product(name: "Milanesa", price: 250, category: "Comida", movement: .Expense, quantity: 4)
        let products = ProductsData(products: [prod2], sum: 250*4, date: date)
        
        try mmTest.addEarnings(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1_3, on: Date())
        
        let productsOnMM = mmTest.dateEarnings(on: Date())
        
        if let productsOnMM = productsOnMM {
            XCTAssert(productsOnMM.products.find(prod1)?.quantity ?? 0 == 4)
        }
        
        XCTAssert(mmTest.dateEarnings(on: Date()) == products)
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Earning) == products.sum)
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
    
    func test_monthlyMovement() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", movement: .Expense, quantity: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Expense) == -1)
    }
    
    func test_monthlyMovement2() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", movement: .Expense, quantity: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        XCTAssert(mmTest.monthlyMovement(Date().getKeyData().month!, for: .Expense) == -4)
    }
    
    func test_weeklyMovement() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", movement: .Expense, quantity: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        XCTAssert(mmTest.weeklyMovement(Date().getKeyData().weekOfMonth!, for: .Expense) == -1)
    }
    
    func test_weeklyMovement2() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", movement: .Expense, quantity: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addExpenses(product: prod1, on: Date())
        XCTAssert(mmTest.weeklyMovement(Date().getKeyData().weekOfMonth!, for: .Expense) == -4)
    }
    
    func test_balanceSameDay() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", movement: .Expense, quantity: 1)
        try mmTest.addExpenses(product: prod1, on: Date())
        try mmTest.addEarnings(product: prod1, on: Date())
        XCTAssert(mmTest.balance(from: Date().getKeyData(), to: Date().getKeyData()) == 0)
    }
    
    func test_balanceDifferentDays() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 1, category: "C1", movement: .Expense, quantity: 1)
        try mmTest.addExpenses(product: prod1, on: Date().yesterday)
        try mmTest.addEarnings(product: prod1, on: Date())
        let balance1 = mmTest.balance(from: Date().yesterday.getKeyData(), to: Date().getKeyData())
        XCTAssert(balance1 == 0)
    }
    
    func test_balanceAfterAdding() throws {
        let mmTest = MoneyManagement()
        let prod1 = Product(name: "A", price: 2, category: "C1", movement: .Expense, quantity: 1)
        let prod2 = Product(name: "A", price: 2, category: "C1", movement: .Expense, quantity: 2)
        
        try mmTest.addExpenses(product: prod1, on: Date())
        let balance1 = mmTest.balance(from: Date.now.getKeyData(), to: Date.now.getKeyData()) // -2
        
        try mmTest.addExpenses(product: prod2, on: Date())
        let balance2 = mmTest.balance(from: Date.now.getKeyData(), to: Date.now.getKeyData()) // -6
        
        XCTAssert(balance1 == -2)
        XCTAssert(balance2 == -6)
    }

}
