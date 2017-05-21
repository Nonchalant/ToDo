//
//  ToDoListPresenter.State+Equatable.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/29/17.
//  Copyright (c) 2017 Takeshi Ihara. All rights reserved.
//

@testable import Presentation

extension ToDoListPresenter.State: Equatable {
    public static func == (lhs: ToDoListPresenter.State, rhs: ToDoListPresenter.State) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial), (.tapedAdd, .tapedAdd), (.added, .added), (.deleted, .deleted):
            return true
        case (.prepared(let l0), .prepared(let r0)):
            return l0 == r0
        case (.failed(let l0), .failed(let r0)):
            return l0 == r0
        default:
            return false
        }
    }
}
