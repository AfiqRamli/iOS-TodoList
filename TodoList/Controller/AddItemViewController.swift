//
//  AddItemViewController.swift
//  TodoList
//
//  Created by Afiq Ramli on 28/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit
import CoreData

protocol AddItemDelegate: class {
    
    func didAddNewItem(todo: Task)
}

class AddItemViewController: UIViewController {
    
    //MARK: - UI Components
    
    lazy var navBar: UINavigationBar = {
        let nb = UINavigationBar()
        let navItem = UINavigationItem(title: "NEW TASK")
        navItem.rightBarButtonItem = doneButton
        navItem.leftBarButtonItem = cancelButton
        nb.setItems([navItem], animated: false)
        nb.backgroundColor = .white
        nb.barTintColor = .white
        nb.isTranslucent = false
        nb.translatesAutoresizingMaskIntoConstraints = false
        return nb
    }()
    
    let doneButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        btn.isEnabled = false
        return btn
    }()
    
    let cancelButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        return btn
    }()
    
    let workCategoryBtn: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.isSelected = false
        btn.setTitle("Work", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.addTarget(self, action: #selector(workCategorySelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let privateCategoryBtn: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.isSelected = false
        btn.setTitle("Private", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.isHighlighted = false
        btn.addTarget(self, action: #selector(privateCategorySelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let bulletDot: UIView = {
        let bullet = UIView()
        bullet.layer.cornerRadius = 5
        bullet.backgroundColor = .darkGray
        bullet.translatesAutoresizingMaskIntoConstraints = false
        return bullet
    }()
    
    lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Task title"
        tf.textAlignment = .left
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.backgroundColor = .white
        tf.borderStyle = .none
        tf.autocorrectionType = .no
        tf.clearButtonMode = .whileEditing
        tf.clearsOnBeginEditing = true
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var detailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Task details...."
        tf.textAlignment = .left
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .darkGray
        tf.autocorrectionType = .no
        tf.clearsOnBeginEditing = true
        tf.autocorrectionType = .no
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.spacing = 10
        sv.backgroundColor = .cyan
        sv.addArrangedSubview(workCategoryBtn)
        sv.addArrangedSubview(privateCategoryBtn)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    //MARK: - Variables
    weak var itemDelegate: AddItemDelegate?
    var todo: TodoItem?
    var category: String = "Work"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        titleTextField.becomeFirstResponder()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(navBar)
        self.view.addSubview(titleTextField)
        self.view.addSubview(bulletDot)
        self.view.addSubview(detailTextField)
        self.view.addSubview(separatorLine)
        self.view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            navBar.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            navBar.heightAnchor.constraint(equalToConstant: 44)
            ])
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            titleTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            titleTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25)
            ])
        
        NSLayoutConstraint.activate([
            bulletDot.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            bulletDot.leftAnchor.constraint(equalTo: titleTextField.leftAnchor),
            bulletDot.heightAnchor.constraint(equalToConstant: 10),
            bulletDot.widthAnchor.constraint(equalToConstant: 10)
            ])
        
        NSLayoutConstraint.activate([
            detailTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            detailTextField.leftAnchor.constraint(equalTo: bulletDot.rightAnchor, constant: 5),
            detailTextField.rightAnchor.constraint(equalTo: titleTextField.rightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: detailTextField.bottomAnchor, constant: 20),
            separatorLine.leftAnchor.constraint(equalTo: titleTextField.leftAnchor),
            separatorLine.rightAnchor.constraint(equalTo: titleTextField.rightAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
            ])
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 20),
            buttonStackView.leftAnchor.constraint(equalTo: separatorLine.leftAnchor),
            buttonStackView.rightAnchor.constraint(equalTo: separatorLine.rightAnchor)
            ])
    }
    
    //MARK: - Actions
    
    @objc private func workCategorySelected(_ sender: AnyObject) {
        resetCategoryButton()
        workCategoryBtn.isSelected = true
        workCategoryBtn.backgroundColor = .red
        self.category = "work"
    }
    
    @objc private func privateCategorySelected(_ sender: AnyObject) {
        resetCategoryButton()
        privateCategoryBtn.isSelected = true
        privateCategoryBtn.backgroundColor = .blue
        self.category = "private"
    }
    
    private func resetCategoryButton() {
        workCategoryBtn.isSelected = false
        privateCategoryBtn.isSelected = false
        workCategoryBtn.backgroundColor = .clear
        privateCategoryBtn.backgroundColor = .clear
    }
    
    @objc private func donePressed() {
        
        if titleTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Task is empty", message: "Please fill in the title", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
                self.titleTextField.becomeFirstResponder()
            }
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            addNewTask(titleTextField.text!, category: self.category)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func cancelPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helper methods
    
    private func addNewTask(_ title: String, category: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let task = Task(context: managedContext)
        task.title = title
        task.category = category
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
}

extension AddItemViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        doneButton.isEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}






