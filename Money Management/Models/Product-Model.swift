//
//  Product-Model.swift
//  Money Management
//
//  Created by Igna on 13/07/2022.
//

import Foundation

struct Product: Hashable, Equatable, CustomStringConvertible, Codable {
    let name: String
    let price: Int
    let category: Category
    let movement: Movement
    var quantity: Int
    
    var description: String {
        return """
        \nName: \(name)
        Price: $\(price)
        Category: \(category)
        Movement: \(movement)
        quantity: x\(quantity)
        """
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price && lhs.category == rhs.category
    }
    
    mutating func incrmentQuantity(by value: Int) {
        self.quantity += value
    }
}

struct ProductsData: Equatable, CustomStringConvertible, Codable {
    var products: Set<Product>
    var sum: Int
    let date: DateComponents
    
    var description: String {
        return """
        prod: \(products)
        sum: \(sum)
        date: \(date)
        """
    }
}
