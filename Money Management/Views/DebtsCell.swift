//
//  DebtsCell.swift
//  Money Management
//
//  Created by Igna on 10/07/2022.
//

import UIKit

class DebtsCell: UITableViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_money: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    private func setUp() {
        lbl_name.font = UIFont.systemFont(ofSize: titleFontSize, weight: .medium)
        lbl_money.font = UIFont.systemFont(ofSize: moneyFontSize, weight: .medium)
    }
    
    func fillWithData(name: String, amount: Int, debt: DebtType) {
        lbl_name.text = name
        lbl_money.text = "$\(amount)"
        lbl_money.textColor = debt == .Debt ? moneyRed : moneyGreen
    }
    
}
