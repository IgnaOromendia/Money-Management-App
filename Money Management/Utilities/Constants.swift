//
//  Constants.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation
import UIKit

// MARK: - CONSTANTS

// File name
let jsonFileName = "MoneyManagementData.json"

// IDs
let movementControllerID = "MovementControllerID"
let addMovementControllerID = "AddMovementControllerID"
let debtControllerID = "DebtControllerID"
let eeControllerID = "EeControllerID"

// Colors
let customBlue = UIColor.rgbColor(r: 72, g: 129, b: 215)
let moneyRed = UIColor.rgbColor(r: 255, g: 0, b: 0)
let moneyGreen = UIColor.rgbColor(r: 104, g: 154, b: 64)
let darkBlue = UIColor.rgbColor(r: 61, g: 108, b: 177)

// Fonts
let moneyFontSize = 18.0
let titleFontSize = 20.0

// Notifications
let reloadDataDebtNotification = Notification.Name("reloadDataDebt")
let reloadDataMovNotification = Notification.Name("reloadDataMov")

// MARK: - ALIAS

typealias Name = String
typealias Category = String
typealias UITableViewControllerMethods = UITableViewDelegate & UITableViewDataSource
typealias UISearchBarMethods =  UISearchResultsUpdating & UISearchBarDelegate

// MARK: - ENUM

enum Movement: Codable {
    case Expense
    case Earning
    case Both
}

enum DebtType: Codable {
    case Debt
    case Debtor
}

//  MARK: - ERRORS

enum AddErrors: LocalizedError {
    case monthError
}
