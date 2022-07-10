//
//  DebtsViewModel.swift
//  Money Management
//
//  Created by Igna on 10/07/2022.
//

import Foundation
import UIKit

fileprivate struct DebtData: Equatable {
    let name: String
    let amount: Int
    
    func tuple() -> (String,Int) {
        return (name,amount)
    }
}

final class DebtsViewModel {
    
    let cellHeight = 55
    let cellID = "DebtCellID"
    private var debts: Array<DebtData> = []
    private var debtors: Array<DebtData> = []
    
    init(_ m: MoneyManagement) {
        
    }
    
    func numberOfRows(for d: DebtType) -> Int {
        switch d {
        case .Debt:
            return self.debts.count
        case .Debtor:
            return self.debtors.count
        }
    }
    
    func getData(for i:Int, _ t:DebtType) -> (String,Int) {
        switch t {
        case .Debt:
            return self.debts[i].tuple()
        case .Debtor:
            return self.debtors[i].tuple()
        }
    }
    
    
    func setUpSegControl(_ seg: UISegmentedControl) {
        //seg.insertSegment(withTitle: "Both", at: 0, animated: false)
        seg.setTitle("Debts", forSegmentAt: 0)
        seg.setTitle("Debtors", forSegmentAt: 1)
        seg.selectedSegmentIndex = 0
    }
    
    
}
