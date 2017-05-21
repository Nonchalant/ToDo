//
//  ToDoRepository.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import RxSwift

public protocol ToDoRepository {
    func create(with title: String) -> Single<Void>
    func find(byId id: String) -> Single<ToDo?>
    func findAll() -> Single<[ToDo]>
    func delete(byId id: String) -> Single<Void>
    func deleteAll() -> Single<Void>
}
