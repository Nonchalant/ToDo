//
//  PresenterDependencyInjector.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Swinject
import Domain
import Utility

// swiftlint:disable force_unwrapping

struct PresenterDependencyInjector: DependencyInjectable {
    func inject(container: Container) {
        // MARK: - Splash
        container.register(SplashPresenter.self) { _ in
            SplashPresenter()
        }

        // MARK: - Main
        container.register(ToDoListPresenter.self) { r in
            ToDoListPresenter(useCase: r.resolve(ToDoUseCase.self)!)
        }
    }
}
