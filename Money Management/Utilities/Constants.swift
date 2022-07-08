//
//  Constants.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation
import UIKit

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
