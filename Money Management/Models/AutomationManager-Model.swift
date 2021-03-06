//
//  Automation-Model.swift
//  Money Management
//
//  Created by Igna on 14/07/2022.
//

import Foundation

class AutomationManager: Codable {
    private var automations: Array<Automation>
    private var repetitions: Dictionary<Repetitions,Array<Int>> // The value is the index of the element
    
    init(automations: Array<Automation>) {
        self.automations = automations
        self.repetitions = [:]
        self.repetitions = updateIndexes(with: automations)
    }
    
    convenience init() {
        self.init(automations: [])
    }
    
    private func updateIndexes(with arr: Array<Automation>) -> Dictionary<Repetitions,Array<Int>> {
        var result: Dictionary<Repetitions,[Int]> = [:]
        for (i,item) in arr.enumerated() {
            if result[item.getRepetitions()] == nil {
                result.updateValue([i], forKey: item.getRepetitions())
            } else {
                result[item.getRepetitions()]!.append(i)
            }
        }
        return result
    }
    
    // Get
    
    /// Get an array of automations
    func getAutomations() -> Array<Automation> {
        return self.automations
    }
    
    /// Get a dictionary of index of automations depending on the date
    func getRepetitions() -> Dictionary<Repetitions,Array<Int>> {
        return self.repetitions
    }
    
    // Set
    
    /// Add automation
    func addAutomation(_ auto:Automation) {
        automations.append(auto)
        if repetitions[auto.getRepetitions()] == nil {
            repetitions.updateValue([automations.endIndex - 1], forKey: auto.getRepetitions())
        } else {
            repetitions[auto.getRepetitions()]!.append(automations.endIndex - 1)
        }
    }
    
    // Remove
    
    /// Removes the given automation
    func removeAutomation(_ auto: Automation) {
        let index = automations.getIndex(of: auto)
        if let index = index {
            self.automations.remove(at: index)
            let subindex = self.repetitions[auto.getRepetitions()]!.getIndex(of: index)!
            self.repetitions[auto.getRepetitions()]?.remove(at: subindex)
        }
        self.repetitions = updateIndexes(with: self.automations)
    }
    
    /// Checks if any automation has passed his endingDate
    func checkEndingDates() {
        for item in self.automations {
            if item.getEndingDate() != nil {
                if item.getEndingDate()! < Date.now {
                    removeAutomation(item)
                }
            }
        }
    }
    
    /// Apply the products corresoponding to today's date
    func applyTodayProducts(to m: MoneyManagement) {
        let products = productsToApply()
        for product in products {
            switch product.movement {
            case .Earning:
                m.addEarnings(product: product, on: Date.now)
            case .Expense:
                m.addExpenses(product: product, on: Date.now)
            default:
                print("Error")
            }
        }
    }
    
    private func productsToApply() -> Array<Product> {
        var result: Array<Product> = []
        for auto in self.automations {
            if checkLastApplicationDate(auto.getLastApplied(),auto.getRepetitions()) {
                result.append(auto.getProduct())
                auto.updateLastApplied()
            }
        }
        return result
    }
    
    private func checkLastApplicationDate(_ last: Date, _ rep: Repetitions) -> Bool {
        switch rep {
        case .EveryDay:
            return -last.timeIntervalSinceNow > 86400
        case .Weekly:
            return -last.timeIntervalSinceNow > 604800
        case .EveryTwoWeeks:
            return -last.timeIntervalSinceNow > 1209600
        case .Monthly:
            return -last.timeIntervalSinceNow > 2628001
        case .EveryThreeMonths:
            return -last.timeIntervalSinceNow > 78884003
        case .EverySixMonths:
            return -last.timeIntervalSinceNow > 15768006
        case .EveryYear:
            return -last.timeIntervalSinceNow > 31536013
        }
    }
    
}
