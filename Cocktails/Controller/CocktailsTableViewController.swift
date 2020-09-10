//
//  CocktailsTableViewController.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 10.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

struct DrinksModelWithType {
    
    let drinks: [Drink]
    let type: String
}

class CocktailsTableViewController: UITableViewController {
    
    private var drinks = [Drink]()
    private var groupedDrinks = [DrinksModelWithType]()
    
    private lazy var filterBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), style: .plain, target: self, action: #selector(filterBarButtonItemPressed))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DrinkViewCell.self, forCellReuseIdentifier: DrinkViewCell.reuseIdentifier)
        
        setupNavigationBar()
        
        getDrinks(type: "Ordinary Drink")
    }
    
    
    @objc func filterBarButtonItemPressed() {
        
    }
    
    private func getDrinks(type: String) {
        NetworkDataFetcher.shared.fetchData(type: type) { [weak self] (results) in
            guard let results = results else { return }
            self?.drinks = results.drinks
            
            let groupedDrink = DrinksModelWithType(drinks: results.drinks, type: type)
            self?.groupedDrinks.append(groupedDrink)
            
            self?.tableView.reloadData()
        }
    }
    
    
    private func setupNavigationBar() {
        tableView.backgroundColor = .systemBackground
        let titleLabel = UILabel()
        titleLabel.text = "DRINKS"
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .secondaryLabel
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItem = filterBarButtonItem
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedDrinks.count > 0 ? groupedDrinks[section].type : " "
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedDrinks.count > 0 ? groupedDrinks.count : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groupedDrinks.count > 0 {
            return groupedDrinks[section].drinks.count
        }
        return drinks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinkViewCell.reuseIdentifier, for: indexPath) as! DrinkViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.nameLabel.text = groupedDrinks[indexPath.section].drinks[indexPath.row].strDrink
        cell.stringImageURL = groupedDrinks[indexPath.section].drinks[indexPath.row].strDrinkThumb
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
