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
    
    private let balance: Int
    private let comp1Text: String
    private let comp1Color: UIColor
    private let comp2Text: String
    private let comp2Color: UIColor
    
    init(_ m: MoneyManagement) {
        let today = Date.now.getKeyData()
        self.balance = m.balance(from: today, to: today)
        let dataY = MovmentViewModel.compareToYesterday(m: m)
        let dataTwoD = MovmentViewModel.compareTo2DaysAgo(m: m)
        
        var t = dataY.0 ?  " more " : " less "
        self.comp1Text = "$\(dataY.1)" + t + "yesterday"
        self.comp1Color = dataY.0 ? lightGreen : lightRed
        
        t = dataTwoD.0 ?  " more " : " less "
        self.comp2Text = "$\(dataTwoD.1)" + t + "than 2 days ago"
        self.comp2Color = dataTwoD.0 ? lightGreen : lightRed
        
    }
    
    
    func setUpDayBalanceView(containerView:UIView, title:UILabel, money: UILabel, compLabel1: UILabel, compLabel2: UILabel, btn: UIButton) {
        containerView.cornerRadius(of: 20)
        containerView.backgroundColor = .white
        
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
    
    // False = less , true = more
    private static func compareToYesterday(m: MoneyManagement) -> (Bool,Int) {
        return (false,0)
    }
    
    private static func compareTo2DaysAgo(m: MoneyManagement) -> (Bool,Int) {
        return (false,0)
    }
}
