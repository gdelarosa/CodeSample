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

class UserToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list: ToDoList?
    
    @IBOutlet weak var toDoList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.toDoList.dataSource = self
        self.toDoList.delegate = self
        fetchListData()
    }
    
    func fetchListData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/1/todos") else { return }
        URLSession.shared.dataTask(with: url) {
            (data, response , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let toDoListData = try decoder.decode(ToDo.self, from: data)

                print(toDoListData)
            } catch let error {
                print("Error", error)
            }
         }.resume()
    }
    
    //TableView Configuration
    private func configureTableView() {
        self.toDoList.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.toDoList.frame = self.view.bounds
        self.toDoList.dataSource = self
        self.view.addSubview(self.toDoList)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.list else {
            return 0
        }
        print(items.title)
        return items.title.count
    }
    
    private static let cellReuseIdentifier = "cellToDo"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as UITableViewCell
       
        return cell
    }
    
}
