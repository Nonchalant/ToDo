//
//  ViewControllerDependencyInjector.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import Utility

// swiftlint:disable force_unwrapping

struct ViewControllerDependencyInjector: DependencyInjectable {
    func inject(container: Container) {
        // MARK: - Splash
        container.storyboardInitCompleted(SplashViewController.self) { r, c in
            c.presenter = r.resolve(SplashPresenter.self)!
        }

        // MARK: - Main
        container.storyboardInitCompleted(ToDoListViewController.self) { r, c in
            c.presenter = r.resolve(ToDoListPresenter.self)!
        }
    }
}
