//
//  MovmentsViewModel.swift
//  Money Management
//
//  Created by Igna on 06/07/2022.
//

import Foundation
import UIKit

// Day balance view
fileprivate let titleString = "Day Balance"
fileprivate let fontSizeTitle = 24.0
fileprivate let fontSizeMoney = 36.0
fileprivate let fontSizeComp = 16.0
fileprivate let lightGreen = UIColor.rgbColor(r: 158, g: 191, b: 131)
fileprivate let lightRed = UIColor.rgbColor(r: 255, g: 139, b: 139)
fileprivate let blue = UIColor.rgbColor(r: 72, g: 129, b: 215)

final class MovmentViewModel {
    
    // Day balance view
    private var balance: Int
    private var comp1Text: String
    private var comp1Color: UIColor
    private var comp2Text: String
    private var comp2Color: UIColor
    
    // Table view
    var sections: Int
    var sectionTitles: Array<String> = []
    var rowsPerSection: Array<Int> = []
    var productsPerDay: Array<ProductsData>
    let cellId = "ExpensesCell"
    let cellHeight = 70.0
    
    init(_ m: MoneyManagement) {
        let today = Date.now.getKeyData()
        let yesterday = Date.now.yesterday
        let twoDaysAgo = Date.now.yesterday.advanced(by: -86400)
        let expensesT = m.dateExpenses(on: Date.now)?.sum ?? 0
        let expensesY = m.dateExpenses(on: yesterday)?.sum ?? 0
        let expensesTwoD = m.dateExpenses(on: twoDaysAgo)?.sum ?? 0
        
        let dataY: (Bool,Int) = (expensesY < expensesT , (expensesY - expensesT))             // true = more
        let dataTwoD: (Bool,Int) = (expensesTwoD < expensesT , abs(expensesTwoD - expensesT)) // false = less
        
        var t = dataY.0 ?  " more " : " less "
        self.comp1Text = "$\(dataY.1) spent" + t + "than yesterday"
        self.comp1Color = dataY.0 ? lightRed : lightGreen
        
        t = dataTwoD.0 ?  " more " : " less "
        self.comp2Text = "$\(dataTwoD.1) spent" + t + "than 2 days ago"
        self.comp2Color = dataTwoD.0 ? lightRed : lightGreen
        
        self.balance = m.balance(from: today, to: today)
        self.productsPerDay = m.getAllWeekMovment(today.weekOfMonth!, for: .Expense)
        self.sections = productsPerDay.count
        self.rowsPerSection = calculateRowPerSection()
        self.sectionTitles = getSectionTitles()
    }
    
    func setUpDayBalanceView(containerView:UIView, title:UILabel, money: UILabel, compLabel1: UILabel, compLabel2: UILabel, btn: UIButton) {
        containerView.cornerRadius(of: 20)
        containerView.backgroundColor = .white
        containerView.shadow = true
        
        title.font = UIFont.systemFont(ofSize: fontSizeTitle, weight: .semibold)
        title.text = titleString
        
        money.font = UIFont.systemFont(ofSize: fontSizeMoney, weight: .light)
        money.text = "$\(balance)"
        
        compLabel1.font = UIFont.systemFont(ofSize: fontSizeComp)
        compLabel1.textColor = self.comp1Color
        compLabel1.text = self.comp1Text
        
        compLabel2.font = UIFont.systemFont(ofSize: fontSizeComp)
        compLabel2.textColor = self.comp2Color
        compLabel2.text = self.comp2Text
        
        btn.clipsToBounds = true
        btn.cornerRadius(of: btn.frame.size.height / 2)
        btn.backgroundColor = blue
    }
    
    func setUpTableView(_ tableView: UITableView) {
        let nib = UINib(nibName: cellId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    private func getSectionTitles() -> Array<String> {
        var result: Array<String> = []
        var date = Date.now
        for _ in 0...self.productsPerDay.count {
            result.append(date.prettyDate)
            date.stepBackOneDay()
        }
        return result
    }
    
    private func calculateRowPerSection() -> Array<Int> {
        var result = Array(repeating: 0, count: 7)
        for (i,item) in self.productsPerDay.enumerated() {
            result[i] = item.products.count
        }
        return result
    }
    
    
}
