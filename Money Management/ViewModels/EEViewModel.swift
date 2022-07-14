//
//  EEViewModel.swift
//  Money Management
//
//  Created by Igna on 11/07/2022.
//

import Foundation
import UIKit

final class EEViewModel {
    private var expenses: Array<ProductsData> = []
    private var earnings: Array<ProductsData> = []
    private var arrEE: Array<ProductsData> = []
    
    let cellId = "ExpensesCell"
    let cellHeight = 70.0
    
    var sectionTitles: Array<String> = []
    
    var selectedMov: Movement = .Both
    
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
        self.updateData(from: m)
    }
    
    func updateData(from m: MoneyManagement) {
        self.arrEE = m.getAllMovements(for: .Both)
        //self.expenses = m.getAllMovements(for: .Expense)
        //self.earnings = m.getAllMovements(for: .Earning)
        self.selectedMov = .Both
        self.sectionTitles = getSectionTitles()
    }
    
    func setUpTableView(_ tableView: UITableView) {
        let nibCell = UINib(nibName: cellId, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
    }
    
    func setUpBtn(_ btn: UIBarButtonItem, _ btnT: UIBarButtonItem) {
        btn.isEnabled = !selectedArr.isEmpty
        btnT.isEnabled = false
    }
    
    func setEditStyle(_ tableView: UITableView, _ btn:UIBarButtonItem, _ btnT: UIBarButtonItem) {
        let isEditing = btn.title == "Cancel" // true = is editing
        
        btn.title = isEditing ? "Edit" : "Cancel"
        btnT.isEnabled = !isEditing
        tableView.allowsMultipleSelection = !isEditing
        
        if isEditing {
            for sec in 0...numberOfSections {
                if sec < numberOfRowsPerSection.count {
                    for row in 0...numberOfRowsPerSection[sec] {
                        let index = IndexPath(row: row, section: sec)
                        tableView.cellForRow(at: index)?.setSelected(false, animated: true)
                    }
                }
            }
        }
    }
    
    func getIndex(of p: Product, on section: Int) -> Int? {
        return selectedArr[section].products.setToArray().getIndex(of: p)
    }
    
    func deleteSelection(_ arr: Array<(DateComponents,Product)>) {
        for data in arr {
            switch data.1.movement {
            case .Earning:
                mm.removeEarning(data.1, on: data.0)
            case .Expense:
                mm.removeExpense(data.1, on: data.0)
            default:
                print("Not reachable")
            }
        }
        updateData(from: mm)
    }
    
    private func getSectionTitles() -> Array<String> {
        var result: Array<String> = []
        for elem in self.selectedArr {
            result.append(elem.date.prettyDate)
        }
        return result
    }
    
}
