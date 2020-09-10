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


