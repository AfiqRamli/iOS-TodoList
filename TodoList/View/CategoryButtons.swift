//
//  CategoryButtons.swift
//  TodoList
//
//  Created by Afiq Ramli on 02/07/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit

class CategoryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        self.setTitle("Button", for: .normal)
        self.addTarget(self, action: #selector(onBtnPressed), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onBtnPressed() {
        print("button pressed!")
    }
    
}

class CustomButton: UIButton {
    
    override public var isHighlighted: Bool {
        didSet {
            /* To get rid of the tint background */
            self.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.0)
        }
    }
    
}
