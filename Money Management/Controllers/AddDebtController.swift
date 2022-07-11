//
//  AddDebtController.swift
//  Money Management
//
//  Created by Igna on 11/07/2022.
//

import UIKit

class AddDebtController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_amount: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var btn_save: UIButton!
    
    let addDebtViewModel = AddDebtViewModel()
    
    var selectedType: DebtType {
        return segmentedControl.selectedSegmentIndex == 0 ? .Debt : .Debtor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addDebtViewModel.setUpTexts(txt_name, txt_amount)
        addDebtViewModel.setUpBtn(btn_save)
        addDebtViewModel.setUpSegmentedControl(segmentedControl)
    }
    
    // TEXTS
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // ACTIONS
    
    @IBAction func Save(_ sender: Any) {
        do {
            let data = try addDebtViewModel.validation(name: txt_name.text, amount: txt_amount.text, type: selectedType)
            addDebtViewModel.add(of: data)
            dismiss(animated: true)
        } catch {
            print(error)
        }
    }
    

}
