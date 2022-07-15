//
//  Automation_tests.swift
//  Money ManagementTests
//
//  Created by Igna on 14/07/2022.
//

import XCTest

class Automation_tests: XCTestCase {

    var automationManager = AutomationManager()
    
    let product1 = Product(name: "A", price: 100, category: "C", movement: .Expense, quantity: 1)
    let productS = Product(name: "A", price: 100, category: "C", movement: .Expense, quantity: 7)
    
    func test_constructor() {
        let expectedA = [Automation(product: product1, repeats: .EveryDay)]
        let expectedR = [Repetitions.EveryDay:[0]]
        automationManager = AutomationManager(automations: expectedA)
        XCTAssert(expectedA == automationManager.getAutomations())
        XCTAssert(expectedR == automationManager.getRepetitions())
    }
    
    func test_addOneAutomation() {
        let a1 = Automation(product: product1, repeats: .EveryTwoWeeks)
        let expectedA = [a1]
        let expectedR = [Repetitions.EveryTwoWeeks:[0]]
        automationManager.addAutomation(a1)
        XCTAssert(expectedA == automationManager.getAutomations())
        XCTAssert(expectedR == automationManager.getRepetitions())
    }
    
    func test_addTwoDiffentRepAuto() {
        let a1 = Automation(product: product1, repeats: .EveryTwoWeeks)
        let a2 = Automation(product: product1, repeats: .EveryDay)
        let expectedA = [a1,a2]
        let expectedR = [Repetitions.EveryTwoWeeks:[0],Repetitions.EveryDay:[1]]
        automationManager.addAutomation(a1)
        automationManager.addAutomation(a2)
        XCTAssert(expectedA == automationManager.getAutomations())
        XCTAssert(expectedR == automationManager.getRepetitions())
    }
    
    func test_addSameRepAuto() {
        let a1 = Automation(product: product1, repeats: .EveryDay)
        let a2 = Automation(product: product1, repeats: .EveryDay)
        let expectedA = [a1,a2]
        let expectedR = [Repetitions.EveryDay:[0,1]]
        automationManager.addAutomation(a1)
        automationManager.addAutomation(a2)
        XCTAssert(expectedA == automationManager.getAutomations())
        XCTAssert(expectedR == automationManager.getRepetitions())
    }
    
    func test_removing() {
        let a1 = Automation(product: product1, repeats: .EveryDay)
        let a2 = Automation(product: product1, repeats: .EveryDay)
        let expectedA = [a1,a2]
        let expectedR = [Repetitions.EveryDay:[0,1]]
        let expectedA2 = [a2]
        let expectedR2 = [Repetitions.EveryDay:[0]]
        automationManager = AutomationManager(automations: expectedA)
        XCTAssert(expectedA == automationManager.getAutomations())
        XCTAssert(expectedR == automationManager.getRepetitions())
        automationManager.removeAutomation(a1)
        XCTAssert(expectedA2 == automationManager.getAutomations())
        XCTAssert(expectedR2 == automationManager.getRepetitions())
    }
    
    func test_checkDates() {
        let a1 = Automation(product: product1, repeats: .EveryDay, staringDate: Date.distantPast, endDate: Date.now.yesterday, lastApplied: Date.now.yesterday)
        automationManager = AutomationManager(automations: [a1])
        automationManager.checkEndingDates()
        XCTAssert(automationManager.getAutomations().isEmpty)
        XCTAssert(automationManager.getRepetitions().isEmpty)
    }
    
    func test_checkDates2() {
        let a1 = Automation(product: product1, repeats: .EveryDay, staringDate: Date.distantPast, endDate: Date.now.yesterday, lastApplied: Date.now.yesterday)
        let a2 = Automation(product: product1, repeats: .EveryDay, staringDate: Date.distantPast, endDate: Date.distantFuture, lastApplied: Date.now.yesterday)
        automationManager = AutomationManager(automations: [a1,a2])
        automationManager.checkEndingDates()
        XCTAssert(automationManager.getAutomations() == [a2])
        XCTAssert(automationManager.getRepetitions() == [Repetitions.EveryDay:[0]])
    }
    
    func test_applyProducts1() {
        let a1 = Automation(product: product1, repeats: .EveryDay, staringDate: Date.distantPast, endDate: Date.now.yesterday, lastApplied: Date.now.yesterday)
        let a2 = Automation(product: product1, repeats: .Weekly, staringDate: Date.distantPast, endDate: Date.distantFuture, lastApplied: Date.now.yesterday)
        let mmTest = MoneyManagement()
        automationManager = AutomationManager(automations: [a1,a2])
        automationManager.applyTodayProducts(to: mmTest)
        XCTAssert(automationManager.getAutomations() == [a1,a2])
        XCTAssert(automationManager.getRepetitions() == [Repetitions.EveryDay:[0],Repetitions.Weekly:[1]])
        XCTAssert(mmTest.getAllMovements(for: .Expense)[0].sum == -100)
        XCTAssert(mmTest.getAllMovements(for: .Expense)[0].products == [product1])
    }
    
    func test_applyProducts2() {
        let a1 = Automation(product: product1, repeats: .EveryDay, staringDate: Date.distantPast, endDate: Date.now.yesterday, lastApplied: Date.now.yesterday)
        let a2 = Automation(product: product1, repeats: .Weekly, staringDate: Date.distantPast, endDate: Date.distantFuture, lastApplied: Date.now.yesterday)
        let mmTest = MoneyManagement()
        automationManager = AutomationManager(automations: [a1,a2])
        automationManager.applyTodayProducts(to: mmTest)
        XCTAssert(mmTest.getAllMovements(for: .Expense)[0].sum == -100)
        XCTAssert(mmTest.getAllMovements(for: .Expense)[0].products == [product1])
        automationManager.applyTodayProducts(to: mmTest)
        XCTAssert(mmTest.getAllMovements(for: .Expense)[0].sum == -100)
        XCTAssert(mmTest.getAllMovements(for: .Expense)[0].products == [product1])
    }
    
    func test_applyProducts3() {
        let a1 = Automation(product: product1, repeats: .EveryDay, staringDate: Date.distantPast, endDate: Date.now.yesterday, lastApplied: Date.now.yesterday)
        let a2 = Automation(product: product1, repeats: .Weekly, staringDate: Date.distantPast, endDate: Date.distantFuture, lastApplied: Date.now - 604800)
        let a3 = Automation(product: product1, repeats: .EveryTwoWeeks, staringDate: Date.distantPast, endDate: Date.distantFuture, lastApplied: Date.now - 1209600)
        let a4 = Automation(product: product1, repeats: .Monthly, staringDate: Date.distantPast, endDate: Date.distantFuture, lastApplied: Date.now - 2628001)
        let a5 = Automation(product: product1, repeats: .EveryThreeMonths, staringDate: Date.distantPast, endDate: Date.distantFuture, lastApplied: Date.now - 78884003)
        let a6 = Automation(product: product1, repeats: .EverySixMonths, staringDate: Date.distantPast, endDate: Date.distantFuture, lastApplied: Date.now - 15768006)
        let a7 = Automation(product: product1, repeats: .EveryYear, staringDate: Date.distantPast, endDate: Date.distantFuture, lastApplied: Date.now - 31536013)
        let mmTest = MoneyManagement()
        automationManager = AutomationManager(automations: [a1,a2,a3,a4,a5,a6,a7])
        automationManager.applyTodayProducts(to: mmTest)
        XCTAssert(mmTest.getAllMovements(for: .Expense)[0].sum == -700)
        XCTAssert(mmTest.getAllMovements(for: .Expense)[0].products == [productS])
    }
    

}
