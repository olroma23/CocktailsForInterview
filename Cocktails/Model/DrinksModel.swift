//
//  DrinksModel.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 10.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation

struct Result: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}

struct Categories: Codable {
    let drinks: [DrinkCategory]
}

struct DrinkCategory: Codable {
    let strCategory: String
}


enum TypeOfCoctail: String, CaseIterable {
    
    case ordinaryDrink = "Ordinary Drink"
    case cocktail = "Cocktail"
    case milkFloatShake = "Milk / Float / Shake"
    case otherUnknown = "Other/Unknown"
    case cocoa = "Cocoa"
    case shot = "Shot"
    case coffeeTea = "Coffee / Tea"
    case homemadeLiqueur = "Homemade Liqueur"
    case punchPartyDrink = "Punch / Party Drink"
    case beer = "Beer"
    case softDrinkSoda = "Soft Drink / Soda"
    
}
