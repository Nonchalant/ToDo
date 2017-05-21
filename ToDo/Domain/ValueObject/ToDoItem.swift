//
//  ToDoItem.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation

public struct ToDoItem {
    public let title: String
}

extension ToDoItem: Equatable {
    public static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.title == rhs.title
    }
}
