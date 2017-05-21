//
//  ToDo+Equatable.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation

@testable import Domain

extension ToDo: Equatable {
    public static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
    }
}
