//
//  ToDoListViewModel+Equatable.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/29/17.
//  Copyright (c) 2017 Takeshi Ihara. All rights reserved.
//

@testable import Presentation

extension ToDoListViewModel: Equatable {
    public static func == (lhs: ToDoListViewModel, rhs: ToDoListViewModel) -> Bool {
        return lhs.items == rhs.items
    }
}
