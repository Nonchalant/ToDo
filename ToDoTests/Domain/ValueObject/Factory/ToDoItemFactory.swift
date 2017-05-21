//
//  ToDoItemFactory.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

@testable import Domain

struct ToDoItemFactory {
    static var item: ToDoItem {
        return ToDoItem(title: "title")
    }

    static var items: [ToDoItem] {
        return Array(repeating: item, count: 3)
    }
}
