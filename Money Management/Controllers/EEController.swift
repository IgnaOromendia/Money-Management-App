//
//  EEController.swift
//  Money Management
//
//  Created by Igna on 11/07/2022.
//

import UIKit

class EEController: UITableViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var btn_edit: UIBarButtonItem!
    @IBOutlet weak var btn_trash: UIBarButtonItem!
    
    private let eeViewModel = EEViewModel(mm)
    private var deleteIndexes: Array<(DateComponents,Product)> = []
    private let storageManager = StorageManager()
    private let alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eeViewModel.updateData(from: mm)
        addObserver()
        eeViewModel.setUpTableView(tableView)
        eeViewModel.setUpBtn(btn_edit,btn_trash)
        alertManager.setViewController(self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // ACTIONS
    
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
    
    @IBAction func editEE(_ sender: UIBarButtonItem) {
        eeViewModel.setEditStyle(tableView, btn_edit, btn_trash)
    }
    
    @IBAction func deleteSelection(_ sender: Any) {
        alertManager.deleteAlert(title: titleDelete, message: messageDelete) {
            self.eeViewModel.deleteSelection(self.deleteIndexes)
            self.deleteIndexes.removeAll()
            self.tableView.reloadData()
            self.eeViewModel.setEditStyle(self.tableView, self.btn_edit, self.btn_trash)
            self.storageManager.save(mm, fileName: jsonFileName)
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ExpensesCell
        cell.setSelected(true, animated: true)
        
        let product = cell.getData()

        let date = eeViewModel.selectedArr[indexPath.section].date
        deleteIndexes.append((date,product))
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ExpensesCell
        cell.setSelected(false, animated: true)
        
        let product = cell.getData()
        let date = eeViewModel.selectedArr[indexPath.section].date
        var index = 0
        
        for (i,item) in deleteIndexes.enumerated() {
            if item.0 == date && item.1 == product {
                index = i
            }
        }
        
        deleteIndexes.remove(at: index)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: reloadDataMovNotification, object: nil)
    }
    
    @objc func refresh() {
        eeViewModel.updateData(from: mm)
        //print("refresh")
        self.tableView.reloadData()
    }
}
