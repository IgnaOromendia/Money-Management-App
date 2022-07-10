//
//  DebtsController.swift
//  Money Management
//
//  Created by Igna on 10/07/2022.
//

import UIKit

class DebtsController: UITableViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // VARIABLES
    let debtsViewModel = DebtsViewModel(mm)
    var selectedType: DebtType = DebtType.Debt
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debtsViewModel.setUpSegControl(segmentedControl)
    }
    
    // ACTIONS
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        selectedType = sender.selectedSegmentIndex == 0 ? .Debt : .Debtor
    }
    
    // TABLE VIEW

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debtsViewModel.numberOfRows(for: selectedType)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: debtsViewModel.cellID, for: indexPath) as! DebtsCell
        let data = debtsViewModel.getData(for: indexPath.row, selectedType)
        cell.fillWithData(name: data.0, amount: data.1, debt: selectedType)
        return cell
    }
    
}
