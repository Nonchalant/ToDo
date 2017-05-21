//
//  Translatable.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation

public protocol Translatable {
    associatedtype T
    associatedtype U

    static func translate(base: T) throws -> U
}
