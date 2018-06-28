//
//  ViewController.swift
//  TodoList
//
//  Created by Afiq Ramli on 28/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    var todoList: [TodoItem] = []
    
    let cellId = "cellID"
    lazy var listTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .green
        tv.register(ListTableViewCell.self, forCellReuseIdentifier: cellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupView()
    }
    
    private func setupNavigationView() {
        
        navigationItem.title = "ToDoList"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodoItem))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupView() {
        self.view.backgroundColor = .yellow
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(listTableView)
        
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            listTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            listTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            listTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    
    @objc private func addTodoItem() {
        navigationController?.pushViewController(AddItemViewController(), animated: true)
        
        //TODO: - Using delegate pattern to retrieve data from the addItemVC to here.
    }
    
}


extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}










