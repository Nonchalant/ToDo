//
//  ToDoItemTranslator.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Utility

struct ToDoItemTranslator: Translatable {
    typealias T = ToDo
    typealias U = ToDoItem

    static func translate(base: T) -> U {
        return ToDoItem(title: base.title)
    }
}
