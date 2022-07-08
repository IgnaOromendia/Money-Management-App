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

// MARK: - ALIAS

typealias Name = String
typealias Category = String
typealias UITableViewControllerMethods = UITableViewDelegate & UITableViewDataSource
typealias UISearchBarMethods =  UISearchResultsUpdating & UISearchBarDelegate

// MARK: - ENUM

enum Movment {
    case Expense
    case Earning
}

//  MARK: - ERRORS

enum AddErrors: LocalizedError {
    case monthError
}
