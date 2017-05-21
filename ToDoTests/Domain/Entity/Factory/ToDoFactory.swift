//
//  ToDoFactory.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright (c) 2017 Takeshi Ihara. All rights reserved.
//

@testable import Domain

struct ToDoFactory {
    static var item: ToDo {
        return ToDo(id: "id", title: "title")
    }

    static var items: [ToDo] {
        return Array(repeating: item, count: 3)
    }
}
