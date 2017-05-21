//
//  Mock.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

@testable import Utility
@testable import Presentation

struct Mock {
    static var container: Container {
        let container = Container()

        let injector: [DependencyInjectable] = [
            Presentation.DependencyInjector()
        ]

        injector.forEach { $0.inject(container: container) }

        return container
    }

    static func storyboard(name: String) -> SwinjectStoryboard {
        return SwinjectStoryboard.create(name: name, bundle: nil, container: container)
    }
}
