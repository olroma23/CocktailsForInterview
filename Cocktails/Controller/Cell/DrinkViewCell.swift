//
//  DrinkViewCell.swift
//  Cocktails
//
//  Created by Roman Oliinyk on 10.09.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit
import SDWebImage

class DrinkViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CellID"
    
    let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    var stringImageURL: String? {
        didSet {
            guard let stringURL = stringImageURL else { return }
            let url = URL(string: stringURL)
            photoImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 6
        imageView.layer.shadowOpacity = 0.16
        imageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .systemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        self.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor, constant: 30),
            
            photoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            photoImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            photoImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
        ])
        
    }
    
}
