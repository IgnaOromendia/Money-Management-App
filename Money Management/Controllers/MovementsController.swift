//
//  MovementsController.swift
//  Money Management
//
//  Created by Igna on 06/07/2022.
//

import UIKit

class MovementsController: UIViewController, UITableViewControllerMethods {
    
    // Day Balance View
    @IBOutlet weak var view_dayBalance: UIView!                 // Corner radius = 20, white
    @IBOutlet weak var lbl_dayBalanceTitle: UILabel!            // FontSze = 24, Semi Bold, black, Helvetica
    @IBOutlet weak var lbl_dayBalanceMoney: UILabel!            // FontSze = 36, Light , black, Helvetica
    @IBOutlet weak var lbl_dayBalanceCompYesterday: UILabel!    // FontSze = 16, Regular , (158,191,131), Helvetica
    @IBOutlet weak var lbl_dayBalanceComp2days: UILabel!        // FontSze = 16, Regular , (255,139,139), Helvetica
    @IBOutlet weak var btn_DayBalancePlus: UIButton!            // Corner radius = height / 2, (72,129,215)
    
    // Table view
    @IBOutlet weak var tableView_expenses: UITableView!
    
    
    // Variables
    private let MCViewModel = MovementViewModel(mm)
    private let storageManager = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTransparent()
        setUpController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let week = Date.now.getKeyData().weekOfMonth
        setUpController()
        if MCViewModel.productsPerDay != mm.getAllWeekMovement(week!, for: .Both) {
            MCViewModel.updateValues(mm, money: lbl_dayBalanceMoney, comp1: lbl_dayBalanceCompYesterday, comp2: lbl_dayBalanceComp2days)
            tableView_expenses.reloadData()
        }
    }
    
    // ACTIONS
    @IBAction func addMovement(_ sender: UIButton) {
        transition(to: addMovementControllerID)
    }
    
    
    // MARK: - TABLE VIEW
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MCViewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MCViewModel.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Day balance: $\(MCViewModel.productsPerDay[section].sum)"
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
    
    private func setUpController() {
        MCViewModel.setUpTableView(tableView_expenses)
        MCViewModel.setUpDayBalanceView(containerView: view_dayBalance,
                                        title: lbl_dayBalanceTitle,
                                        money: lbl_dayBalanceMoney,
                                        compLabel1: lbl_dayBalanceCompYesterday,
                                        compLabel2: lbl_dayBalanceComp2days,
                                        btn: btn_DayBalancePlus,
                                        darkMode: traitCollection.userInterfaceStyle == .dark)
    }
    
}
