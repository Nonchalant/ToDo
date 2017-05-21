//
//  Mock.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Swinject

@testable import Utility
@testable import Infrastructure

struct Mock {
    static var container: Container {
        let container = Container()

        let injector: [DependencyInjectable] = [
            DependencyInjector()
        ]

        injector.forEach { $0.inject(container: container) }

        return container
    }
}
