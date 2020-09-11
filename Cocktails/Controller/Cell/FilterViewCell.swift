//
//  FilterViewCell.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 11.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class FilterViewCell: UITableViewCell {

    static let reuseIdentifier = "CellID"
    
    var nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        return lbl
    }()
    
     var checkMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        imageView.alpha = 1
        return imageView
    }()
    
    var cellIsSelected: Bool? {
        didSet {
            if cellIsSelected! {
                self.backgroundColor = .systemBackground
                checkMark.alpha = 0
            } else {
                checkMark.alpha = 1
                self.backgroundColor = .secondarySystemBackground

            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .secondarySystemBackground
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        self.addSubview(checkMark)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -8),
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            
            checkMark.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -7),
            checkMark.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
}
