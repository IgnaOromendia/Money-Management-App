//
//  EEViewModel.swift
//  Money Management
//
//  Created by Igna on 11/07/2022.
//

import Foundation
import UIKit

final class EEViewModel {
    private let expenses: Array<ProductsData>
    private let earnings: Array<ProductsData>
    private let arrEE: Array<ProductsData>
    
    let cellId = "ExpensesCell"
    let cellHeight = 70.0
    
    var sectionTitles: Array<String> = []
    
    var selectedMov: Movement
    
    var selectedArr: Array<ProductsData> {
        switch selectedMov {
        case .Expense:
            return expenses
        case .Earning:
            return earnings
        case .Both:
            return arrEE
        }
    }
    
    var numberOfSections: Int {
        switch selectedMov {
        case .Expense:
            return expenses.count
        case .Earning:
            return earnings.count
        case .Both:
            return arrEE.count
        }
    }
    
    var numberOfRowsPerSection: Array<Int> {
        var result: Array<Int> = []
        
        for item in selectedArr {
            result.append(item.products.count)
        }
        
        return result
    }
    
    init(_ m: MoneyManagement) {
        self.arrEE = m.getAllMovements(for: .Both)
        self.expenses = m.getAllMovements(for: .Expense)
        self.earnings = m.getAllMovements(for: .Earning)
        self.selectedMov = .Both
        self.sectionTitles = getSectionTitles()
    }
    
    func setUpTableView(_ tableView: UITableView) {
        let nibCell = UINib(nibName: cellId, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    private func getSectionTitles() -> Array<String> {
        
        var result: Array<String> = []
        var date = Date.now
        for _ in 0...self.selectedArr.count {
            result.append(date.prettyDate)
            date.stepBackOneDay()
        }
        return result
    }
    
}
