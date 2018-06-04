//
//  Todo.swift
//  CodeSample
//
//  Created by Gina De La Rosa on 6/3/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  Struct model for to do list from JSONPlaceholder API endpoint: /users/1/todos

import Foundation

struct Todo {
    var id: Int
    var userId: Int
    var title: String
    var completed: Bool
}
