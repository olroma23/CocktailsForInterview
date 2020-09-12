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
    
    private var categoriesForPagination = [String]()
    private var drinks = [Drink]()
    private var groupedDrinks = [DrinksModelWithType]()
    private var wasLoaded = false
    
    private lazy var filterBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), style: .plain, target: self, action: #selector(filterBarButtonItemPressed))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CocktailViewCell.self, forCellReuseIdentifier: CocktailViewCell.reuseIdentifier)
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentCategories = CurrentData.currentCategories
        
        for currentCategory in currentCategories {
            categoriesForPagination.append(currentCategory)
            getDrinks(type: currentCategory)
            break
        }
    }
    
    @objc func filterBarButtonItemPressed() {
        groupedDrinks.removeAll()
        drinks.removeAll()
        categoriesForPagination.removeAll()
        navigationController?.pushViewController(FilterTableViewController(), animated: true)
    }
    
    private func getDrinks(type: String, isLoading: Bool = false) {
        DispatchQueue.global().asyncAfter(deadline: isLoading ? .now() + 4 : .now()) {
            NetworkDataFetcher.shared.fetchData(type: type) { [weak self] (results) in
                guard let results = results else { return }
                self?.drinks = results.drinks
                
                let groupedDrink = DrinksModelWithType(drinks: results.drinks, type: type)
                self?.groupedDrinks.append(groupedDrink)
                self?.tableView.reloadData()
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailViewCell.reuseIdentifier, for: indexPath) as! CocktailViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.nameLabel.text = groupedDrinks[indexPath.section].drinks[indexPath.row].strDrink
        cell.stringImageURL = groupedDrinks[indexPath.section].drinks[indexPath.row].strDrinkThumb
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - scrollView.frame.size.height) {
            
            self.tableView.tableFooterView =  createSpinnerFooter()
            let currentCategories = CurrentData.currentCategories
            
            for currentCategory in currentCategories {
                if categoriesForPagination.contains(currentCategory) {
                    continue
                } else {
                    categoriesForPagination.append(currentCategory)
                    getDrinks(type: currentCategory, isLoading: true)
                    DispatchQueue.main.async {
                        self.tableView.tableFooterView = nil
                    }
                    break
                }
                
            }
            
        }
    }
}





// MARK: - Funcs for pagination ui

extension CocktailsTableViewController {
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    private func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        ac.addAction(okAction)
        present(ac, animated: true)
    }
}
