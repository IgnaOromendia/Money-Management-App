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
    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var view_popOver: UIView!
    
    private let addDebtViewModel = AddDebtViewModel()
    private let storageManager = StorageManager()
    private let alertManager = AlertManager()
    
    var selectedType: DebtType {
        return segmentedControl.selectedSegmentIndex == 0 ? .Debt : .Debtor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        alertManager.setViewController(self)
        addDebtViewModel.setUpTexts(txt_name, txt_amount)
        addDebtViewModel.setUpBtn(btn_save,btn_cancel)
        addDebtViewModel.setUpSegmentedControl(segmentedControl)
        addDebtViewModel.setUpController(self)
        addDebtViewModel.setUpView(view_popOver)
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
            addDebtViewModel.postNotification()
            storageManager.save(mm, fileName: jsonFileName)
            dismiss(animated: true)
        } catch ValidationErrors.emptyText{
            alertManager.simpleAlert(title: titleError, message: messageEmpty)
        } catch ValidationErrors.notNumberChar {
            alertManager.simpleAlert(title: titleError, message: messageNotNumber)
        } catch {
            print(error)
        }
    }
    
    @IBAction func cancelAdd(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
