//
//  FilterTableViewController.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 10.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class FilterTableViewController: UIViewController, UITableViewDelegate {
    
    private var categories = [String]()
    private let tableView = UITableView()
    private var applyButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.16
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableViewSetup()
        setupLayout()
        getData()
    }
    
    private func getData()  {
        NetworkDataFetcher.shared.fetchData { [weak self] (category) in
            category?.drinks.forEach {
                self?.categories.append($0.strCategory)
            }
            self?.tableView.reloadData()
        }
    }
    
    private func tableViewSetup() {
        tableView.backgroundColor = .systemBackground
        tableView.allowsMultipleSelection = true
        tableView.register(FilterViewCell.self, forCellReuseIdentifier: FilterViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        self.view.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200),
            
            applyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            applyButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            applyButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
            
        ])
    }
}

// MARK: - Table view data source

extension FilterTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterViewCell.reuseIdentifier, for: indexPath) as! FilterViewCell
        cell.nameLabel.text = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterViewCell
        cell.checkMark.alpha = 0
        cell.backgroundColor = .systemBackground
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterViewCell
        cell.checkMark.alpha = 1
        cell.backgroundColor = .secondarySystemBackground
    }
    
}