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
    @IBOutlet var text: [UITextField]!
    
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
    }
    
    // TEXTFIELD
    
    // ACTIONS
    
    // OTHERS
    
}
