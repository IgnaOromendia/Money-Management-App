//
//  DebtsController.swift
//  Money Management
//
//  Created by Igna on 10/07/2022.
//

import UIKit

class DebtsController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var btn_add: UIBarButtonItem!
    @IBOutlet weak var btn_edit: UIBarButtonItem!
    @IBOutlet weak var btn_delete: UIBarButtonItem!
    
    // VARIABLES
    let debtsViewModel = DebtsViewModel(mm)
    var deleteIndexes: Array<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debtsViewModel.setUpTableView(tableView)
        addObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // ACTIONS
    
    @IBAction func editTable(_ sender: UIBarButtonItem) {
        debtsViewModel.setUpEditingStyle(tableView, btn_edit, btn_add, btn_delete)
        deleteIndexes.removeAll()
    }
    
    @IBAction func deleteSelected(_ sender: UIBarButtonItem) {
        debtsViewModel.deleteSelection(deleteIndexes)
        deleteIndexes.removeAll()
        tableView.reloadData()
        debtsViewModel.setUpEditingStyle(tableView, btn_edit, btn_add, btn_delete)
    }
    
    // TABLE VIEW
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return debtsViewModel.cellHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debtsViewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: debtsViewModel.cellID, for: indexPath) as! DebtsCell
        let data = debtsViewModel.getData(for: indexPath.row)
        cell.fillWithData(name: data.name, amount: data.amount, debt: data.type)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DebtsCell
        cell.setSelected(true, animated: true) // cell.isSelected
        
        let data = cell.getData()
        let index = debtsViewModel.getIndex(of: data)
        
        if let index = index {
            deleteIndexes.append(index)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DebtsCell
        cell.setSelected(false, animated: true) // cell.isSelected
        
        let data = cell.getData()
        let index = debtsViewModel.getIndex(of: data)
        
        if let index = index {
            let subindex = deleteIndexes.getIndex(of: index)
            if let subindex = subindex {
                deleteIndexes.remove(at: subindex)
            }
        }
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: reloadDataDebtNotification, object: nil)
    }
    
    @objc func refresh() {
        debtsViewModel.update(from: mm)
        self.tableView.reloadData()
    }
    
}
