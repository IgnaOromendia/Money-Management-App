//
//  MovementsController.swift
//  Money Management
//
//  Created by Igna on 06/07/2022.
//

import UIKit

class MovementsController: UIViewController {
    
    // Day Balance View
    @IBOutlet weak var view_dayBalance: UIView!                 // Corner radius = 20, white
    @IBOutlet weak var lbl_dayBalanceTitle: UILabel!            // FontSze = 24, Semi Bold, black, Helvetica
    @IBOutlet weak var lbl_dayBalanceMoney: UILabel!            // FontSze = 36, Light , black, Helvetica
    @IBOutlet weak var lbl_dayBalanceCompYesterday: UILabel!    // FontSze = 16, Regular , (158,191,131), Helvetica
    @IBOutlet weak var lbl_dayBalanceComp2days: UILabel!        // FontSze = 16, Regular , (255,139,139), Helvetica
    @IBOutlet weak var btn_DayBalancePlus: UIButton!            // Corner radius = height / 2, (72,129,215)
    
    var expenses1 = ProductsData(products: [Product(name: "Coca", price: 100, category: "Bebida", amount: 1),
                                           Product(name: "Hielo", price: 50, category: "Otros", amount: 1)], sum: 150)
    
    var expenses2 = ProductsData(products: [Product(name: "Coca", price: 100, category: "Bebida", amount: 1),], sum: 100)
    
    var earnings = ProductsData(products: [Product(name: "Robo", price: 500, category: "Otros", amount: 1)], sum: 500)
    
    let date = Date().getKeyData()
    let dateY = Date().yesterday.getKeyData()
    let dateTwoD = Date.now.yesterday.yesterday.getKeyData()
    
    override func viewDidLoad() {
        let mm = MoneyManagement(expenses: [dateY:expenses1, date:expenses2], earnings: [date:earnings], debts: [:], debtors: [:], categories: [])
        let MCViewModel = MovmentViewModel(mm)
        
        super.viewDidLoad()
        MCViewModel.setUpDayBalanceView(containerView: view_dayBalance,
                                        title: lbl_dayBalanceTitle,
                                        money: lbl_dayBalanceMoney,
                                        compLabel1: lbl_dayBalanceCompYesterday,
                                        compLabel2: lbl_dayBalanceComp2days,
                                        btn: btn_DayBalancePlus)
        
    }
    
    
    

}
