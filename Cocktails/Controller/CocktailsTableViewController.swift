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
    
    var categories: [String]?
    
    private var drinks = [Drink]()
    private var groupedDrinks = [DrinksModelWithType]()
    private var wasLoaded = false
    
    private lazy var filterBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), style: .plain, target: self, action: #selector(filterBarButtonItemPressed))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DrinkViewCell.self, forCellReuseIdentifier: DrinkViewCell.reuseIdentifier)
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let data = CurrentData.currentCategories
        data.forEach { getDrinks(type: $0) }
        print(data)
    }
    
    @objc func filterBarButtonItemPressed() {
        groupedDrinks.removeAll()
        drinks.removeAll()
        navigationController?.pushViewController(FilterTableViewController(), animated: true)
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .secondarySystemBackground
        view.alpha = 0.9
        let label = UILabel(frame: CGRect(x: 30, y: 0, width: tableView.frame.size.width, height: 40))
        label.text = groupedDrinks.count > 0 ? groupedDrinks[section].type.uppercased() : " "
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        
        view.addSubview(label)
        return view
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
