//
//  MM-Model.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

struct Product: Hashable, Equatable {
    let name: String
    let price: Int
    let category: Category
    var amount: Int
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price && lhs.category == rhs.category
    }
    
    mutating func incrmentAmount() {
        self.amount += 1
    }
}

struct ProductsData: Equatable {
    var products: Set<Product>
    var sum: Int
}

class MoneyManagement {
    private var expenses: Dictionary<DateComponents,ProductsData>
    private var earnings: Dictionary<DateComponents,ProductsData>
    private var monthlyExpenses: Array<Int>                         // 12 positions
    private var monthlyEarnings: Array<Int>                         // 12 positions
    private var debts: Dictionary<Name,Int>
    private var debtors: Dictionary<Name,Int>
    private var categories: Set<Category>
    
    init(expenses: Dictionary<DateComponents,ProductsData>, earnings: Dictionary<DateComponents,ProductsData>, monthlyExpenses: Array<Int>,
         monthlyEarnings: Array<Int>, debts: Dictionary<Name,Int>, debtors: Dictionary<Name,Int>, categories: Set<Category>) {
        self.expenses = expenses
        self.earnings = earnings
        self.monthlyExpenses = monthlyExpenses
        self.monthlyEarnings = monthlyEarnings
        self.debts = debts
        self.debtors = debtors
        self.categories = categories
    }
    
    convenience init(expenses: Dictionary<DateComponents,ProductsData>, earnings: Dictionary<DateComponents,ProductsData>, debts: Dictionary<Name,Int>, debtors: Dictionary<Name,Int>, categories: Set<Category>) {
        var arr1 = Array(repeating: 0, count: 12)
        var arr2 = Array(repeating: 0, count: 12)
        
        
        for (dateKey,product) in expenses {
            arr1[dateKey.month!] += product.sum
        }
        
        for (dateKey,product) in earnings {
            arr2[dateKey.month!] += product.sum
        }
        
        self.init(expenses: expenses,earnings: earnings,monthlyExpenses: arr1,monthlyEarnings: arr2,debts: debts,debtors: debtors, categories: categories)
    }
    
    convenience init() {
        let arr = Array(repeating: 0, count: 12)
        self.init(expenses: [:],earnings: [:],monthlyExpenses: arr,monthlyEarnings: arr,debts: [:],debtors: [:], categories: [])
    }
    
    // Get functions
    
    func dateExpenses(on d: Date) -> ProductsData? {
        return self.expenses[d.getKeyData()]
    }
    
    func dateEarnings(on d: Date) -> ProductsData? {
        return self.earnings[d.getKeyData()]
    }
    
    func getDebts() -> Dictionary<Name,Int> {
        return self.debts
    }
    
    func getDebtors() -> Dictionary<Name,Int> {
        return self.debtors
    }
    
    func getCategories() -> Set<Category> {
        return self.categories
    }
    
    // Set functions
    
    func addExpenses(product: Product,on d: Date) throws {
        let date = d.getKeyData()
        let expensesD = self.expenses[date]
        
        if var expensesD = expensesD {
            if let oldProduct = expensesD.products.find(product) {
                do {
                    var newProduct = oldProduct
                    newProduct.incrmentAmount()
                    try expensesD.products.replace(old: oldProduct, new: newProduct)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                expensesD.products.insert(product)
            }
            expensesD.sum += product.price
            self.expenses.updateValue(expensesD, forKey: date)
        } else {
            let data = ProductsData(products: [product], sum: product.price)
            self.expenses.updateValue(data, forKey: date)
        }
        
        if let month = date.month {
            monthlyExpenses[month] += product.price
        } else {
            throw AddErrors.monthError
        }
    }
    
    func addEarnings(product: Product,on d: Date) throws {
        let date = d.getKeyData()
        let earningD = self.earnings[date]
        
        if var earningD = earningD {
            if let oldProduct = earningD.products.find(product) {
                do {
                    var newProduct = oldProduct
                    newProduct.incrmentAmount()
                    try earningD.products.replace(old: oldProduct, new: newProduct)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                earningD.products.insert(product)
            }
            earningD.sum += product.price
            self.earnings.updateValue(earningD, forKey: date)
        } else {
            let data = ProductsData(products: [product], sum: product.price)
            self.earnings.updateValue(data, forKey: date)
        }
        
        if let month = date.month {
            monthlyEarnings[month] += product.price
        } else {
            throw AddErrors.monthError
        }
    }
    
    func addDebt(name: Name, amount: Int) {
        if let oldDebt = self.debts[name] {
            self.debts.updateValue(oldDebt + amount, forKey: name)
        } else {
            self.debts.updateValue(amount, forKey: name)
        }
    }
    
    func addDebtor(name: Name, amount: Int) {
        if let oldDebt = self.debtors[name] {
            self.debtors.updateValue(oldDebt + amount, forKey: name)
        } else {
            self.debtors.updateValue(amount, forKey: name)
        }
    }
    
    func addCategory(_ c: Category) {
        self.categories.insert(c)
    }
    
    // Other funcitions
    
    func monthlyMovment(_ month: Int, for m: Movment) -> Int {
        let monthMovment: Array<Int> = getAllMonthMovment(month,for: m).map({$0.sum})
        return monthMovment.reduce(0, +)
    }
    
    private func getAllMonthMovment(_ month: Int, for m: Movment) -> Array<ProductsData> {
        switch m {
        case .Expense:
            return self.expenses.filter({return $0.key.month == month}).map({$0.value})
        case .Earning:
            return self.earnings.filter({return $0.key.month == month}).map({$0.value})
        }
    }
    
    func weeklyExpenses(_ week: Int,for m: Movment) -> Int {
        let weekMovment: Array<Int> = getAllWeekMovment(week,for: m).map({$0.sum})
        return weekMovment.reduce(0, +)
    }
    
    private func getAllWeekMovment(_ week: Int, for m: Movment) -> Array<ProductsData> {
        switch m {
        case .Expense:
            return self.expenses.filter({return $0.key.weekOfMonth == week}).map({$0.value})
        case .Earning:
            return self.earnings.filter({return $0.key.weekOfMonth == week}).map({$0.value})
        }
    }
    
    func balance(from d1:DateComponents, to d2: DateComponents) -> Int {
        var result = 0
        var day = d1
        while day != d2 {
            result += ((self.earnings[d1]?.sum ?? 0) - (self.expenses[d1]?.sum ?? 0))
            day = day.date?.advanced(by: 86400).getKeyData() ?? d2
        }
        result += ((self.earnings[d2]?.sum ?? 0) - (self.expenses[d2]?.sum ?? 0))
        return result
    }
    
    
    
    
}
