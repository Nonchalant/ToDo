//
//  ToDoFactory.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation

@testable import Infrastructure

struct ToDoFactory {
    static var todo: ToDo {
        return ToDo(id: "id", title: "title")
    }

    static var todos: [ToDo] {
        return Array(repeating: todo, count: 3)
    }
}
