//
//  DebtsViewModel.swift
//  Money Management
//
//  Created by Igna on 10/07/2022.
//

import Foundation
import UIKit

struct DebtData: Equatable {
    let name: String
    let amount: Int
    let type: DebtType
}

final class DebtsViewModel {
    
    let cellHeight = 55.0
    let cellID = "DebtsCell"
    private var arrDD: Array<DebtData> = []
    
    init(_ m: MoneyManagement) {
        update(from: m)
    }
    
    func update(from m: MoneyManagement) {
        arrDD = m.getDebts().map({ (key: Name, value: Int) in
            return DebtData(name: key, amount: value, type: .Debt)
        })
        arrDD.append(contentsOf: m.getDebtors().map({ (key: Name, value: Int) in
            return DebtData(name: key, amount: value, type: .Debtor)
        }))
    }
    
    func numberOfRows() -> Int {
        return arrDD.count
    }
    
    func getData(for i:Int) -> DebtData {
        return self.arrDD[i]
    }
    
    func getIndex(of d: DebtData) -> Int? {
        return self.arrDD.getIndex(of: d)
    }
    
    func deleteSelection(_ selection:Array<Int>) {
        for i in selection {
            let item = self.arrDD.remove(at: i)
            if item.type == .Debt {
                mm.removeDebt(of: item.name)
            } else {
                mm.removeDebtor(of: item.name)
            }
        }
    }
    
    func setUpTableView(_ tableView: UITableView) {
        let nibCell = UINib(nibName: cellID, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: cellID)
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
    }
    
    func setUpEditingStyle(_ tableView: UITableView,_ editBtn: UIBarButtonItem, _ addBtn: UIBarButtonItem,_ deleteBtn: UIBarButtonItem) {
        let isEditing = editBtn.title == "Cancel" // true = is editing
        
        tableView.allowsMultipleSelection = !isEditing
        addBtn.isEnabled = isEditing
        deleteBtn.isEnabled = !isEditing
        editBtn.title = isEditing ? "Edit" : "Cancel"
        
        if isEditing {
            for i in 0...self.arrDD.count {
                let index = IndexPath(row: i, section: 0)
                tableView.cellForRow(at: index)?.setSelected(false, animated: true)
            }
            
        }
    }
}
