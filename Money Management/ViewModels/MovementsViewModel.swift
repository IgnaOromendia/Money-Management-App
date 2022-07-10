//
//  MovementsViewModel.swift
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
fileprivate let lightGrey = UIColor.rgbColor(r: 130, g: 130, b: 130)
fileprivate let blue = UIColor.rgbColor(r: 72, g: 129, b: 215)

final class MovementViewModel {
    
    // Day balance view
    private var balance: Int
    private var comp1Text: String
    private var comp1Color: UIColor
    private var comp2Text: String
    private var comp2Color: UIColor
    
    private let today = Date.now.getKeyData()
    private let yesterday = Date.now.yesterday
    private let twoDaysAgo = Date.now.yesterday.advanced(by: -86400)
    
    // Table view
    var sections: Int = 0
    var sectionTitles: Array<String> = []
    var rowsPerSection: Array<Int> = []
    var productsPerDay: Array<ProductsData> = []
    let cellId = "ExpensesCell"
    let cellHeight = 70.0
    
    init(_ m: MoneyManagement) {
        self.balance = 0
        self.comp1Text = ""
        self.comp2Text = ""
        self.comp1Color = UIColor()
        self.comp2Color = UIColor()
        
        calculateValues(with: m)
    }
    
    func updateValues(_ m: MoneyManagement, money: UILabel, comp1: UILabel, comp2: UILabel) {
        calculateValues(with: m)
        
        money.text = balance < 0 ? "-$\(abs(balance))" : "$\(balance)"
        
        comp1.textColor = self.comp1Color
        comp1.text = self.comp1Text
        
        comp2.textColor = self.comp2Color
        comp2.text = self.comp2Text
    }
    
    private func calculateValues(with m: MoneyManagement) {
        let dataY = m.expensesDifferences(between: yesterday, Date.now)
        let dataTwoD = m.expensesDifferences(between: twoDaysAgo, Date.now)
        
        self.balance = m.balance(from: today, to: today)
        self.productsPerDay = m.getAllWeekMovement(today.weekOfMonth!, for: .Both)
        self.sections = productsPerDay.count
        self.rowsPerSection = calculateRowPerSection()
        self.sectionTitles = getSectionTitles()
        
        setUpStringAndColor(with: dataY, text: &comp1Text, color: &comp1Color, day: "yesterday")
        setUpStringAndColor(with: dataTwoD, text: &comp2Text, color: &comp2Color, day: "2 days ago")
    }
    
    func setUpDayBalanceView(containerView:UIView, title:UILabel, money: UILabel, compLabel1: UILabel, compLabel2: UILabel, btn: UIButton) {
        containerView.cornerRadius(of: 20)
        containerView.backgroundColor = .white
        containerView.shadow = true
        
        title.font = UIFont.systemFont(ofSize: fontSizeTitle, weight: .semibold)
        title.text = titleString
         
        money.font = UIFont.systemFont(ofSize: fontSizeMoney, weight: .light)
        money.text = balance < 0 ? "-$\(abs(balance))" : "$\(balance)"
        
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
        let nibCell = UINib(nibName: cellId, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
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
    
    private func setUpStringAndColor(with data: (Bool,Int), text: inout String, color: inout UIColor, day: String) {
        let t = data.0 ?  " more " : " less "
        text = "$\(data.1) spent" + t + "than " + day
        color = data.0 ? lightRed : lightGreen
    }
}
