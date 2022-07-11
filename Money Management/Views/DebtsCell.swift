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
        self.selectionStyle = .none
    }
    
    func fillWithData(name: String, amount: Int, debt: DebtType) {
        lbl_name.text = name
        lbl_money.text = "$\(amount)"
        lbl_money.textColor = debt == .Debt ? moneyRed : moneyGreen
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let imageSelected = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageSelected.image = UIImage(systemName: "checkmark.circle.fill")
        self.accessoryView = selected ? imageSelected : nil
        super.setSelected(selected, animated: animated)
    }
    
    func getData() -> DebtData {
        let type: DebtType = lbl_money.textColor == moneyRed ? .Debt : .Debtor
        var price = lbl_money.text!
        price.removeFirst()
        let priceInt = Int(price)!
        return DebtData(name: lbl_name.text!, amount: priceInt, type: type)
    }
    
}
