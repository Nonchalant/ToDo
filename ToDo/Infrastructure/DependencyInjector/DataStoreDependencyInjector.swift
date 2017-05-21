//
//  DataStoreDependencyInjector.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/21/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import RealmSwift
import Swinject
import Utility

// swiftlint:disable force_try

struct DataStoreDependencyInjector: DependencyInjectable {
    func inject(container: Container) {
        container.register(ToDoDataStore.self) { _ in
            RealmToDoDataStore(realm: try! Realm())
        }
    }
}
