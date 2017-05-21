//
//  RepositoryDependencyInjector.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/21/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Swinject
import Domain
import Utility

// swiftlint:disable force_unwrapping

struct RepositoryDependencyInjector: DependencyInjectable {
    func inject(container: Container) {
        container.register(ToDoRepository.self) { r in
            ToDoRepositoryImpl(dataStore: r.resolve(ToDoDataStore.self)!)
        }
    }
}
