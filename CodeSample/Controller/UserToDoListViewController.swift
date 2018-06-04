//
//  UserToDoListViewController.swift
//  CodeSample
//
//  Created by Gina De La Rosa on 5/30/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  A different approach to fetching and displaying JSON with a tableview

import UIKit

class UserToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todos: [Todo] = [Todo]()
    
    @IBOutlet weak var toDoList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let url = "https://jsonplaceholder.typicode.com/users/1/todos"
        ApiManager().callGetWebservice(urlString: url, completionHandler: { (todosArray) in
            self.todos = todosArray
            self.toDoList.reloadData()
            
        })
        self.toDoList.reloadData()
    }
    
    //TableView Configuration
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToCell") as! ToDoTableViewCell
        
        cell.titleLabel.text = todos[indexPath.row].title
        
        if todos[indexPath.row].completed == true {
            cell.completed?.image = UIImage(named: "checkmark")
        } else {
            cell.completed?.image = UIImage(named: "cross")
        }
        
        return cell
    }
    
}
