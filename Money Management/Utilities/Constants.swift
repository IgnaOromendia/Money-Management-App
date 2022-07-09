//
//  Constants.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation
import UIKit

// MARK: - CONSTANTS

// IDs
let movementControllerID = "MovmentControllerID"
let addMovementControllerID = "AddMovementControllerID"

// Colors
let customBlue = UIColor.rgbColor(r: 72, g: 129, b: 215)
let moneyRed = UIColor.rgbColor(r: 255, g: 0, b: 0)
let moneyGreen = UIColor.rgbColor(r: 104, g: 154, b: 64)

// MARK: - ALIAS

typealias Name = String
typealias Category = String
typealias UITableViewControllerMethods = UITableViewDelegate & UITableViewDataSource
typealias UISearchBarMethods =  UISearchResultsUpdating & UISearchBarDelegate

// MARK: - ENUM

enum Movment {
    case Expense
    case Earning
    case Both
}

//  MARK: - ERRORS

enum AddErrors: LocalizedError {
    case monthError
}
