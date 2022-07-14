//
//  Automation-Model.swift
//  Money Management
//
//  Created by Igna on 14/07/2022.
//

import Foundation

class Automation: Codable, Equatable {
    private var product: Product
    private var repats: Repetitions
    private let staringDate: Date
    private var endDate: Date?
    private var lastApplied: Date
    
    init(product: Product, repeats: Repetitions, staringDate: Date = Date.now, endDate: Date? = nil, lastApplied: Date = Date.now) {
        self.product = product
        self.repats = repeats
        self.endDate = endDate
        self.staringDate = staringDate
        self.lastApplied = lastApplied
    }
    
    static func == (lhs: Automation, rhs: Automation) -> Bool {
        return lhs.product == rhs.product && lhs.repats == rhs.repats && lhs.staringDate == rhs.staringDate && lhs.endDate == rhs.endDate
    }
    
    // Get
    
    /// Get the product
    func getProduct() -> Product {
        return self.product
    }
    
    /// Get repetitions
    func getRepetitions() -> Repetitions {
        return self.repats
    }
    
    /// Get starting date
    func getStartingDate() -> Date {
        return self.staringDate
    }
    
    /// Get ending date
    func getEndingDate() -> Date? {
        return self.endDate
    }
    
    func getLastApplied() -> Date {
        return self.lastApplied
    }
    
    // Set
    
    /// Edit the produt
    func updateProduct(with p: Product) {
        self.product = p
    }
    
    /// Change repetitions
    func updateRepetitions(with r: Repetitions) {
        self.repats = r
    }
    
    /// Change ending date
    func updateEndDate(with d: Date) {
        self.endDate = d
    }
    
    /// Set to nil ending date
    func removeEndDate() {
        self.endDate = nil
    }
    
    /// Update Last Applied date
    func updateLastApplied(with d: Date = Date.now) {
        self.lastApplied = d
    }
    
}
