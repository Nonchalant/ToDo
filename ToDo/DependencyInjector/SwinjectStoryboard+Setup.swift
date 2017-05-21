//
//  SwinjectStoryboard+Setup.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import Presentation
import Domain
import Infrastructure
import Utility

extension SwinjectStoryboard {
    class func setup() {
        let defaultInjectors: [DependencyInjectable] = [
            Presentation.DependencyInjector(),
            Domain.DependencyInjector(),
            Infrastructure.DependencyInjector()
        ]

        defaultInjectors.forEach {
            $0.inject(container: defaultContainer)
        }
    }
}
