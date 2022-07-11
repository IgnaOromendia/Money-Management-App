//
//  EEController.swift
//  Money Management
//
//  Created by Igna on 11/07/2022.
//

import UIKit

class EEController: UITableViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let eeViewModel = EEViewModel(mm)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eeViewModel.setUpTableView(tableView)
    }
    @IBAction func changeMovement(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            eeViewModel.selectedMov = .Both
        } else if sender.selectedSegmentIndex == 1 {
            eeViewModel.selectedMov = .Expense
        } else {
            eeViewModel.selectedMov = .Earning
        }
        tableView.reloadData()
    }
    
    // TABLE VIEW
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return eeViewModel.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eeViewModel.sectionTitles[section]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return eeViewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eeViewModel.numberOfRowsPerSection[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: eeViewModel.cellId, for: indexPath) as! ExpensesCell
        let product = eeViewModel.selectedArr[indexPath.section].products.setToArray()[indexPath.row]
        cell.fillWithData(product)
        return cell
    }

}
