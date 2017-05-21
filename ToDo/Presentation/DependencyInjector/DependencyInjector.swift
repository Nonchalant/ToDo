//
//  DependencyInjector.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Swinject
import Utility

public struct DependencyInjector: DependencyInjectable {
    private let defaultInjectors: [DependencyInjectable] = [
        ViewControllerDependencyInjector(),
        PresenterDependencyInjector()
    ]

    public func inject(container: Container) {
        defaultInjectors.forEach { $0.inject(container: container) }
    }

    public init() {
    }
}
