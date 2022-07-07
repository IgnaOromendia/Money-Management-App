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
typealias UITableViewController_D_DS = UITableViewDelegate & UITableViewDataSource

// MARK: - ENUM

enum Movment {
    case Expense
    case Earning
}

//  MARK: - ERRORS

enum AddErrors: LocalizedError {
    case monthError
}
