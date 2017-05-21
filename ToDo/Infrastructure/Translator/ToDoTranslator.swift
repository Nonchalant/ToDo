//
//  ToDoTranslator.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Domain
import Utility

struct ToDoTranslator: Translatable {
    typealias T = ToDo
    typealias U = Domain.ToDo

    static func translate(base: T) -> U {
        return Domain.ToDo(id: base.id, title: base.title)
    }
}
