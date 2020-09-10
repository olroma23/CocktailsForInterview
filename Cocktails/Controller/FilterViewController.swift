//
//  FilterViewController.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 10.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

enum TypeOfCoctail: String {
    
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

class FilterViewController: UIViewController {
    
    var categories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkDataFetcher.shared.fetchData(url: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list") { (category) in
            category!.drinks.forEach { self.categories.append($0.strCategory) }
            print(self.categories)
        }
        
        
    }
    
}
