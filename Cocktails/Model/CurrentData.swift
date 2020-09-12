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
    
    static var selectedRows = [IndexPath]()
    
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
