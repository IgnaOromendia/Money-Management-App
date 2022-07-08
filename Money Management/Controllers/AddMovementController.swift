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
    
    let addMovVM = AddMovementViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpController()
        setNavigationTransparent()
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
        lbl_titleP.text = txt_title.text ?? "No-Name"
        lbl_priceP.text = "-" + (txt_price.text ?? "$0")
        lbl_detailsP.text = (txt_category.text ?? "No-Cat") + " " + (txt_quantity.text ?? "x1")
        textField.resignFirstResponder()
        return true
    }
    
    // ACTIONS
    @IBAction func goToCalendar(_ sender: UIButton) {
    }
    
    @IBAction func saveMovement(_ sender: UIButton) {
    }
    
    // OTHERS
    
    private func setUpController() {
        view.backgroundColor = customBlue
    }
    
}
