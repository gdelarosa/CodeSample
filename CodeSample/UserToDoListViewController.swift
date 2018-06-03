//
//  UserToDoListViewController.swift
//  CodeSample
//
//  Created by Gina De La Rosa on 5/30/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import UIKit

typealias ToDo = [ToDoList]

struct ToDoList : Codable {
    let userID, id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys : String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

class UserToDoListViewController: UIViewController, UITableViewDataSource {
    
    var feed: ToDoList?
    let tableView = UITableView.init()
    
    @IBOutlet weak var toDoList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        makeGetCall()
    }
    
    func makeGetCall() {
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
       
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
          
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                print("The todo is: " + todo.description)
                
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    //TableView Configuration
    private func configureTableView() {
        self.toDoList.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.toDoList.frame = self.view.bounds
        self.toDoList.dataSource = self
        self.view.addSubview(self.toDoList)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let feed = self.feed else {
            return 0
        }
        
        return feed.title.count
    }
    
    private static let cellReuseIdentifier = "cellToDo"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: UserToDoListViewController.cellReuseIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: UserToDoListViewController.cellReuseIdentifier)
        }
        return cell!
    }
    
}
