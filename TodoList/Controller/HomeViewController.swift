//
//  ViewController.swift
//  TodoList
//
//  Created by Afiq Ramli on 28/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit
import CoreData


class HomeViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var todoList: [Task] = []
    
    let cellId = "cellID"
    lazy var listTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ListTableViewCell.self, forCellReuseIdentifier: cellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
        listTableView.reloadData()
    }
    
    private func setupNavigationView() {
        
        navigationItem.title = "ToDoList"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodoItem))
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTodoItem))
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = editButton
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
    
    
    @objc private func addTodoItem(_ sender: UIBarButtonItem) {
        let detailController = AddItemViewController()
        detailController.itemDelegate = self
        self.navigationController?.present(detailController, animated: true, completion: nil)
        
    }
    
    @objc private func editTodoItem(_ sender: UIBarButtonItem) {
        
        if self.listTableView.isEditing {
            self.listTableView.isEditing = false
            sender.title = "Edit"
        } else {
            self.listTableView.isEditing = true
            sender.title = "Done"
        }
    }
    
    private func getData() {
        do {
            todoList = try context.fetch(Task.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    //MARK: - Helper methods
    func setMessageLabel(_ messageLabel: UILabel, frame: CGRect, text: String, textColor: UIColor, numberOfLines: Int, textAlignment: NSTextAlignment, font: UIFont) {
        messageLabel.frame = frame
        messageLabel.text = text
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = numberOfLines
        messageLabel.textAlignment = textAlignment
        messageLabel.font = font
        messageLabel.sizeToFit()
        messageLabel.backgroundColor = .white
    }
}


extension HomeViewController: UITableViewDelegate {
    // Editing mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        listTableView.setEditing(editing, animated: true)
    }
    
    // Delete the cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: (indexPath as NSIndexPath).row)
            listTableView.deleteRows(at: [indexPath], with: .automatic)
            
            let task = todoList[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            listTableView.reloadData()
        }
    }
    
    //Move the cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.listTableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todoItem = todoList.remove(at: (sourceIndexPath as NSIndexPath).row)
        todoList.insert(todoItem, at: (destinationIndexPath as NSIndexPath).row)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if todoList.count != 0 {
            
            
            
            return todoList.count
            
        } else {
            
            let messageLabel: UILabel = UILabel()
            
            setMessageLabel(messageLabel, frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), text: "No list is currently available. \n Add a to-do item.", textColor: UIColor.darkGray, numberOfLines: 0, textAlignment: NSTextAlignment.center, font: UIFont(name:"HelveticaNeue", size: 18)!)
            
            self.listTableView.backgroundView = messageLabel
            self.listTableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ListTableViewCell
        cell.todoItem = todoList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension HomeViewController: AddItemDelegate {
    func didAddNewItem(todo: Task) {
        
    }
}









