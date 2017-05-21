//
//  ToDoRepository.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import RxSwift
import Domain

struct ToDoRepositoryImpl: ToDoRepository {
    private let dataStore: ToDoDataStore!

    init(dataStore: ToDoDataStore) {
        self.dataStore = dataStore
    }

    func create(with title: String) -> Single<Void> {
        do {
            try dataStore.create(with: ToDo(title: title))
            return Single.just()
        } catch {
            return Single.error(Error.create(with: error))
        }
    }

    func find(byId id: String) -> Single<Domain.ToDo?> {
        let todo = dataStore.find(byId: id).map { ToDoTranslator.translate(base: $0) }
        return Single.just(todo)
    }

    func findAll() -> Single<[Domain.ToDo]> {
        let todos = dataStore.findAll().map { ToDoTranslator.translate(base: $0) }
        return Single.just(todos)
    }

    func delete(byId id: String) -> Single<Void> {
        do {
            try dataStore.delete(byId: id)
            return Single.just()
        } catch {
            return Single.error(Error.create(with: error))
        }
    }

    func deleteAll() -> Single<Void> {
        do {
            try dataStore.deleteAll()
            return Single.just()
        } catch {
            return Single.error(Error.create(with: error))
        }
    }
}
