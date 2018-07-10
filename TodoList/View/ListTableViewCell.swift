//
//  ListTableViewCell.swift
//  TodoList
//
//  Created by Afiq Ramli on 28/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    var todoItem: Task? {
        didSet {
            if let title = todoItem?.title {
                titleLabel.text = title
            }
            
            if let category = todoItem?.category {
                
                switch category {
                case "work":
                    categoryColorDot.backgroundColor = .red
                case "private":
                    categoryColorDot.backgroundColor = .blue
                default:
                    categoryColorDot.backgroundColor = .black
                }
                
            }
        }
    }
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let categoryColorDot: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "To do Title here or anything"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
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
        self.addSubview(categoryColorDot)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            categoryColorDot.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryColorDot.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            categoryColorDot.heightAnchor.constraint(equalToConstant: 10),
            categoryColorDot.widthAnchor.constraint(equalToConstant: 10)
            ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: categoryColorDot.rightAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
            ])
    }
    
}
