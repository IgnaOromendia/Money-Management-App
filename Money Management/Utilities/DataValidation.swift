//
//  DataValidation.swift
//  Money Management
//
//  Created by Igna on 09/07/2022.
//

import Foundation

enum ValidationErrors: LocalizedError {
    case notNumberChar
    case futureDate
    case emptyText
    case nilText
}

class DataValidation {
    
    /// Verifies if in the given sentece there is only numbers
    func onlyNumbers(on sentence: String) throws {
        for char in sentence {
            if !char.isNumber {
                throw ValidationErrors.notNumberChar
            }
        }
    }
    
    /// Verifies that the given date isn't from the fututre
    func futureDate(_ date: Date) throws {
        guard date < Date.now else { throw ValidationErrors.futureDate }
    }
    
    /// Verifies if the given string is empty or no
    func emptyText(_ item: String?) throws {
        if let item = item {
            guard !item.isEmpty else { throw ValidationErrors.emptyText }
        } else {
            throw ValidationErrors.nilText
        }
    }
    
    
    
}
