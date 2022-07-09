//
//  Global.swift
//  Money Management
//
//  Created by Igna on 04/07/2022.
//

import Foundation

// TO DO LIST
// Empezar con la interfaz
// Elegir entre gasto y ganancia
// Hacer lo de poder elegir la fecha


// TEST's begins
var expenses1 = ProductsData(products: [Product(name: "Coca", price: 100, category: "Bebida", movement: .Expense, quantity: 1),
                                        Product(name: "Hielo", price: 50, category: "Otros", movement: .Expense, quantity: 2)], sum: 150)

var expenses2 = ProductsData(products: [Product(name: "Coca", price: 100, category: "Bebida", movement: .Expense, quantity: 1),], sum: 100)

var expenses3 = ProductsData(products: [Product(name: "Mila", price: 600, category: "Comida", movement: .Expense, quantity: 1),], sum: 600)

var earnings = ProductsData(products: [Product(name: "Robo", price: 500, category: "Otros", movement: .Earning, quantity: 1)], sum: 500)

let date = Date().getKeyData()
let dateY = Date().yesterday.getKeyData()
let dateTwoD = Date.now.yesterday.advanced(by: -86400).getKeyData()
let mm = MoneyManagement(expenses: [date:expenses2, dateY:expenses1, dateTwoD:expenses3],
                         earnings: [date:earnings],
                         debts: [:],
                         debtors: [:],
                         categories: [])
// END of TEST coca, hielo-coca, mila
