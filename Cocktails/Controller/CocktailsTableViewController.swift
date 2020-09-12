//
//  CocktailsTableViewController.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 10.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class CocktailsTableViewController: UITableViewController {
    
    private var categoriesForPagination = [String]()
    private var drinks = [Drink]()
    private var groupedDrinks = [DrinksModelWithType]()
    private var wasLoaded = false
    private var lastCategory = String()
    
    private lazy var filterBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), style: .plain, target: self, action: #selector(filterBarButtonItemPressed))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CocktailViewCell.self, forCellReuseIdentifier: CocktailViewCell.reuseIdentifier)
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        let currentCategories = CurrentData.currentCategories
        if !currentCategories.isEmpty {
            lastCategory = currentCategories.last!
        }
        
        for currentCategory in currentCategories {
            categoriesForPagination.append(currentCategory)
            getDrinks(type: currentCategory)
            break
        }
        wasLoaded = false
    }
    
    @objc func filterBarButtonItemPressed() {
        groupedDrinks.removeAll()
        drinks.removeAll()
        categoriesForPagination.removeAll()
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
    
    private func getNumberOfRowsInSection(section: Int) -> Int {
        if groupedDrinks.count > 0 {
            return groupedDrinks[section].drinks.count
        }
        return drinks.count
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if groupedDrinks.count > 0 {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
            view.backgroundColor = .secondarySystemBackground
            view.alpha = 0.9
            let label = UILabel(frame: CGRect(x: 30, y: 0, width: tableView.frame.size.width, height: 40))
            label.text = groupedDrinks[section].type.uppercased()
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = .secondaryLabel
            
            view.addSubview(label)
            return view
        } else {
            let view = UIView()
            return view
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailViewCell.reuseIdentifier, for: indexPath) as! CocktailViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if groupedDrinks.count > 0 {
            cell.nameLabel.text = groupedDrinks[indexPath.section].drinks[indexPath.row].strDrink
            cell.stringImageURL = groupedDrinks[indexPath.section].drinks[indexPath.row].strDrinkThumb
        }
        
        pagination(indexPath: indexPath, tableView: tableView)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}




// MARK: - Pagination

extension CocktailsTableViewController {
    
    private func pagination(indexPath: IndexPath, tableView: UITableView) {
        let lastRow = tableView.numberOfRows(inSection: indexPath.section) - 1
        let currentCategories = CurrentData.currentCategories
        
        if IndexPath(row: lastRow, section: indexPath.section) == tableView.indexPathsForVisibleRows?.last {
            for currentCategory in currentCategories {
                if currentCategories[indexPath.section] == lastCategory {
                    if !wasLoaded {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.showAlert(title: "The end", message: "Subscribe to see more - 5.99 / week")
                        }
                        wasLoaded = true
                    }
                    break
                } else if categoriesForPagination.contains(currentCategory) {
                    continue
                }  else {
                    self.categoriesForPagination.append(currentCategory)
                    self.getDrinks(type: currentCategory)
                    break
                }
            }
        } else if IndexPath(row: 1, section: indexPath.section) == tableView.indexPathsForVisibleRows?.first {
            wasLoaded = false
        }
    }
    
    private func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        ac.addAction(okAction)
        present(ac, animated: true)
    }
    
}
