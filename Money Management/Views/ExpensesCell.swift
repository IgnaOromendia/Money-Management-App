//
//  ExpensesCell.swift
//  Money Management
//
//  Created by Igna on 07/07/2022.
//

import UIKit

fileprivate let cornerRadiusV = 10.0
fileprivate let nameFontSize = 20.0
fileprivate let detailsFontSize = 13.0
fileprivate let moneyFontSize = 18.0
fileprivate let lightGrey = UIColor.rgbColor(r: 130, g: 130, b: 130)
fileprivate let moneyRed = UIColor.rgbColor(r: 255, g: 0, b: 0)

class ExpensesCell: UITableViewCell {
    
    @IBOutlet weak var lbl_expeseName: UILabel!
    @IBOutlet weak var lbl_details: UILabel!
    @IBOutlet weak var lbl_money: UILabel!
    @IBOutlet weak var view_category: UIView!
    @IBOutlet weak var view_containerCategory: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    private func setUpCell() {
        lbl_expeseName.font = UIFont.systemFont(ofSize: nameFontSize, weight: .medium)
        
        lbl_details.font = UIFont.systemFont(ofSize: detailsFontSize, weight: .regular)
        lbl_details.textColor = lightGrey
        
        lbl_money.font = UIFont.systemFont(ofSize: moneyFontSize, weight: .medium)
        lbl_money.textColor = moneyRed
        
        view_category.cornerRadius(of: cornerRadiusV)
        view_category.backgroundColor = UIColor.randomColor()
        
        view_containerCategory.backgroundColor = view_category.backgroundColor?.ligthUp(delta: 0.1)
        view_containerCategory.applyBlurEffect(style: .systemThickMaterialLight) 
        view_containerCategory.cornerRadius(of: cornerRadiusV)
    }
    
    func fillWithData(_ product: Product) {
        lbl_expeseName.text = product.name
        lbl_details.text = product.category + " x\(product.amount)"
        lbl_money.text = "-fileprivate let lightGrey = UIColor.rgbColor(r: 130, g: 130, b: 130)f$\(product.price)"
    }
    
}
