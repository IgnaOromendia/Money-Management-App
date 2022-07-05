//
//  Constants.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

// Types

struct Product: Hashable, Equatable {
    let name: String
    let price: Int
    
}

struct ProductsData: Equatable {
    var products: Set<Product>
    var sum: Int
}

// Alias

typealias Name = String
typealias Category = String

// Enums

enum Movment {
    case Expense
    case Earning
}

// Errors

enum AddErrors: Error {
    case monthError
}
