//
//  Log.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/21/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import SwiftyBeaver

public typealias Log = SwiftyBeaver

extension Log {
    public static func setup() {
        Log.addDestination(ConsoleDestination())
    }
}
