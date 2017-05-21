//
//  UseCaseDependencyInjector.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/21/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Swinject
import Utility

// swiftlint:disable force_unwrapping

struct UseCaseDependencyInjector: DependencyInjectable {
    func inject(container: Container) {
        container.register(ToDoUseCase.self) { r in
            ToDoUseCaseImpl(repository: r.resolve(ToDoRepository.self)!)
        }
    }
}
