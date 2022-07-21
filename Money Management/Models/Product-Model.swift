//
//  Product-Model.swift
//  Money Management
//
//  Created by Igna on 13/07/2022.
//

import Foundation

class Product: Hashable, Equatable, CustomStringConvertible, Codable {
    let name: Name
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
    
    init(name: Name, price: Int, category: Category, movement: Movement, quantity: Int) {
        self.name = name
        self.price = price
        self.category = category
        self.movement = movement
        self.quantity = quantity
    }

    convenience init() {
        self.init(name: "No-name", price: 0, category: "No-cat", movement: .Expense, quantity: 1)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price && lhs.category == rhs.category
    }
    
    static func != (lhs: Product, rhs: Product) -> Bool {
        return lhs.name != rhs.name || lhs.price != rhs.price || lhs.category != rhs.category
    }
    
    func incrmentQuantity(by value: Int) {
        self.quantity += value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(price)
        hasher.combine(category)
        hasher.combine(movement)
        hasher.combine(quantity)
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
