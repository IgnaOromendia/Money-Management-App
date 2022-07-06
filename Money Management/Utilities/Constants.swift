//
//  Constants.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

// MARK: - ALIAS

typealias Name = String
typealias Category = String

// MARK: - ENUM

enum Movment {
    case Expense
    case Earning
}

//  MARK: - ERRORS

enum AddErrors: LocalizedError {
    case monthError
}
