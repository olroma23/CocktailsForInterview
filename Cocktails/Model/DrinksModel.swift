//
//  DrinksModel.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 10.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation

// Model for cocktails fetching

struct Result: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}

// Model for categories fetching

struct Categories: Codable {
    let drinks: [DrinkCategory]
}

struct DrinkCategory: Codable {
    let strCategory: String
}


// Model for section and rows presentation
struct DrinksModelWithType {
    let drinks: [Drink]
    let type: String
}
