//
//  Constants.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

struct Product: Hashable {
    let name: String
    let price: Int
}

typealias DayData = (list: Set<Product>, total: Int)
typealias Name = String
typealias Category = String
