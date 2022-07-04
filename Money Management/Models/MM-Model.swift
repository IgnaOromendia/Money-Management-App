//
//  MM-Model.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

class MoneyManagement {
    private var expenses: Dictionary<Date,DayData>
    private var earnings: Dictionary<Date,DayData>
    private var monthlyExpenses: Array<Int>         // 12 positions
    private var monthlyEarnings: Array<Int>         // 12 positions
    private var debts: Dictionary<Name,Int>
    private var debtor: Dictionary<Name,Int>
    private var categories: Set<Category>
    
    init(expenses: Dictionary<Date,DayData>, earnings: Dictionary<Date,DayData>, monthlyExpenses: Array<Int>,
         monthlyEarnings: Array<Int>, debts: Dictionary<Name,Int>, debtor: Dictionary<Name,Int>, categories: Set<Category>) {
        self.expenses = expenses
        self.earnings = earnings
        self.monthlyExpenses = monthlyExpenses
        self.monthlyEarnings = monthlyEarnings
        self.debts = debts
        self.debtor = debtor
        self.categories = categories
    }
    
    convenience init(expenses: Dictionary<Date,DayData>, earnings: Dictionary<Date,DayData>, debts: Dictionary<Name,Int>, debtor: Dictionary<Name,Int>, categories: Set<Category>) {
        self.init(expenses: expenses,earnings: earnings,monthlyExpenses: [],monthlyEarnings: [],debts: debts,debtor: debtor, categories: categories)
    }
    
    convenience init() {
        self.init(expenses: [:],earnings: [:],monthlyExpenses: [],monthlyEarnings: [],debts: [:],debtor: [:], categories: [])
    }
    
    
    
    
}
