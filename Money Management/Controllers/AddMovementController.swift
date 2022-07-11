//
//  AddMovementController.swift
//  Money Management
//
//  Created by Igna on 08/07/2022.
//

import UIKit

class AddMovementController: UIViewController, UITextFieldDelegate {
    
    // OUTLETES
    @IBOutlet weak var segmentedMovement: UISegmentedControl!
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var views: [UIView]!
    @IBOutlet var texts: [UITextField]!
    
    // PREVIEW
    @IBOutlet weak var lbl_preview: UILabel!
    @IBOutlet weak var view_preview: UIView!
    @IBOutlet weak var view_catP: UIView!
    @IBOutlet weak var view_containerCatP: UIView!
    @IBOutlet weak var lbl_titleP: UILabel!
    @IBOutlet weak var lbl_detailsP: UILabel!
    @IBOutlet weak var lbl_priceP: UILabel!
    
    // PRICE
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var txt_price: UITextField!
    
    // TITLE
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var view_title: UIView!
    @IBOutlet weak var txt_title: UITextField!
    
    // DATE
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var view_date: UIView!
    @IBOutlet weak var btn_calendar: UIButton!
    @IBOutlet weak var lbl_dateData: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // CATEGORY
    @IBOutlet weak var lbl_category: UILabel!
    @IBOutlet weak var view_category: UIView!
    @IBOutlet weak var txt_category: UITextField!
    
    // QUANTITY
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var view_quantity: UIView!
    @IBOutlet weak var txt_quantity: UITextField!
    
    // SAVE
    @IBOutlet weak var btn_save: UIButton!
    
    // VARIABLES
    private let addMovVM = AddMovementViewModel()
    private let validation = DataValidation()
    private var selectedDate = Date.now
    private var selectedMovement: Movement = .Expense
    private let animator = Animator()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpController()
        setNavigationTransparent()
        addMovVM.setUpSegmentedControl(segmentedMovement)
        addMovVM.setUpDate(lbl_dateData, datePicker)
        addMovVM.setUpViews(views)
        addMovVM.setUpLabels(labels)
        addMovVM.setUpTexts(texts)
        addMovVM.setUpPreview(viewP: view_preview, view_containerCatP, view_catP, lbl_titleP, lbl_detailsP, lbl_priceP)
        addMovVM.setUpBtns(btn_save, btn_calendar)
    }
    
    // TEXTFIELD
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            textField.text = "$"
        } else if textField.tag == 3 {
            textField.text = "x"
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fillWithData()
        textField.resignFirstResponder()
        return true
    }
    
    // ACTIONS
    @IBAction func goToCalendar(_ sender: UIButton) {
        let value: Double = datePicker.alpha == 1 ? 0 : 1
        animator.animateAlpha(of: datePicker, to: value)
        animator.animateAlpha(of: btn_save, to: 1 - value)
        animator.animateAlpha(of: lbl_quantity, to: 1 - value)
        animator.animateAlpha(of: view_quantity, to: 1 - value)
    }
    
    @IBAction func changeMovement(_ sender: UISegmentedControl) {
        selectedMovement = sender.selectedSegmentIndex == 0 ? .Expense : .Earning
        addMovVM.updateMoneyLabel(lbl_priceP, selectedMovement,txt_price.text ?? "")
    }
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        selectedDate = sender.date
        lbl_dateData.text = sender.date.comparableDate
        animator.animateAlpha(of: datePicker, to: 0)
        animator.animateAlpha(of: btn_save, to: 1)
        animator.animateAlpha(of: lbl_quantity, to: 1)
        animator.animateAlpha(of: view_quantity, to: 1)
    }
    
    @IBAction func saveMovement(_ sender: UIButton) {
        do {
            let product = try addMovVM.createProduct(from: txt_title.text, txt_price.text, txt_category.text, txt_quantity.text, selectedMovement)
            try validation.futureDate(selectedDate)
            
            if selectedMovement == .Expense {
                try mm.addExpenses(product: product, on: selectedDate)
            } else {
                try mm.addEarnings(product: product, on: selectedDate)
            }
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
    // OTHERS
    
    private func setUpController() {
        view.backgroundColor = customBlue
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func fillWithData() {
        let title = txt_title.text ?? ""
        var price = txt_price.text ?? "$"
        let cat = txt_category.text ?? ""
        var quant = txt_quantity.text ?? ""
        
        do {
            var quantInt = 1
            var priceInt = 0
            if !price.isEmpty {
                if price.first! == "$" {
                    price.removeFirst()
                }
                try validation.onlyNumbers(on: price)
                try validation.emptyText(price)
                priceInt = Int(price)!
            }
            if !quant.isEmpty {
                if quant.first! == "x" {
                    quant.removeFirst()
                }
                try validation.onlyNumbers(on: quant)
                quantInt = Int(quant)!
            }
            
            price = "\(priceInt * quantInt)"
            
            lbl_titleP.text = title.isEmpty ? "No-Name" : title
            lbl_priceP.text = "-$" + (price.isEmpty ? "0" : price)
            lbl_detailsP.text = cat + " x" + (quant.isEmpty ? "1" : quant)
        } catch {
            print(error)
        }
        
    }
    
}
