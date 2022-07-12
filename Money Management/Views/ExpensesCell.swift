//
//  ExpensesCell.swift
//  Money Management
//
//  Created by Igna on 07/07/2022.
//

import UIKit

fileprivate let cornerRadiusV = 10.0
fileprivate let detailsFontSize = 13.0
fileprivate let lightGrey = UIColor.rgbColor(r: 130, g: 130, b: 130)


class ExpensesCell: UITableViewCell {
    
    @IBOutlet weak var lbl_expenseName: UILabel!
    @IBOutlet weak var lbl_details: UILabel!
    @IBOutlet weak var lbl_money: UILabel!
    @IBOutlet weak var view_category: UIView!
    @IBOutlet weak var view_containerCategory: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell(darkMode: traitCollection.userInterfaceStyle == .dark)
    }
    
    private func setUpCell(darkMode: Bool) {
        self.selectionStyle = .none
        lbl_expenseName.font = UIFont.systemFont(ofSize: titleFontSize, weight: .medium)
        
        lbl_details.font = UIFont.systemFont(ofSize: detailsFontSize, weight: .regular)
        lbl_details.textColor = lightGrey
        
        lbl_money.font = UIFont.systemFont(ofSize: moneyFontSize, weight: .medium)
        
        view_category.cornerRadius(of: cornerRadiusV)
        view_category.backgroundColor = UIColor.randomColor()
        
        let delta = darkMode ? -0.1 : 0.1
        let blurEffect: UIBlurEffect.Style = darkMode ? .systemThickMaterialDark : .systemThickMaterialLight
        
        view_containerCategory.backgroundColor = view_category.backgroundColor?.ligthUp(delta: delta)
        view_containerCategory.applyBlurEffect(style: blurEffect)
        view_containerCategory.cornerRadius(of: cornerRadiusV)
    }
    
    func fillWithData(_ product: Product) {
        lbl_expenseName.text = product.name
        lbl_details.text = product.category + " x\(product.quantity)"
        if product.movement == .Expense {
            lbl_money.text = "-$\(product.price * product.quantity)"
            lbl_money.textColor = moneyRed
        } else {
            lbl_money.text = "+$\(product.price * product.quantity)"
            lbl_money.textColor = moneyGreen
        }
    }
    
    func getData() -> Product {
        var price = lbl_money.text!
        let mov: Movement = lbl_money.textColor == moneyRed ? .Expense : .Earning
        let details = lbl_details.text!
        var cat = String()
        var quant = String()
        let arr = details.split(separator: " ")
        if arr.count > 1 {
            cat = String(arr[0])
            quant = String(arr[1])
        } else {
            quant = String(arr[0])
        }
        
        quant.removeFirst()
        price.removeFirst()
        price.removeFirst()
        
        let priceInt = Int(price)!
        let quantInt = Int(quant)!
        
        return Product(name: lbl_expenseName.text!, price:  priceInt / quantInt , category: cat, movement: mov, quantity: quantInt )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let imageSelected = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageSelected.image = UIImage(systemName: "checkmark.circle.fill")
        self.accessoryView = selected ? imageSelected : nil
        super.setSelected(selected, animated: animated)
    }
    
}
