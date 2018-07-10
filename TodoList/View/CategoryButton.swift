//
//  CategoryButton.swift
//  TodoList
//
//  Created by Afiq Ramli on 28/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit

class CategoryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createBtn(title: String, bgColor: UIColor) -> UIButton{
        let btn = UIButton(type: .system)
        btn.backgroundColor = bgColor
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(CategoryButton.self, action: #selector(categorySelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    @objc func categorySelected() {
        print("Button Pressed")
    }
}
