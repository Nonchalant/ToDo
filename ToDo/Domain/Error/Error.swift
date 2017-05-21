//
//  Error.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation

public enum Error: Swift.Error {
    case connection
    case translation
    case notFound
    case unknown
}
