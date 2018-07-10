//
//  Todo.swift
//  TodoList
//
//  Created by Afiq Ramli on 28/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import Foundation

class TodoItem: NSObject{
    
    var id: String
    var title: String
    var detail: String?
//    var date: Date
    var category: String
    var isChecked: Bool = false
    
    init(id: String, title: String, detail: String?, category: String) {
        self.id = id
        self.title = title
        self.detail = detail
//        self.date = date
        self.category = category
    }
    
}
