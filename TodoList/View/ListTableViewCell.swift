//
//  ListTableViewCell.swift
//  TodoList
//
//  Created by Afiq Ramli on 28/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "To do Title here or anything"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
            ])
    }
    
}
