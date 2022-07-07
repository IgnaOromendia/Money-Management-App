//
//  MovementsController.swift
//  Money Management
//
//  Created by Igna on 06/07/2022.
//

import UIKit

// TEST's begins
var expenses1 = ProductsData(products: [Product(name: "Coca", price: 100, category: "Bebida", amount: 1),
                                       Product(name: "Hielo", price: 50, category: "Otros", amount: 1)], sum: 150)

var expenses2 = ProductsData(products: [Product(name: "Coca", price: 100, category: "Bebida", amount: 1),], sum: 100)

var expenses3 = ProductsData(products: [Product(name: "Mila", price: 600, category: "Comida", amount: 1),], sum: 600)

var earnings = ProductsData(products: [Product(name: "Robo", price: 500, category: "Otros", amount: 1)], sum: 500)

let date = Date().getKeyData()
let dateY = Date().yesterday.getKeyData()
let dateTwoD = Date.now.yesterday.advanced(by: -86400).getKeyData()
let mm = MoneyManagement(expenses: [date:expenses2, dateY:expenses1, dateTwoD:expenses3],
                         earnings: [date:earnings],
                         debts: [:],
                         debtors: [:],
                         categories: [])
// END of TEST coca, hielo-coca, mila

class MovementsController: UIViewController, UITableViewController_D_DS {
    
    
    // Day Balance View
    @IBOutlet weak var view_dayBalance: UIView!                 // Corner radius = 20, white
    @IBOutlet weak var lbl_dayBalanceTitle: UILabel!            // FontSze = 24, Semi Bold, black, Helvetica
    @IBOutlet weak var lbl_dayBalanceMoney: UILabel!            // FontSze = 36, Light , black, Helvetica
    @IBOutlet weak var lbl_dayBalanceCompYesterday: UILabel!    // FontSze = 16, Regular , (158,191,131), Helvetica
    @IBOutlet weak var lbl_dayBalanceComp2days: UILabel!        // FontSze = 16, Regular , (255,139,139), Helvetica
    @IBOutlet weak var btn_DayBalancePlus: UIButton!            // Corner radius = height / 2, (72,129,215)
    
    // Table view
    @IBOutlet weak var tableView_expenses: UITableView!
    
    let MCViewModel = MovmentViewModel(mm)
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MCViewModel.setUpTableView(tableView_expenses)
        MCViewModel.setUpDayBalanceView(containerView: view_dayBalance,
                                        title: lbl_dayBalanceTitle,
                                        money: lbl_dayBalanceMoney,
                                        compLabel1: lbl_dayBalanceCompYesterday,
                                        compLabel2: lbl_dayBalanceComp2days,
                                        btn: btn_DayBalancePlus)
    }
    
    
    // MARK: - TABLE VIEW
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MCViewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MCViewModel.sectionTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MCViewModel.sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MCViewModel.rowsPerSection[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MCViewModel.cellId, for: indexPath) as! ExpensesCell
        let product = MCViewModel.productsPerDay[indexPath.section].products.setToArray()[indexPath.row]
        cell.fillWithData(product)
        return cell
    }
    
    

}
