//
//  AddDebtViewModel.swift
//  Money Management
//
//  Created by Igna on 11/07/2022.
//

import Foundation
import UIKit

final class AddDebtViewModel {
    
    private let validate = DataValidation()
    
    func add(of d: DebtData) {
        switch d.type {
        case .Debt:
            mm.addDebt(name: d.name, amount: d.amount)
        case .Debtor:
            mm.addDebtor(name: d.name, amount: d.amount)
        }
    }
    
    func validation(name: String?, amount: String?, type: DebtType ) throws -> DebtData {
        try validate.emptyText(name)
        try validate.emptyText(amount)
        try validate.onlyNumbers(on: amount!)
        let amountInt = Int(amount!)!
        return DebtData(name: name!, amount: amountInt, type: type)
    }
    
    func setUpTexts(_ txtName: UITextField, _ txtAmount: UITextField) {
        txtName.placeholder = "Name"
        txtAmount.placeholder = "Amount"
    }
    
    func setUpSegmentedControl(_ seg: UISegmentedControl) {
        seg.setTitle("Debt", forSegmentAt: 0)
        seg.setTitle("Debtor", forSegmentAt: 1)
    }
    
    func setUpBtn(_ btnSave: UIButton,_ btnCancel: UIButton) {
        btnSave.cornerRadius(of: 15.0)
        btnSave.backgroundColor = customBlue
        btnSave.setTitle("Save", for: .normal)
        btnSave.setTitleColor(.white, for: .normal)
        
        btnCancel.cornerRadius(of: 15.0)
        btnCancel.backgroundColor = .systemRed
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(.white, for: .normal)
    }
    
    func setUpView(_ view: UIView) {
        view.cornerRadius(of: 20.0)
        view.shadow = true
    }
    
    func setUpController(_ vc: UIViewController) {
        vc.view.applyBlurEffect(style: .systemThinMaterialLight)
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: reloadDataDebtNotification, object: nil)
    }
    
}
