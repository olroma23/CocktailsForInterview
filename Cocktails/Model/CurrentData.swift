//
//  CurrentData.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 11.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation


class CurrentData {
    
    static var currentCategories = ["Ordinary Drink", "Cocktail", "Milk / Float / Shake", "Other/Unknown", "Cocoa", "Shot", "Coffee / Tea", "Homemade Liqueur", "Punch / Party Drink", "Beer", "Soft Drink / Soda"]
    
    static var selectedRows = [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0), IndexPath(row: 3, section: 0), IndexPath(row: 4, section: 0), IndexPath(row: 5, section: 0), IndexPath(row: 6, section: 0), IndexPath(row: 7, section: 0), IndexPath(row: 8, section: 0), IndexPath(row: 9, section: 0), IndexPath(row: 10, section: 0)]
    
//    static func getCategories(completion: @escaping ([String]) -> () ) {
//        var cat = [String]()
//        NetworkDataFetcher.shared.fetchData { (category) in
//            category?.drinks.forEach {
//                cat.append($0.strCategory)
//            }
//            completion(cat)
//        }
//    }
}
