//
//  AddMovementViewModel.swift
//  Money Management
//
//  Created by Igna on 08/07/2022.
//

import Foundation
import UIKit

fileprivate let cornerRadiusV = 10.0
fileprivate let detailsFontSize = 13.0
fileprivate let labelFontSize = 14.0
fileprivate let textsFontSize = 20.0
fileprivate let lightGrey = UIColor.rgbColor(r: 130, g: 130, b: 130)

final class AddMovementViewModel {
    private let titles = ["Preview","Price","Title","Category","On","Quantity"]
    private let placeHolders = ["Title","Category","x1 (default)"]
    private let validation = DataValidation()
    
    func setUpLabels(_ labels: [UILabel]) {
        for i in 0...labels.count-1 {
            labels[i].text = titles[i]
            labels[i].textColor = .white
            labels[i].font = .systemFont(ofSize: labelFontSize)
        }
    }
    
    func setUpTexts(_ texts: [UITextField]) {
        for i in 0...texts.count-1 {
            let ph = NSAttributedString(string: placeHolders[i], attributes: [.foregroundColor: UIColor.gray])
            texts[i].attributedPlaceholder = ph
            texts[i].textColor = .white
            texts[i].font = .systemFont(ofSize: textsFontSize)
        }
    }
    
    func setUpViews(_ views: [UIView]) {
        for i in 0...views.count-1 {
            views[i].cornerRadius(of: 20.0)
            views[i].backgroundColor = darkBlue
        }
    }
    
    func setUpPreview(viewP: UIView, _ container:UIView, _ catView: UIView, _ lblName: UILabel, _ lblDetail: UILabel, _ lblMoney: UILabel) {
        lblName.font = UIFont.systemFont(ofSize: titleFontSize, weight: .medium)
        
        lblDetail.font = UIFont.systemFont(ofSize: detailsFontSize, weight: .regular)
        lblDetail.textColor = lightGrey
        
        lblMoney.font = UIFont.systemFont(ofSize: moneyFontSize, weight: .medium)
        lblMoney.textColor = moneyRed
        
        catView.cornerRadius(of: cornerRadiusV)
        catView.backgroundColor = UIColor.randomColor()
        
        container.backgroundColor = catView.backgroundColor?.ligthUp(delta: 0.1)
        container.applyBlurEffect(style: .systemThickMaterialLight)
        container.cornerRadius(of: cornerRadiusV)
        
        viewP.shadow = true
        viewP.cornerRadius(of: 15.0)
    }
    
    func setUpBtns(_ saveBtn: UIButton, _ calendarBtn: UIButton) {
        saveBtn.shadow = true
        saveBtn.cornerRadius(of: 25.0)
        saveBtn.backgroundColor = .white
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(customBlue, for: .normal)
    }
    
    func setUpDate(_ lbl: UILabel, _ dp: UIDatePicker) {
        lbl.text = Date.now.comparableDate
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: textsFontSize)
        dp.setValue(UIColor.white, forKeyPath: "textColor")
        dp.setValue(false, forKeyPath: "highlightsToday")
    }
    
    func setUpSegmentedControl(_ seg: UISegmentedControl) {
        seg.setTitle("Expense", forSegmentAt: 0)
        seg.setTitle("Earning", forSegmentAt: 1)
        seg.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        seg.selectedSegmentTintColor = customBlue
        seg.backgroundColor = darkBlue
    }
    
    func createProduct(from titleT: String?,_ priceT: String?,_ catT: String?, _ quantT: String?, _ mov: Movement) throws -> Product {
        try validation.emptyText(titleT)
        try validation.emptyText(priceT)
        
        let title = titleT!
        var price = priceT!
        let cat = catT ?? ""
        var quant = quantT ?? ""
        
        if quant.isEmpty {
            quant = "x1"
        }
        
        price.removeFirst()
        try validation.onlyNumbers(on: price)
        let intPrice = Int(price)!

        quant.removeFirst()
        try validation.onlyNumbers(on: quant)
        let quantInt = Int(quant)!
        
        return Product(name: title, price: intPrice, category: cat, movement: mov, quantity: quantInt)
    }
    
    func updateMoneyLabel(_ lbl: UILabel,_ mov: Movement, _ price: String) {
        if !price.isEmpty {
            lbl.text = (mov == .Expense ? "-" : "+") + price
        }
        lbl.textColor = mov == .Expense ? moneyRed : moneyGreen
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: reloadDataMovNotification, object: nil)
    }
    
}
