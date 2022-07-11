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
    
    @IBOutlet weak var lbl_expeseName: UILabel!
    @IBOutlet weak var lbl_details: UILabel!
    @IBOutlet weak var lbl_money: UILabel!
    @IBOutlet weak var view_category: UIView!
    @IBOutlet weak var view_containerCategory: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell(darkMode: traitCollection.userInterfaceStyle == .dark)
    }
    
    private func setUpCell(darkMode: Bool) {
        lbl_expeseName.font = UIFont.systemFont(ofSize: titleFontSize, weight: .medium)
        
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
        lbl_expeseName.text = product.name
        lbl_details.text = product.category + " x\(product.quantity)"
        if product.movement == .Expense {
            lbl_money.text = "-$\(product.price * product.quantity)"
            lbl_money.textColor = moneyRed
        } else {
            lbl_money.text = "+$\(product.price * product.quantity)"
            lbl_money.textColor = moneyGreen
        }
       
    }
    
}
