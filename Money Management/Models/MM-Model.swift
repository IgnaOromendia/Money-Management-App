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
    let movement: Movment
    var quantity: Int
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price && lhs.category == rhs.category
    }
    
    mutating func incrmentQuantity() {
        self.quantity += 1
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
    
    // MARK: - Inits
    
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
    
    // MARK: - Get functions
    
    /// Returns the expenses of the date and the sum of them
    func dateExpenses(on d: Date) -> ProductsData? {
        return self.expenses[d.getKeyData()]
    }
    
    /// Returns the earnings of the date and the sum of them
    func dateEarnings(on d: Date) -> ProductsData? {
        return self.earnings[d.getKeyData()]
    }
    
    /// Returns the debts
    func getDebts() -> Dictionary<Name,Int> {
        return self.debts
    }
    
    /// Returns the debtors
    func getDebtors() -> Dictionary<Name,Int> {
        return self.debtors
    }
    
    /// Returns the categories
    func getCategories() -> Set<Category> {
        return self.categories
    }
    
    // MARK: - Set functions
    
    /// Add an expense to a date
    func addExpenses(product: Product,on d: Date) throws {
        let date = d.getKeyData()
        let expensesD = self.expenses[date]
        
        if var expensesD = expensesD {
            if let oldProduct = expensesD.products.find(product) {
                do {
                    var newProduct = oldProduct
                    newProduct.incrmentQuantity()
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
    
    /// Add an earning to a date
    func addEarnings(product: Product,on d: Date) throws {
        let date = d.getKeyData()
        let earningD = self.earnings[date]
        
        if var earningD = earningD {
            if let oldProduct = earningD.products.find(product) {
                do {
                    var newProduct = oldProduct
                    newProduct.incrmentQuantity()
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
    
    /// Add a debt
    func addDebt(name: Name, amount: Int) {
        if let oldDebt = self.debts[name] {
            self.debts.updateValue(oldDebt + amount, forKey: name)
        } else {
            self.debts.updateValue(amount, forKey: name)
        }
    }
    
    /// Add a debtor
    func addDebtor(name: Name, amount: Int) {
        if let oldDebt = self.debtors[name] {
            self.debtors.updateValue(oldDebt + amount, forKey: name)
        } else {
            self.debtors.updateValue(amount, forKey: name)
        }
    }
    
    /// Add a category
    func addCategory(_ c: Category) {
        self.categories.insert(c)
    }
    
    // MARK: - Other funcitions
    
    /// Retruns the amount of money earned or spent in that month
    func monthlyMovment(_ month: Int, for m: Movment) -> Int {
        let monthMovment: Array<Int> = getAllMonthMovment(month,for: m).map({$0.sum})
        return monthMovment.reduce(0, +)
    }
    
    /// Retruns an array of products earned or spent in that month
    func getAllMonthMovment(_ month: Int, for m: Movment) -> Array<ProductsData> {
        switch m {
        case .Expense:
            return getValuesSortedByDate(of: self.expenses.filter({return $0.key.month == month}))
        case .Earning:
            return getValuesSortedByDate(of: self.earnings.filter({return $0.key.month == month}))
        case .Both:
            let dic = self.expenses.merging(self.earnings, uniquingKeysWith: {return ProductsData(products: $0.products.union($1.products), sum: $0.sum + $1.sum)})
            return getValuesSortedByDate(of: dic.filter({return $0.key.month == month}))
        }
    }
    
    /// Retruns the amount of money earned or spent in that week
    func weeklyMovment(_ week: Int,for m: Movment) -> Int {
        let weekMovment: Array<Int> = getAllWeekMovment(week,for: m).map({$0.sum})
        return weekMovment.reduce(0, +)
    }
    
    /// Retruns an array of products earned or spent in that week
    func getAllWeekMovment(_ week: Int, for m: Movment) -> Array<ProductsData> {
        switch m {
        case .Expense:
            return getValuesSortedByDate(of: self.expenses.filter({return $0.key.weekOfMonth == week}))
        case .Earning:
            return getValuesSortedByDate(of: self.earnings.filter({return $0.key.weekOfMonth == week}))
        case .Both:
            let dic = self.expenses.merging(self.earnings, uniquingKeysWith: {return ProductsData(products: $0.products.union($1.products), sum: $0.sum + $1.sum)})
            return getValuesSortedByDate(of: dic.filter({return $0.key.weekOfMonth == week}))
        }
    }
    
    /// Returns a balance between earnings and expenses from one date to another (also works for the same date)
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
    
    /// Get values sorted by date
    private func getValuesSortedByDate(of d:Dictionary<DateComponents,ProductsData>) -> Array<ProductsData> {
        var result: Array<ProductsData> = []
        let keysSorted = d.keys.sorted(by: { $0 > $1 })
        for item in keysSorted {
            result.append(d[item]!)
        }
        return result
    }
    
    /// Returns the difference of expenses between two dates
    /// True = expenses on d1 ≤ expenses on d2
    /// Fasle = expenses on d1 ≥ expenses on d2
    func expensesDifferences(between d1: Date, _ d2: Date) -> (Bool,Int) {
        let expensesD1 = self.dateExpenses(on: d1)?.sum ?? 0
        let expensesD2 = self.dateExpenses(on: d2)?.sum ?? 0
        return (expensesD1 < expensesD2, abs(expensesD1 - expensesD2))
    }
    
    
    
}
